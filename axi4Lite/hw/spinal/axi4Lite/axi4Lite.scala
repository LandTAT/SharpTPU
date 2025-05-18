package axi4Lite

import FloatMultiplier._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.core
import scala.tools.nsc.doc.html.HtmlTags.Tr
import spinal.lib.bus.amba4.axi.Axi4.size
import spinal.lib.fsm._
import spinal.lib.io.InOutWrapperPlayground.D
import scala.tools.nsc.doc.model.Def
import spinal.lib.bus.amba4.axilite._

case class axi4LiteFactory() extends Component {
    val io = new Bundle {
        val aLiteCtrl = slave(AxiLite4(32, 32))
        val start = out(Bool().setAsReg().init(False))
        val field = in Bits(32 bits)
        val addrA = out(UInt(40 bits).setAsReg().init(0))
        val addrB = out(UInt(40 bits).setAsReg().init(0))
        val addrC = out(UInt(40 bits).setAsReg().init(0))
        val addrD = out(UInt(40 bits).setAsReg().init(0))
    }
    noIoPrefix()
    AxiLite4SpecRenamer(io.aLiteCtrl)
    // val axiLiteCtrl = Axi4LiteCtrl(io.axiLite)
    // axiLiteCtrl.setReadData(io.dataOut)
    // axiLiteCtrl.setWriteData(io.dataIn)
    locally {
        val _ = new Area {
            io.start.clear()
            val busCtrl = AxiLite4SlaveFactory(io.aLiteCtrl)
            busCtrl.readAndWrite(io.start, address = 0x00, bitOffset = 0, documentation = "Start pulse signal")
            busCtrl.read(io.field, address = 0x04, bitOffset = 0, documentation = "Field value")
            
            busCtrl.readAndWrite(io.addrA(31 downto 0), address = 0x08, bitOffset = 0, documentation = "Address A[31:0]")
            busCtrl.readAndWrite(io.addrA(39 downto 32), address = 0x0C, bitOffset = 0, documentation = "Address A[39:32]")
            
            busCtrl.readAndWrite(io.addrB(31 downto 0), address = 0x10, bitOffset = 0, documentation = "Address B[31:0]")
            busCtrl.readAndWrite(io.addrB(39 downto 32), address = 0x14, bitOffset = 0, documentation = "Address B[39:32]")
            
            busCtrl.readAndWrite(io.addrC(31 downto 0), address = 0x18, bitOffset = 0, documentation = "Address C[31:0]")
            busCtrl.readAndWrite(io.addrC(39 downto 32), address = 0x1C, bitOffset = 0, documentation = "Address C[39:32]")
            
            busCtrl.readAndWrite(io.addrD(31 downto 0), address = 0x20, bitOffset = 0, documentation = "Address D[31:0]")
            busCtrl.readAndWrite(io.addrD(39 downto 32), address = 0x24, bitOffset = 0, documentation = "Address D[39:32]")
            
            busCtrl.printDataModel()
        }.setName("")
    }


}
    

object axi4LiteFactoryApp extends App {
    Config.spinal.generateVerilog(axi4LiteFactory())
}