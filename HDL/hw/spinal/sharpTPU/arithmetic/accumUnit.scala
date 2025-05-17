package sharpTPU.arithmetic

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

case class adderTree(Width : Int = 56, K : Int = 17) extends Component {
    val io = new Bundle {
        val i_data = in  (Vec(SInt(Width bits), K))
        val o_data = out SInt(Width bits)
    }
    def Latency = 3
    assert(K == 17)

    val pipeBuilder = new NodesBuilder()

    val n1 = new pipeBuilder.Node {
        val m_data = Vec(SInt(Width bits), 6)
        m_data(0) := io.i_data( 0) + io.i_data( 1) + io.i_data( 2)
        m_data(1) := io.i_data( 3) + io.i_data( 4) + io.i_data( 5)
        m_data(2) := io.i_data( 6) + io.i_data( 7) + io.i_data( 8)
        m_data(3) := io.i_data( 9) + io.i_data(10) + io.i_data(11)
        m_data(4) := io.i_data(12) + io.i_data(13) + io.i_data(14)
        m_data(5) := io.i_data(15) + io.i_data(16)
        val DATA = insert(m_data)
    }
    val n2 = new pipeBuilder.Node {
        val m_data = Vec(SInt(Width bits), 2)
        m_data(0) := n1.DATA( 0) + n1.DATA( 1) + n1.DATA( 2)
        m_data(1) := n1.DATA( 3) + n1.DATA( 4) + n1.DATA( 5)
        val DATA = insert(m_data)
    }
    val n3 = new pipeBuilder.Node {
        val m_data = n2.DATA(0) + n2.DATA(1)
        val DATA = insert(m_data)
    }
    val n4 = new pipeBuilder.Node {
        io.o_data := n3.DATA
    }
    pipeBuilder.genStagedPipeline()
}

case class intAdderChecker() extends Component {
    val io = new Bundle {
        val i_C = in  SInt(32 bits)
        val i_Q = in  SInt(22 bits)
        val o_D = out SInt(32 bits)
        val ovf = out Bool
    }
    def Latency = 1

    val sum = io.i_C +^ io.i_Q
    val ovf = sum(32) =/= sum(31)

    io.o_D := RegNext(sum(0, 32 bits))
    io.ovf := RegNext(ovf)
}

import sharpTPU.Config
object nrshUnitVerilog extends App {
    Config.spinal.generateVerilog(adderTree())
}
