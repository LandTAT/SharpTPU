package sharpTPU

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
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

case class ram_t2p(addr_width: Int = 7, data_width: Int = 256) extends Component {
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
        when(count === (sizeN)) {
          goto(input)
        }
      }
  }


}

object MxNOp extends SpinalEnum {
    val Default, M16N16K16, M32N8K16, M8N32K16 = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        Default   -> 0x0,
        M16N16K16 -> 0x1,
        M32N8K16  -> 0x2,
        M8N32K16  -> 0x3
    )
}

case class MatTransMxNStream(sizePE: Int = 8, width: Int = 32) extends Component {
  val io = new Bundle {
    val input = slave Stream(Bits(width * sizePE bits))
    val output = master Stream(Fragment(Bits(width * sizePE bits)))
    val op = in (MxNOp)
  }
  val peArray = Array.fill(2)(MatTransNxNStream(sizePE, width))
  val addr_width = 6    // 7
  val memory = ram_t2p(addr_width, 8 * width)
  val sizeMode = RegNext(io.op)

  val sizeN = Reg(UInt(addr_width bits)) init(16)
  val sizeK = Reg(UInt(addr_width bits)) init(16)
  val sizeN_bits = Reg(UInt(addr_width bits)) init(4)
  val blocksInRow_bits = Reg(UInt(addr_width bits)) init(2)
  switch(sizeMode) {
    is(MxNOp.M16N16K16) {
      sizeN := 16
      sizeK := 16
      sizeN_bits := log2Up(16)
      blocksInRow_bits := log2Up(2)
    }
    is(MxNOp.M32N8K16) {
      sizeN := 8
      sizeK := 16
      sizeN_bits := log2Up(8)
      blocksInRow_bits := log2Up(1)
    }
    is(MxNOp.M8N32K16) {
      sizeN := 32
      sizeK := 16
      sizeN_bits := log2Up(32)
      blocksInRow_bits := log2Up(4)
    }
  } 
  

  def count2Addr(count: UInt, sizeN_bits: UInt, blocksInRow_bits: UInt, sizePE: Int = 8): UInt = {
    val sizePE_bits = log2Up(sizePE)       // 计算 log2(sizePE)，如 log2(8)=3
    
    // 使用移位代替除法
    val blockRow = (count >> sizeN_bits).resize(addr_width)  // count / sizeN
    val blockCol = (count & ((U(1) << blocksInRow_bits) - 1).resize(addr_width)).resize(addr_width)  // count % blocksInRow
    
    // 构建块起始地址
    val blockStartAddrInMem = ((blockRow << blocksInRow_bits) + blockCol << sizePE_bits).resize(addr_width)
    
    // 计算块内偏移
    val targetAddrInBlock = ((count >> blocksInRow_bits) - (blockRow << sizePE_bits)).resize(addr_width)
    
    // 最终地址
    val targetAddrInMem = (blockStartAddrInMem + targetAddrInBlock).resize(addr_width)
    targetAddrInMem
  }

  
  // val lastAddr = Reg(UInt(addr_width bits)) init(0)
  val fsm = new StateMachine {
    val idle = new State with EntryPoint
    val loadData2Mem = new State 
    val process = new State
    val output = new State
    // 默认值设置
    memory.disablePort(0)
    memory.disablePort(1)

    io.input.ready := False
    io.output.valid := False
    io.output.fragment := 0
    io.output.last := False

    peArray.foreach(pe =>{
      pe.io.input.valid := False
      pe.io.output.ready := False
      pe.io.input.payload := 0
    })

    val count = Reg(UInt(addr_width bits)) init(0)
    val countBlock = Reg(UInt(addr_width bits)) init(0)

    idle
      .whenIsActive {
        when(sizeMode =/= MxNOp.Default) {
          goto(loadData2Mem)
        }
      }


    loadData2Mem
      .onEntry {
        count := 0
        countBlock := 0
        io.input.ready := True
      }
      .whenIsActive {
        io.input.ready := True
        when(io.input.valid) {
          memory.setupPortWrite(0, count2Addr(count, sizeN_bits, blocksInRow_bits, sizePE), io.input.payload)
          count := count + 1
        } 
        when(count === (sizeN >> U(log2Up(sizePE)).resize(addr_width)) * sizeK - 1) {
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
          
          memory.setupPortRead(0, (count + sizePE * countBlock ).resized)
          memory.setupPortRead(1, (count + sizePE * countBlock + sizeN ).resized)
          
        }
        when(count =/= 0) {
          // 这里是为了避免在第0个周期就开始读取数据,打一拍
          for (i <- 0 until 2) {
            peArray(i).io.input.payload := memory.io.ports(i).dout
            peArray(i).io.input.valid := True
          }
        }
        when(count === sizePE) {
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
            io.output.fragment := peArray(0).io.output.payload
          } otherwise {
            peArray(0).io.output.ready := False
            peArray(1).io.output.ready := True
            io.output.fragment := peArray(1).io.output.payload
          }

        } otherwise {
          peArray(0).io.output.ready := False
          peArray(1).io.output.ready := False
        }
        io.output.valid := peArray(0).io.output.valid || peArray(1).io.output.valid

        
        when(countBlock === (sizeN >> U(log2Up(sizePE)).resize(addr_width)) - 1 && count === 2*sizePE - 1) {
          goto(idle)
          io.output.last := True
        }

        when(countBlock =/= (sizeN >> U(log2Up(sizePE)).resize(addr_width)) -1 && count === 2*sizePE - 1) {
          countBlock := countBlock + 1
          goto(process)
        }

      }

  }
}
