package sharpTPU.arithmetic

import spinal.core._
import spinal.lib._

case class dotProdUnit(K : Int = 16) extends Component {
    val io = new Bundle {
        val op   = in  (ArithOp)
        val vecA = in  Bits(K * 32 bits)
        val vecB = in  Bits(K * 32 bits)
        val vecC = in  Bits(4 * 32 bits)
        val vecD = out Bits(4 * 32 bits)
        val nan_f = out Bits(2 bits)
        val inf_f = out Bits(2 bits)
        val ovf_i = out Bits(4 bits)
    }
    // assert(mulUnit().Latency == expnAddUnit().Latency + nrshUnit().Latency)

    val arithMode = RegNext(io.op)
    val isIntMode = arithMode === ArithOp.INT4 || arithMode === ArithOp.INT8
    val ABpackMode = Reg(PackOp())
    val CDpackMode = Reg(PackOp())
    switch (arithMode) {
        is (ArithOp.FP32) {
            ABpackMode := PackOp.FP32
            CDpackMode := PackOp.FP32
        }
        is (ArithOp.FP16) {
            ABpackMode := PackOp.FP16
            CDpackMode := PackOp.FP16
        }
        is (ArithOp.FP16_MIX) {
            ABpackMode := PackOp.FP16
            CDpackMode := PackOp.FP32
        }
        default {
            ABpackMode := PackOp.INTx
            CDpackMode := PackOp.INTx
        }
    }

    val vecA = io.vecA.subdivideIn(K slices)
    val vecB = io.vecB.subdivideIn(K slices)
    val vecC = io.vecC.subdivideIn(4 slices)

    val unpackerA = Array.fill(K)(unPackUnit())
    val unpackerB = Array.fill(K)(unPackUnit())
    val pathCInst = vecCPath()
    val mulAB = Array.fill(K)(mulUnit())
    val expAB = Array.fill(2, K)(expnAddUnit())
    val nrshP = Array.fill(2)(nrshUnit(K + 1))
    val alignerFP_P = Array.fill(2, K)(
        FPalignUnit(
            ArithParm.FP32_mulWidth, ArithParm.FP32_mulFracW, 
            ArithParm.FP16_mulWidth, ArithParm.FP16_mulFracW, 
            ArithParm.accWidth     , ArithParm.accFracW
    ))
    val alignerFP_C = Array.fill(2)(
        FPalignUnit(
            ArithParm.FP32_mtsaW, ArithParm.FP32_fracW, 
            ArithParm.FP16_mtsaW, ArithParm.FP16_fracW, 
            ArithParm.accWidth  , ArithParm.accFracW
    ))
    val addTreeInst = Array.fill(2)(adderTree(ArithParm.accWidth, K + 1))

    for (k <- 0 until K) {
        unpackerA(k).io.op := ABpackMode
        unpackerB(k).io.op := ABpackMode
        unpackerA(k).io.xf := vecA(k)
        unpackerB(k).io.xf := vecB(k)
        mulAB(k).io.op     := arithMode
        mulAB(k).io.A_mtsa := unpackerA(k).io.mtsa
        mulAB(k).io.B_mtsa := unpackerB(k).io.mtsa
        for (i <- 0 until 2) {
            expAB(i)(k).io.op     := arithMode
            expAB(i)(k).io.A_expn := unpackerA(k).io.expn(i)
            expAB(i)(k).io.A_sign := unpackerA(k).io.sign(i)
            expAB(i)(k).io.A_flag := unpackerA(k).io.flag(i)
            expAB(i)(k).io.B_expn := unpackerB(k).io.expn(i)
            expAB(i)(k).io.B_sign := unpackerB(k).io.sign(i)
            expAB(i)(k).io.B_flag := unpackerB(k).io.flag(i)
            nrshP(i).io.P_expn(k) := expAB(i)(k).io.P_expn
            nrshP(i).io.P_sign(k) := expAB(i)(k).io.P_sign
            nrshP(i).io.P_flag(k) := expAB(i)(k).io.P_flag
        }
        alignerFP_P(0)(k).io.i_sel  := ABpackMode =/= PackOp.FP32
        alignerFP_P(0)(k).io.i_mtsa := mulAB(k).io.P_mtsa(0, ArithParm.FP32_mulWidth bits)
        alignerFP_P(1)(k).io.i_sel  := True   // Always FP16 Mode
        alignerFP_P(1)(k).io.i_mtsa := B(0, ArithParm.FP16_mulWidth bits) ## mulAB(k).io.P_mtsa(ArithParm.FP16_mulWidth, ArithParm.FP16_mulWidth bits)
        for (i <- 0 until 2) {
            alignerFP_P(i)(k).io.i_sign := Delay(expAB(i)(k).io.P_sign, nrshP(i).Latency)
            alignerFP_P(i)(k).io.i_nrsh := nrshP(i).io.P_nrsh(k)
        }
    }

    // DataPath C
    pathCInst.io.op := arithMode
    for (i <- 0 until 2) {
        pathCInst.io.vecC(i) := vecC(i)
        nrshP(i).io.P_expn(K) := pathCInst.io.c_expn(i)
        nrshP(i).io.P_sign(K) := pathCInst.io.c_sign(i)
        nrshP(i).io.P_flag(K) := pathCInst.io.c_flag(i)
        alignerFP_C(i).io.i_sel  := CDpackMode =/= PackOp.FP32
        alignerFP_C(i).io.i_mtsa := Delay(pathCInst.io.c_mtsa(i), nrshP(i).Latency)
        alignerFP_C(i).io.i_sign := Delay(pathCInst.io.c_sign(i), nrshP(i).Latency)
        alignerFP_C(i).io.i_nrsh := nrshP(i).io.P_nrsh(K)
    }

    // AdderTree Connection
    def alignInt(i_data : Bits) = new Area {
        assert(i_data.getWidth == 32)
        val vecI = i_data.subdivideIn(2 slices)
        val vecO = Vec(Bits(ArithParm.accWidth / 2 bits), 2)
        for (i <- 0 until 2) {
            vecO(i) := B"6'b0" ## (vecI(i).msb #* 6) ## vecI(i)
        }
        val o_data = RegNext(vecO.asBits)
    }
    for (i <- 0 until 2) {
        for (k <- 0 until K) {
            val alignerInt = alignInt(mulAB(k).io.P_mtsa(i * 32, 32 bits))
            addTreeInst(i).io.i_data(k) := Mux(
                isIntMode,
                alignerInt.o_data.asSInt, 
                alignerFP_P(i)(k).io.o_mtsa
            )
        }
        addTreeInst(i).io.i_data(K) := Mux(
            isIntMode,
            S(0, ArithParm.accWidth bits), alignerFP_C(i).io.o_mtsa
        )
    }

    val roundInst = Array.fill(2)(
        normRoundUnit(
            ArithParm.accWidth  , ArithParm.accFracW  , 
            ArithParm.FP32_mtsaW, ArithParm.FP32_fracW,
            11, 10
    ))
    val packer = Array.fill(2)(packUnit())
    for (i <- 0 until 2) {
        roundInst(i).io.i_sel  := CDpackMode =/= PackOp.FP32
        roundInst(i).io.i_mtsa := addTreeInst(i).io.o_data
        roundInst(i).io.i_expn := Delay(nrshP(i).io.Q_expn, 2 + 3)    // FPalign + adderTree
        roundInst(i).io.i_sign := Delay(nrshP(i).io.Q_sign, 2 + 3)
        roundInst(i).io.i_flag := Delay(nrshP(i).io.Q_flag, 2 + 3)
        packer(i).io.op   := CDpackMode
        packer(i).io.mtsa := roundInst(i).io.o_mtsa
        packer(i).io.expn := roundInst(i).io.o_expn
        packer(i).io.sign := roundInst(i).io.o_sign
        packer(i).io.flag := roundInst(i).io.o_flag
    }

    // Int C Adder
    val intAdder = Array.fill(4)(intAdderChecker())
    for (i <- 0 until 4) {
        intAdder(i).io.i_C := Delay(vecC(i).asSInt, 1 + 4 + 1 + 3)  // Pack + Mul + alignInt + adderTree
        intAdder(i).io.i_Q := addTreeInst(i / 2).io.o_data((i % 2) * 28, 22 bits)
    }

    // Outputs
    val vecD = Vec(Bits(32 bits), 4)
    vecD(0) := Mux(isIntMode, intAdder(0).io.o_D.asBits, packer(0).io.pack)
    vecD(1) := Mux(isIntMode, intAdder(1).io.o_D.asBits, packer(1).io.pack)
    vecD(2) := Mux(isIntMode, intAdder(2).io.o_D.asBits, B(0, 32 bits))
    vecD(3) := Mux(isIntMode, intAdder(3).io.o_D.asBits, B(0, 32 bits))
    io.vecD := vecD.asBits
    io.nan_f := packer(1).io.isNaN ## packer(0).io.isNaN
    io.inf_f := packer(1).io.isInf ## packer(0).io.isInf
    io.ovf_i := intAdder(3).io.ovf ## intAdder(2).io.ovf ## intAdder(1).io.ovf ## intAdder(0).io.ovf
}

