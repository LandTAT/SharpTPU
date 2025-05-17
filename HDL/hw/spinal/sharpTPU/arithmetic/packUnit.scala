package sharpTPU.arithmetic

import spinal.core._
import spinal.core

case class unPackUnit() extends Component {
    val io = new Bundle {
        val op   = in  (PackOp)
        val xf   = in  Bits(32 bits)
        val mtsa = out Bits(32 bits)
        val expn = out (Vec(Bits(8 bits), 2))
        val sign = out (Vec(Bool, 2))
        val flag = out (Vec(FpFlag(), 2))
    }
    def Latency = 1
    def unPack_impl(xf : Bits, fracWidth : Int, expnWidth : Int) = new Area {
        assert(xf.getWidth == 1 + expnWidth + fracWidth)
        val expn = xf(fracWidth, expnWidth bits)
        val frac = xf(0, fracWidth bits)
        val expnAllone  = expn.andR
        val expnEquZero = ~expn.orR
        val fracEquZero = ~frac.orR
        val S = xf.msb
        val E = Bits(expnWidth bits)
        val M = (B"1'b0" ## frac)
        val F = FpFlag()

        when (expnAllone) {
            E := expn
            M.msb := False
            F := Mux(fracEquZero, FpFlag.INF , FpFlag.NAN )
        } elsewhen (expnEquZero) {
            E := 1
            M.msb := False
            F := Mux(fracEquZero, FpFlag.ZERO, FpFlag.NORM)
        } otherwise {
            E := expn
            M.msb := True
            F := FpFlag.NORM
        }
    }

    val fp32 = unPack_impl(io.xf, 23, 8)
    val fp16_0 = unPack_impl(io.xf( 0, 16 bits), 10, 5)
    val fp16_1 = unPack_impl(io.xf(16, 16 bits), 10, 5)

    val mtsa = Bits(32 bits)
    val expn = Vec(Bits(8 bits), 2)
    val sign = Vec(Bool, 2)
    val flag = Vec(FpFlag(), 2)

    switch(io.op) {
        is(PackOp.FP32) {
            mtsa := (B"8'b0" ## fp32.M)
            expn(0) := fp32.E
            sign(0) := fp32.S
            flag(0) := fp32.F
            expn(1) := B"8'b0"
            sign(1) := False
            flag(1) := FpFlag.ZERO
        }
        is(PackOp.FP16) {
            mtsa := (B"8'b0" ## fp16_1.M ## B"1'b0" ## fp16_0.M ## B"1'b0")
            expn(0) := (B"3'b0" ## fp16_0.E)
            sign(0) := fp16_0.S
            flag(0) := fp16_0.F
            expn(1) := (B"3'b0" ## fp16_1.E)
            sign(1) := fp16_1.S
            flag(1) := fp16_1.F
        }
        // Cover PackOp.INTx
        default {
            mtsa := io.xf
            expn(0) := B"8'b0"
            sign(0) := False
            flag(0) := FpFlag.ZERO
            expn(1) := B"8'b0"
            sign(1) := False
            flag(1) := FpFlag.ZERO
        }
    }
    io.mtsa    := RegNext(mtsa   )
    io.expn(0) := RegNext(expn(0))
    io.sign(0) := RegNext(sign(0))
    io.flag(0) := RegNext(flag(0))
    io.expn(1) := RegNext(expn(1))
    io.sign(1) := RegNext(sign(1))
    io.flag(1) := RegNext(flag(1))
}

case class packUnit() extends Component {
    val io = new Bundle {
        val op   = in  (PackOp)
        val mtsa = in  UInt(24 bits)
        val expn = in  SInt(10 bits)
        val sign = in  Bool
        val flag = in  (FpFlag())
        val pack  = out Bits(32 bits)
        val isNaN = out Bool
        val isInf = out Bool
    }
    def Latency = 1
    def pack_impl(
            mtsa : UInt, expn : SInt, sign : Bool, flag : FpFlag.C,
            fracWidth : Int, expnWidth : Int
        ) = new Area {
        assert(mtsa.getWidth == fracWidth + 1)
        val allOneE = (1 << expnWidth) - 1
        val isNaN = FpFlag.isNaN(flag)
        val isInf = ~isNaN && (FpFlag.isInf(flag) || expn >= allOneE)
        val isZero = mtsa === 0
        val y_frac = Bits(fracWidth bits)
        val y_expn = Bits(expnWidth bits)
        when (isNaN) {
            y_frac.setAll()
            y_expn.setAll()
        } elsewhen(isInf) {
            y_frac.clearAll()
            y_expn.setAll()
        } elsewhen(isZero) {
            y_frac.clearAll()
            y_expn.clearAll()
        } elsewhen(expn === 1 && ~mtsa.msb) {
            y_frac := mtsa(0, fracWidth bits).asBits
            y_expn.clearAll()
        } otherwise {
            y_frac := mtsa(0, fracWidth bits).asBits
            y_expn := expn(0, expnWidth bits).asBits
        }
        val y_pack = (sign ## y_expn ## y_frac)
    }

    val fp32 = pack_impl(io.mtsa,             io.expn, io.sign, io.flag, 23, 8)
    val fp16 = pack_impl(io.mtsa(0, 11 bits), io.expn, io.sign, io.flag, 10, 5)

    val yPack = Bits(32 bits)
    val isNaN = Bool
    val isInf = Bool

    switch(io.op) {
        is(PackOp.FP32) {
            yPack := fp32.y_pack
            isNaN := fp32.isNaN
            isInf := fp32.isInf
        }
        is(PackOp.FP16) {
            yPack := B"16'b0" ## fp16.y_pack
            isNaN := fp16.isNaN
            isInf := fp16.isInf
        }
        // Cover PackOp.INTx
        default {
            yPack := 0
            isNaN := False
            isInf := False
        }
    }
    io.pack  := RegNext(yPack)
    io.isNaN := RegNext(isNaN)
    io.isInf := RegNext(isInf)
}

import sharpTPU.Config
object unPackVerilog extends App {
    Config.spinal.generateVerilog(packUnit())
}
