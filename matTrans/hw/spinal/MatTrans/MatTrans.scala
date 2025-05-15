package MatTrans

import FloatMultiplier._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.core
import scala.tools.nsc.doc.html.HtmlTags.Tr
import spinal.lib.bus.amba4.axi.Axi4.size
import spinal.lib.fsm._

case class muxReg(width: Int = 32) extends Component {
  val io = new Bundle {
    val inputH = in Bits(width bits) //水平方向的输入
    val inputV = in Bits(width bits) //垂直方向的输入
    val output = out Bits(width bits) //垂直方向的输出
    val selH = in Bool() //选择信号，1为水平输入，0为垂直输入
    val shiftEnb = in Bool() //移位使能信号
  }
  val reg = Reg(Bits(width bits)) init(0)
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

case class ram_t2p(addr_width: Int = 6, data_width: Int = 256) extends Component {
  val mem = Mem(Bits(data_width bits), 1 << addr_width)
  
  // 定义端口接口数据类型
  case class PortBundle() extends Bundle {
    val addr = in UInt(addr_width bits)
    val din = in Bits(data_width bits)
    val we = in Bool()
    val en = in Bool()
    val dout = out Bits(data_width bits)
  }
  
  val io = new Bundle {
    // 使用Vec创建两个端口
    val ports = Vec(PortBundle(), 2)
  }
  
  // 内部连接
  for (i <- 0 until 2) {
    io.ports(i).dout := mem.readWriteSync(
      io.ports(i).addr,
      io.ports(i).din,
      io.ports(i).en,
      io.ports(i).we
    )
  }
  
  // 辅助方法 - 设置为读模式
  def setupPortRead(portId: Int, addr: UInt): Unit = {
    io.ports(portId).en := True
    io.ports(portId).we := False
    io.ports(portId).addr := addr
  }
  
  // 辅助方法 - 设置为写模式
  def setupPortWrite(portId: Int, addr: UInt, data: Bits): Unit = {
    io.ports(portId).en := True
    io.ports(portId).we := True
    io.ports(portId).addr := addr
    io.ports(portId).din := data
  }
  
  // 辅助方法 - 禁用端口
  def disablePort(portId: Int): Unit = {
    io.ports(portId).en := False
    io.ports(portId).we := False
    io.ports(portId).addr := 0
    io.ports(portId).din := 0
  }
  
  // 向下兼容的访问方法 (兼容原有代码)
  def port1 = io.ports(0)
  def port2 = io.ports(1)
}

case class MatTransNxN(sizeN: Int = 8, width: Int = 32) extends Component {
  val io = new Bundle {
    val inReady = out Bool()
    val outReady = in Bool()
    val inValid = in Bool()
    val outValid = out Bool()
    val inBus = in Vec(Bits(width bits), sizeN)
    val outBus = out Vec(Bits(width bits), sizeN)
  }

  val selH = Reg(Bool()) init(False)
  val shiftEnb = Bool()
  shiftEnb := (io.outValid && io.outReady) || (io.inValid && io.inReady)

  val datapath = new Area {
    val muxRegArray = Array.fill(sizeN, sizeN)(muxReg(width))
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

case class MatTransNxNStream(sizeN: Int = 8, width: Int = 32) extends Component {
  val io = new Bundle {
    val input = slave Stream(Bits(width*sizeN bits))
    val output = master Stream(Bits(width*sizeN bits))
  }

  val selH = Reg(Bool()) init(False)
  val shiftEnb = Bool()
  shiftEnb := (io.output.valid && io.output.ready) || (io.input.valid && io.input.ready)

  val datapath = new Area {
    val muxRegArray = Array.fill(sizeN, sizeN)(muxReg(width))
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
      muxRegArray(i)(0).io.inputH := io.input.payload(i*width, width bits)
      io.output.payload((sizeN - 1 - i)*width, width bits) := muxRegArray(0)(i).io.output //交换输出的MSB和LSB
      // outBus(sizeN -1 - i) := muxRegArray(0)(i).io.output //交换输出的MSB和LSB
      muxRegArray(sizeN-1)(i).io.inputV := 0
    } 
  }

  val fsm = new StateMachine {
    val input = new State with EntryPoint
    val output = new State
    // 默认值设置
    io.input.ready := False
    io.output.valid := False


    val count = Reg(UInt(sizeN bits)) init(0)
    input
      .onEntry {
        count := 0
        io.input.ready := True
        selH := True
      }
      .whenIsActive {
        io.input.ready := True
        when(io.input.valid) {
          count := count + 1
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
        when(io.output.ready){
          count := count + 1
          io.output.valid := True
        } otherwise {
          io.output.valid := False
        }
        when(count === (sizeN - 1)) {
          goto(input)
        }
      }
  }


}

case class MatTransMxNStream(sizeM: Int = 16, sizeN: Int = 16, sizePE: Int = 8, width: Int = 32) extends Component {
  val io = new Bundle {
    val input = slave Stream(Bits(width * sizePE bits))
    val output = master Stream(Bits(width * sizePE bits))
  }
  val peArray = Array.fill(2)(MatTransNxNStream(sizePE, width))
  val addr_width = 7
  val memory = ram_t2p(7, 256)


  def count2Addr(count: UInt, sizeM: Int = 8, sizeN: Int = 8, sizePE: Int = 8): UInt = {
    // val setN = sizeN / sizePE
    // // 明确类型转换和位宽，避免隐式转换
    // val addrX = (count % U(setN, count.getWidth bits)).resized
    // val addrY = (count / U(setN, count.getWidth bits)).resized
    // // 确保最终计算结果位宽正确
    // (addrY * U(setN, addrY.getWidth bits) + addrX).resized


    // val blockNum = sizeM * sizeN / sizePE / sizePE
    val blockX = count % U(sizePE, count.getWidth bits)
    val blockY = count / U(sizePE, count.getWidth bits)
    (blockY * sizePE + blockX).resized
  }

  
  val lastAddr = sizeN / sizePE * sizeM
  val fsm = new StateMachine {
    val loadData2Mem = new State with EntryPoint
    val process = new State
    val output = new State
    // 默认值设置
    memory.disablePort(0)
    memory.disablePort(1)

    io.input.ready := False
    io.output.valid := False
    io.output.payload := 0

    peArray.foreach(pe =>{
      pe.io.input.valid := False
      pe.io.output.ready := False
      pe.io.input.payload := 0
    })

    val count = Reg(UInt(addr_width bits)) init(0)
    val countBlock = Reg(UInt(addr_width bits)) init(0)

    loadData2Mem
      .onEntry {
        count := 0
        countBlock := 0
        io.input.ready := True
      }
      .whenIsActive {
        io.input.ready := True
        when(io.input.valid) {
          memory.setupPortWrite(0, count2Addr(count, sizeM, sizeN, sizePE), io.input.payload)
          count := count + 1
        } 
        when(count === lastAddr - 1) {
          goto(process)
        }
      }
    process
      .onEntry {
        count := 0
      }
      .whenIsActive {
        when(peArray(0).io.input.ready && peArray(1).io.input.ready) {
          count := count + 1
          
          memory.setupPortRead(0, count)
          memory.setupPortRead(1, count+ sizeN)
          
          for (i <- 0 until 2) {
            peArray(i).io.input.payload := memory.io.ports(i).dout
            peArray(i).io.input.valid := True
          }

        }
        when(count === (sizePE - 1)) {
          goto(output)
        }
      }
    output
      .onEntry {
        count := 0
      }
      .whenIsActive {
        when(io.output.ready) {
          count := count + 1

          when(count(0) === False) {
            peArray(0).io.output.ready := True
            peArray(1).io.output.ready := False
            io.output.payload := peArray(0).io.output.payload
          } otherwise {
            peArray(0).io.output.ready := False
            peArray(1).io.output.ready := True
            io.output.payload := peArray(1).io.output.payload
          }

        } otherwise {
          peArray(0).io.output.ready := False
          peArray(1).io.output.ready := False
        }
        io.output.valid := peArray(0).io.output.valid || peArray(1).io.output.valid

        
        when(countBlock === (sizeM * sizeN / sizePE)){
          goto(loadData2Mem)
        }

        when(count === lastAddr / 2 - 1) {
          countBlock := countBlock + 2
          goto(process)
        }

      }

  }
}

object MyTopLevelVerilog extends App {
    Config.spinal.generateVerilog(MatTransNxN())
}

object MyTopLevelStreamVerilog extends App {
    Config.spinal.generateVerilog(MatTransNxNStream())
}

object MyTopLevelMxNStreamVerilog extends App {
    Config.spinal.generateVerilog(MatTransMxNStream())
}