package sharpTPU.arithmetic

import spinal.core._
import spinal.lib._

/* 
    if simd === True
        P_24b(i) = A_12b(i) * B_12b(i) for i = 0 to 3

    else
        P_48b = A_24b * B_24b
 */
case class mulSIMD(Width : Int = 12) extends Component {
    val io = new Bundle {
        val simd = in Bool
        val A  = in  Bits(4 * Width bits)
        val B  = in  Bits(4 * Width bits)
        val P  = out Bits(8 * Width bits)
    }
    def Latency = 3
    // Stage 0
    val vecA = io.A.subdivideIn(4 slices)
    val vecB = io.B.subdivideIn(4 slices)

    // Stage 1
    val regA_0 = RegNext(vecA(0))
    val regA_1 = RegNext(vecA(1))
    val regA_2 = RegNext(Mux(io.simd, vecA(2), vecA(0)))
    val regA_3 = RegNext(Mux(io.simd, vecA(3), vecA(1)))
    val regB_0 = RegNext(vecB(0))
    val regB_1 = RegNext(vecB(1))
    val regB_2 = RegNext(Mux(io.simd, vecB(2), vecB(1)))
    val regB_3 = RegNext(Mux(io.simd, vecB(3), vecB(0)))

    // Stage 2
    val regP_0 = RegNext(regA_0.asUInt * regB_0.asUInt)
    val regP_1 = RegNext(regA_1.asUInt * regB_1.asUInt)
    val regP_2 = RegNext(regA_2.asUInt * regB_2.asUInt)
    val regP_3 = RegNext(regA_3.asUInt * regB_3.asUInt)

    // Stage 3
    val accumP = (regP_1 ## regP_0).asUInt + (regP_2 ## U(0, Width bits)).asUInt + (regP_3 ## U(0, Width bits)).asUInt
    assert(accumP.getBitsWidth == 4 * Width)
    val vecAcc = accumP.subdivideIn(2 slices)
    val regQ_0 = RegNext(Mux(io.simd, regP_0, vecAcc(0)))
    val regQ_1 = RegNext(Mux(io.simd, regP_1, vecAcc(1)))
    val regQ_2 = RegNext(Mux(io.simd, regP_2, U(0, 2 * Width bits)))
    val regQ_3 = RegNext(Mux(io.simd, regP_3, U(0, 2 * Width bits)))

    // Output
    io.P := (regQ_3 ## regQ_2 ## regQ_1 ## regQ_0)
}

case class mulUnit() extends Component {
    val io = new Bundle {
        val op     = in  (ArithOp)
        val A_mtsa = in  Bits(32 bits)
        val B_mtsa = in  Bits(32 bits)
        val P_mtsa = out Bits(64 bits)
    }
    def Latency = multipler.Latency + 1

    val mulWidth = 12
    val A_sub = io.A_mtsa.subdivideIn(4 slices)
    val B_sub = io.B_mtsa.subdivideIn(4 slices)
    val A_sgn = Bits(4 bits)
    val B_sgn = Bits(4 bits)
    val A_abs = Vec(Bits(mulWidth bits), 4)
    val B_abs = Vec(Bits(mulWidth bits), 4)
    val A_mul = Bits(4 * mulWidth bits)
    val B_mul = Bits(4 * mulWidth bits)

    val multipler = new mulSIMD(mulWidth)
    multipler.io.simd := io.op =/= ArithOp.FP32
    multipler.io.A := A_mul
    multipler.io.B := B_mul

    val P_sub = multipler.io.P.subdivideIn(4 slices)
    val P_sgn = Delay(A_sgn ^ B_sgn, multipler.Latency + 0)
    val P_abs = Vec(Bits(16 bits), 4)
    val P_int = Vec(SInt(16 bits), 4)
    val P_out = Bits(64 bits)

    for (i <- 0 until 4) {
        A_sgn(i) := A_sub(i).msb
        B_sgn(i) := B_sub(i).msb
        A_abs(i) := (B(0, mulWidth - 8 bits) ## A_sub(i).asSInt.abs)
        B_abs(i) := (B(0, mulWidth - 8 bits) ## B_sub(i).asSInt.abs)
        P_abs(i) := P_sub(i)(0, 16 bits)
        P_int(i) := Mux(P_sgn(i), -P_abs(i).asSInt, P_abs(i).asSInt)
    }
    when (io.op === ArithOp.INT8 || io.op === ArithOp.INT4) {
        A_mul := A_abs.asBits
        B_mul := B_abs.asBits
        P_out := P_int.asBits
    } otherwise {
        A_mul := (U(0, 4 * mulWidth - 32 bits) ## io.A_mtsa)
        B_mul := (U(0, 4 * mulWidth - 32 bits) ## io.B_mtsa)
        P_out := multipler.io.P(0, 64 bits)
    }

    io.P_mtsa := RegNext(P_out)
}

case class expnAddUnit() extends Component {
    val io = new Bundle {
        val op     = in  (ArithOp)
        val A_expn = in  Bits(8 bits)
        val A_sign = in  Bool
        val A_flag = in  (FpFlag())
        val B_expn = in  Bits(8 bits)
        val B_sign = in  Bool
        val B_flag = in  (FpFlag())
        val P_expn = out SInt(10 bits)
        val P_sign = out Bool
        val P_flag = out (FpFlag())
    }
    def Latency = 1

    val A_flag = io.A_flag
    val B_flag = io.B_flag
    val Bias = io.op.mux(
        ArithOp.FP32     -> S(-127),
        ArithOp.FP16     -> S(-15 ),
        ArithOp.FP16_MIX -> S(+97 ), // == -15 + 128 - 16
        default          -> S(0)
    )
    val P_expn = (io.A_expn.asUInt +^ io.B_expn.asUInt).expand.asSInt + Bias
    assert(P_expn.getWidth == io.P_expn.getWidth)
    val P_sign = io.A_sign ^ io.B_sign
    val P_flag = FpFlag()

    import FpFlag.{isZero, isNorm, isInf, isNaN}
    when (isNaN(A_flag) || isNaN(B_flag) || (isZero(A_flag) && isInf(B_flag)) || (isInf(A_flag) && isZero(B_flag))) {
        P_flag := FpFlag.NAN
    } elsewhen (isInf (A_flag) || isInf (B_flag)) {
        P_flag := FpFlag.INF
    } elsewhen (isZero(A_flag) || isZero(B_flag)) {
        P_flag := FpFlag.ZERO
    } otherwise {
        P_flag := FpFlag.NORM
    }

    io.P_expn := RegNext(P_expn)
    io.P_sign := RegNext(P_sign)
    io.P_flag := RegNext(P_flag)
}

import sharpTPU.Config
object mulUnitVerilog extends App {
    Config.spinal.generateVerilog(mulUnit())
}
