package MatTrans

import FloatMultiplier._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.core
import scala.tools.nsc.doc.html.HtmlTags.Tr
import spinal.lib.bus.amba4.axi.Axi4.size
import spinal.lib.fsm._

case class muxReg(floatConfig: FloatConfig = FloatConfig()) extends Component {
  val io = new Bundle {
    val inputH = in Bits(floatConfig.width bits) //水平方向的输入
    val inputV = in Bits(floatConfig.width bits) //垂直方向的输入
    val output = out Bits(floatConfig.width bits) //垂直方向的输出
    val selH = in Bool() //选择信号，1为水平输入，0为垂直输入
    val shiftEnb = in Bool() //移位使能信号
  }
  val reg = Reg(Bits(floatConfig.width bits)) init(0)
  when(io.shiftEnb) {
    when(io.selH) {
      reg := io.inputH
    } otherwise {
      reg := io.inputV
    }
  } otherwise {
    reg := reg
  }
  io.output := reg
}

case class MatTransNxN(sizeN: Int = 8, floatConfig: FloatConfig = FloatConfig()) extends Component {
  val io = new Bundle {
    val inReady = out Bool()
    val outReady = in Bool()
    val inValid = in Bool()
    val outValid = out Bool()
    val inBus = in Vec(Bits(floatConfig.width bits), sizeN)
    val outBus = out Vec(Bits(floatConfig.width bits), sizeN)
  }

  // val handshake = new Area {
  //   val inReady = RegInit(True)
  //   val outReady = RegInit(False)
  //   val inValid = RegInit(False)
  //   val outValid = RegInit(False)
  //   io.inReady := inReady
  //   io.outReady := outReady
  //   io.inValid := inValid
  //   io.outValid := outValid

  //   // when(io.inReady && io.inValid) {
  //   //   inReady := False
  //   //   outReady := True
  //   //   inValid := False
  //   //   outValid := True
  //   // } elsewhen(io.outReady && io.outValid) {
  //   //   inReady := True
  //   //   outReady := False
  //   //   inValid := True
  //   //   outValid := False
  //   // }
  // }

  val selH = Reg(Bool()) init(False)
  val shiftEnb = Bool()
  shiftEnb := (io.outValid && io.outReady) || (io.inValid && io.inReady)

  val datapath = new Area {
    val muxRegArray = Array.fill(sizeN, sizeN)(muxReg(floatConfig))
    for (i <- 0 until sizeN) {
      for (j <- 0 until sizeN) {
        // 如果不是最右列，连接水平方向
        muxRegArray(i)(j).io.selH := selH
        muxRegArray(i)(j).io.shiftEnb := shiftEnb
        if (j < sizeN-1) {
          muxRegArray(i)(j+1).io.inputH := muxRegArray(i)(j).io.output
        }
        // 如果不是最下行，连接垂直方向
        if (i < sizeN-1) {
          muxRegArray(i)(j).io.inputV := muxRegArray(i+1)(j).io.output
        }
      }
    }
    for (i <-0 until sizeN){
      muxRegArray(i)(0).io.inputH := io.inBus(i)
      io.outBus(sizeN -1 - i) := muxRegArray(0)(i).io.output //交换输出的MSB和LSB
      muxRegArray(sizeN-1)(i).io.inputV := 0
    } 
  }

  val fsm = new StateMachine {
    val input = new State with EntryPoint
    val output = new State
    // 默认值设置
    io.inReady := False
    io.outValid := False

    val count = Reg(UInt(sizeN bits)) init(0)
    input
      .onEntry {
        count := 0
        io.inReady := True
        selH := True
      }
      .whenIsActive {
        io.inReady := True
        when(io.inValid) {
          // shiftEnb := True
          count := count + 1
        } otherwise{
          // shiftEnb := False
        }
        when(count === (sizeN - 1)) {
          goto(output)
        }
      }
    output
      .onEntry {
        count := 0
        selH := False
      }
      .whenIsActive {
        when(io.outReady){
          count := count + 1
          io.outValid := True
          // shiftEnb := True
        } otherwise {
          // shiftEnb := False
          io.outValid := False
        }
        when(count === (sizeN - 1)) {
          goto(input)
        }
      }
  }


}

object MyTopLevelVerilog extends App {
    Config.spinal.generateVerilog(MatTransNxN())
}