case class vecCPath() extends Component {
    val io = new Bundle {
        val op     = in (ArithOp)
        val vecC   = in  (Vec(Bits(32 bits), 2))
        val c_mtsa = out (Vec(Bits(24 bits), 2))
        val c_expn = out (Vec(SInt(10 bits), 2))
        val c_sign = out (Vec(Bool, 2))
        val c_flag = out (Vec(FpFlag(), 2))
    }
    // assert(expnAddUnit().Latency == 1)

    val CDpackMode = Reg(PackOp())
    switch (io.op) {
        is (ArithOp.FP32) {
            CDpackMode := PackOp.FP32
        }
        is (ArithOp.FP16) {
            CDpackMode := PackOp.FP16
        }
        is (ArithOp.FP16_MIX) {
            CDpackMode := PackOp.FP32
        }
        default {
            CDpackMode := PackOp.INTx
        }
    }

    val unpacker = Array.fill(2)(unPackUnit())
    for (i <- 0 until 2) {
        unpacker(i).io.op := CDpackMode
        unpacker(i).io.xf := io.vecC(i)
    }
    /*
    val C0_mtsa_f32 = unpacker(0).io.mtsa( 0, 24 bits)
    val C1_mtsa_f16 = unpacker(0).io.mtsa(12, 12 bits)
    val C1_mtsa_f32 = unpacker(1).io.mtsa( 0, 24 bits)
    val C0_mtsa = C0_mtsa_f32
    val C0_expn = unpacker(0).io.expn(0)
    val C0_sign = unpacker(0).io.sign(0)
    val C0_flag = unpacker(0).io.flag(0)
    val C1_mtsa = Mux(io.op === ArithOp.FP16_MIX, C1_mtsa_f32           , B"12'b0" ## C1_mtsa_f16)
    val C1_expn = Mux(io.op === ArithOp.FP16_MIX, unpacker(1).io.expn(0), unpacker(0).io.expn(1))
    val C1_sign = Mux(io.op === ArithOp.FP16_MIX, unpacker(1).io.sign(0), unpacker(0).io.sign(1))
    val C1_flag = Mux(io.op === ArithOp.FP16_MIX, unpacker(1).io.flag(0), unpacker(0).io.flag(1))
    */
    val C0_mtsa = unpacker(0).io.mtsa(0, 24 bits)
    val C0_expn = unpacker(0).io.expn(0)
    val C0_sign = unpacker(0).io.sign(0)
    val C0_flag = unpacker(0).io.flag(0)
    val C1_mtsa = unpacker(1).io.mtsa(0, 24 bits)
    val C1_expn = unpacker(1).io.expn(0)
    val C1_sign = unpacker(1).io.sign(0)
    val C1_flag = unpacker(1).io.flag(0)

    io.c_mtsa(0) := RegNext(C0_mtsa)
    io.c_expn(0) := RegNext(B"2'b0" ## C0_expn).asSInt
    io.c_sign(0) := RegNext(C0_sign)
    io.c_flag(0) := RegNext(C0_flag)
    io.c_mtsa(1) := RegNext(C1_mtsa)
    io.c_expn(1) := RegNext(B"2'b0" ## C1_expn).asSInt
    io.c_sign(1) := RegNext(C1_sign)
    io.c_flag(1) := RegNext(C1_flag)
}

import sharpTPU.Config
object dotProdUnitVerilog extends App {
    Config.spinal.generateVerilog(dotProdUnit())
}
