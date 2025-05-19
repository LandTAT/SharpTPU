package sharpTPU

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axilite._
import sharpTPU.arithmetic.ArithOp
import sharpTPU.buffer.MatShape

case class axiLiteRegIF(axilCfg : AxiLite4Config) extends Component {
    val io = new Bundle {
        val saxil = slave(AxiLite4(axilCfg))
        val start = out(Bool().setAsReg().init(False))
        val arith = out (ArithOp ).setAsReg().init(ArithOp .FP32)
        val shape = out (MatShape).setAsReg().init(MatShape.M16N16K16)
        val addrA = out(UInt(40 bits).setAsReg().init(0))
        val addrB = out(UInt(40 bits).setAsReg().init(0))
        val addrC = out(UInt(40 bits).setAsReg().init(0))
        val addrD = out(UInt(40 bits).setAsReg().init(0))
        val state = in (mState())
        val nan_f = in Bits(2 bits)
        val inf_f = in Bits(2 bits)
        val ovf_i = in Bits(4 bits)
        val dot_o = in Bool
    }
    // noIoPrefix()
    // AxiLite4SpecRenamer(io.aLiteCtrl)
    val existNan = Reg(Bool, init = False)
    val existInf = Reg(Bool, init = False)
    val existOvf = Reg(Bool, init = False)

    when (io.start) {
        existNan := False
        existInf := False
        existOvf := False
    } elsewhen (io.dot_o) {
        existNan := existNan | io.arith.mux(
            ArithOp.FP32     -> io.nan_f(0),
            ArithOp.FP16     -> io.nan_f.orR,
            ArithOp.FP16_MIX -> io.nan_f.orR,
            default          -> False
        )
        existInf := existInf | io.arith.mux(
            ArithOp.FP32     -> io.inf_f(0),
            ArithOp.FP16     -> io.inf_f.orR,
            ArithOp.FP16_MIX -> io.inf_f.orR,
            default          -> False
        )
        existOvf := existOvf | io.arith.mux(
            ArithOp.INT8     -> io.ovf_i.orR,
            ArithOp.INT4     -> io.ovf_i.orR,
            default          -> False
        )
    }

    io.start.clear()
    val busCtrl = AxiLite4SlaveFactory(io.saxil)
    busCtrl.readAndWrite(io.start, address = 0x00, bitOffset = 0, documentation = "Start pulse signal")
    busCtrl.read(io.state.asBits, address = 0x00, bitOffset = 16, documentation = "Current State")

    busCtrl.readAndWrite(io.arith, address = 0x04, bitOffset = 0, documentation = "Arith Op")
    busCtrl.readAndWrite(io.shape, address = 0x04, bitOffset = 8, documentation = "Mat Shape")
    busCtrl.read(existNan, address = 0x04, bitOffset = 16, documentation = "Detected Float NaN")
    busCtrl.read(existInf, address = 0x04, bitOffset = 17, documentation = "Detected Float Inf")
    busCtrl.read(existOvf, address = 0x04, bitOffset = 18, documentation = "Detected Int Overflow")
    
    busCtrl.readAndWrite(io.addrA(31 downto 0 ), address = 0x08, bitOffset = 0, documentation = "Address A[31: 0]")
    busCtrl.readAndWrite(io.addrA(39 downto 32), address = 0x0C, bitOffset = 0, documentation = "Address A[39:32]")
    busCtrl.readAndWrite(io.addrB(31 downto 0 ), address = 0x10, bitOffset = 0, documentation = "Address B[31: 0]")
    busCtrl.readAndWrite(io.addrB(39 downto 32), address = 0x14, bitOffset = 0, documentation = "Address B[39:32]")
    busCtrl.readAndWrite(io.addrC(31 downto 0 ), address = 0x18, bitOffset = 0, documentation = "Address C[31: 0]")
    busCtrl.readAndWrite(io.addrC(39 downto 32), address = 0x1C, bitOffset = 0, documentation = "Address C[39:32]")
    busCtrl.readAndWrite(io.addrD(31 downto 0 ), address = 0x20, bitOffset = 0, documentation = "Address D[31: 0]")
    busCtrl.readAndWrite(io.addrD(39 downto 32), address = 0x24, bitOffset = 0, documentation = "Address D[39:32]")
    
    busCtrl.printDataModel()
}
    
object axi4LiteFactoryApp extends App {
    val axil_cfg = AxiLite4Config(
        40, 32
    )
    Config.spinal.generateVerilog(axiLiteRegIF(axil_cfg))
}
