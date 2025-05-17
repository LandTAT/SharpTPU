package sharpTPU.arithmetic

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

case class FPalignUnit(
    in0Width : Int = 48, in0FracW : Int = 46, 
    in1Width : Int = 24, in1FracW : Int = 22, 
    accWidth : Int = 56, accFracW : Int = 48
    ) extends Component {
    val io = new Bundle {
        val i_sel  = in  Bool()
        val i_mtsa = in  Bits(in0Width bits)
        val i_sign = in  Bool
        val i_nrsh = in  UInt(10 bits)
        val o_mtsa = out SInt(accWidth bits)
    }
    def Latency = 2
    assert(in0Width >= in1Width)

    val ext_f0 = accFracW - in0FracW
    val ext_i0 = accWidth - in0Width - ext_f0
    val ext_f1 = accFracW - in1FracW
    val ext_i1 = accWidth - in1Width - ext_f1

    val pipeBuilder = new NodesBuilder()
    // Stage 1
    val n1 = new pipeBuilder.Node {
        val e0_mtsa = (B(0, ext_i0 bits) ## io.i_mtsa(0, in0Width bits) ## B(0, ext_f0 bits))
        val e1_mtsa = (B(0, ext_i1 bits) ## io.i_mtsa(0, in1Width bits) ## B(0, ext_f1 bits))
        val e_mtsa = Mux(io.i_sel, e1_mtsa, e0_mtsa)
        val s_mtsa = e_mtsa.asSInt |>> io.i_nrsh
        val MTSA = insert(s_mtsa)
        val SIGN = insert(io.i_sign)
    }

    // Stage 2
    val n2 = new pipeBuilder.Node {
        // val o_mtsa = Mux(n1.SIGN, -n1.MTSA, n1(n1.MTSA))
        val o_mtsa = Mux(n1.SIGN, -n1.MTSA, n1.MTSA + 0)
        val MTSA = insert(o_mtsa)
    }

    // Output
    val n3 = new pipeBuilder.Node {
        io.o_mtsa := n2.MTSA
    }

    pipeBuilder.genStagedPipeline()
}

case class nrshUnit(K : Int = 17) extends Component {
    val io = new Bundle {
        val P_expn = in  (Vec(SInt(10 bits), K))
        val P_sign = in  (Vec(Bool         , K))
        val P_flag = in  (Vec(FpFlag()     , K))
        val P_nrsh = out (Vec(UInt(10 bits), K))
        val Q_expn = out SInt(10 bits)
        val Q_sign = out Bool
        val Q_flag = out (FpFlag())
    }
    def Latency = 3
    def max2(x : SInt, y : SInt): SInt = {
        return Mux(x > y, x, y)
    }
    assert(K == 17)

    val pipeBuilder = new NodesBuilder()

    // Stage 1
    val n1 = new pipeBuilder.Node {
        val expn = Vec(SInt(10 bits), K)
        for (i <- 0 until K) {
            expn(i) := Mux(FpFlag.isZero(io.P_flag(i)), S(1), io.P_expn(i))
        }
        val maxExpn = Vec(SInt(10 bits), 4)
        maxExpn(0) := expn.slice( 0,  4).reduceBalancedTree(max2)
        maxExpn(1) := expn.slice( 4,  8).reduceBalancedTree(max2)
        maxExpn(2) := expn.slice( 8, 12).reduceBalancedTree(max2)
        maxExpn(3) := expn.slice(12, 17).reduceBalancedTree(max2)
        val M_EXPN = insert(maxExpn)
        val P_EXPN = insert(expn)
        val P_SIGN = insert(io.P_sign.asBits)
        val P_FLAG = insert(io.P_flag)
    }

    // Stage 2
    val n2 = new pipeBuilder.Node {
        val isNaN = n1.P_FLAG.map(FpFlag.isNaN(_)).asBits
        val isInf = n1.P_FLAG.map(FpFlag.isInf(_)).asBits
        val existNaN = isNaN.orR
        val existPosInf = (isInf & ~n1.P_SIGN).orR
        val existNegInf = (isInf &  n1.P_SIGN).orR
        // val maxExpn = n1(n1.M_EXPN).reduceBalancedTree(max2)
        val maxExpn = n1.M_EXPN.reduce(max2)
        val Q_sign = Bool
        val Q_flag = FpFlag()
        when (existNaN || (existPosInf && existNegInf)) {
            Q_sign := False
            Q_flag := FpFlag.NAN
        } elsewhen (existPosInf || existNegInf) {
            Q_sign := existNegInf
            Q_flag := FpFlag.INF
        } otherwise {
            Q_sign := False
            Q_flag := FpFlag.NORM
        }
        val Q_EXPN = insert(maxExpn)
        val Q_SIGN = insert(Q_sign)
        val Q_FLAG = insert(Q_flag)
    }

    // Stage 3
    val n3 = new pipeBuilder.Node {
        val rsh = Vec(UInt(10 bits), K)
        for (i <- 0 until K) {
            rsh(i) := (n2.Q_EXPN - n1.P_EXPN(i)).asUInt
        }
        val P_NRSH = insert(rsh)
    }

    // Output
    val n4 = new pipeBuilder.Node {
        io.P_nrsh := n3.P_NRSH
        io.Q_expn := n2.Q_EXPN
        io.Q_sign := n2.Q_SIGN
        io.Q_flag := n2.Q_FLAG
    }

    pipeBuilder.genStagedPipeline()
}

import sharpTPU.Config
object alignUnitVerilog extends App {
    Config.spinal.generateVerilog(nrshUnit())
}
