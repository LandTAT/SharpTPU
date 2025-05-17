package sharpTPU.arithmetic

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

case class normRoundUnit(
     accWidth : Int = 56,  accFracW : Int = 49, 
    out0Width : Int = 24, out0FracW : Int = 23,
    out1Width : Int = 11, out1FracW : Int = 10,
    ) extends Component {
    val io = new Bundle {
        val i_sel  = in  Bool
        val i_mtsa = in  SInt(accWidth bits)
        val i_expn = in  SInt(10 bits)
        val i_sign = in  Bool
        val i_flag = in  (FpFlag())
        val o_mtsa = out UInt(out0Width bits)
        val o_expn = out SInt(10 bits)
        val o_sign = out Bool
        val o_flag = out (FpFlag())
    }
    def Latency = 4
    assert(out0Width >= out1Width)

    val pipeBuilder = new NodesBuilder()

    val n1 = new pipeBuilder.Node {
        val sign = Bool
        val flag = FpFlag()
        when (FpFlag.isNorm(io.i_flag)) {
            sign := io.i_mtsa.msb
        } otherwise {
            sign := io.i_sign
        }
        when (FpFlag.isNorm(io.i_flag) && (io.i_mtsa === 0)) {
            flag := FpFlag.ZERO
        } otherwise {
            flag := io.i_flag
        }
        val MTSA = insert(io.i_mtsa.abs)
        val EXPN = insert(io.i_expn)
        val SIGN = insert(sign)
        val FLAG = insert(flag)
        val SEL  = insert(io.i_sel)
    }

    val  accIntW =  accWidth -  accFracW
    val out0IntW = out0Width - out0FracW
    val out1IntW = out1Width - out1FracW

    val n2 = new pipeBuilder.Node {
        val ldz = CountLeadingZeroes(n1.MTSA.asBits)
        val adj = Mux(n1.SEL, S(accIntW - out1IntW), S(accIntW - out0IntW))
        val expn = n1.EXPN + adj - ldz.expand.asSInt
        val mtsa = n1.MTSA |<< ldz
        val MTSA = insert(mtsa)
        val EXPN = insert(expn)
    }

    val n3 = new pipeBuilder.Node {
        val rsh  = Mux(n2.EXPN < 1, S(1) - n2.EXPN, S(0))
        // val expn = Mux(n2.EXPN < 1, S(1) , n2(n2.EXPN))
        val expn = Mux(n2.EXPN < 1, S(1) , n2.EXPN + 0)
        val mtsa = n2.MTSA |>> rsh.asUInt
        val MTSA = insert(mtsa)
        val EXPN = insert(expn)
    }

    def round_to_even(i_mtsa : UInt, i_expn : SInt, outWidth : Int) = new Area {
        val mtsa_clip = i_mtsa(accWidth - outWidth, outWidth bits)
        val round_bit = i_mtsa(accWidth - outWidth - 1)
        val stick_bit = i_mtsa(0, accWidth - outWidth - 1 bits)
        val cond = round_bit && (stick_bit.orR || mtsa_clip.lsb)
        val o_mtsa = UInt(outWidth bits)
        val o_expn = SInt(i_expn.getWidth bits)
        when (cond) {
            o_mtsa := Mux(mtsa_clip.andR, U(1 << (outWidth - 1)), mtsa_clip + 1)
            o_expn := Mux(mtsa_clip.andR, i_expn + 1, i_expn)
        } otherwise {
            o_mtsa := mtsa_clip
            o_expn := i_expn
        }
    }

    val n4 = new pipeBuilder.Node {
        val roundUnit_0 = round_to_even(n3.MTSA, n3.EXPN, out0Width)
        val roundUnit_1 = round_to_even(n3.MTSA, n3.EXPN, out1Width)
        val MTSA = insert(Mux(n1.SEL, roundUnit_1.o_mtsa, roundUnit_0.o_mtsa))
        val EXPN = insert(Mux(n1.SEL, roundUnit_1.o_expn, roundUnit_0.o_expn))
    }

    val n5 = new pipeBuilder.Node {
        io.o_mtsa := n4.MTSA
        io.o_expn := n4.EXPN
        io.o_sign := n1.SIGN
        io.o_flag := n1.FLAG
    }
    pipeBuilder.genStagedPipeline()
}

import sharpTPU.Config
object normRoundVerilog extends App {
    Config.spinal.generateVerilog(normRoundUnit())
}
