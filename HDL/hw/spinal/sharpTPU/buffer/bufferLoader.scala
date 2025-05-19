package sharpTPU.buffer

import spinal.core._
import spinal.lib._
import sharpTPU.arithmetic.ArithOp

object MatShape extends SpinalEnum {
    val M16N16K16, M32N8K16, M8N32K16 = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        M16N16K16 -> 0x1,
        M32N8K16  -> 0x2,
        M8N32K16  -> 0x3
    )
}

case class bufA_Loader(addrWidth : Int = 5, dataWidth : Int = 512, readLatency : Int = 1) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val arMem = master Stream(UInt(addrWidth bits))
        val rdMem = slave  Stream(Bits(dataWidth bits))
        val wrflw = master Flow(Fragment(Bits(dataWidth bits)))
    }
    assert(dataWidth == 512)

    val work = Reg(Bool)
    val rowA = Reg(UInt(addrWidth bits), init = U(0))
    val colB = Reg(UInt(addrWidth bits), init = U(0))
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)

    val numM = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 - 1, addrWidth bits),
        MatShape.M32N8K16  -> U(32 - 1, addrWidth bits),
        MatShape.M8N32K16  -> U( 8 - 1, addrWidth bits),
    )
    val numN = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 - 1, addrWidth bits),
        MatShape.M32N8K16  -> U( 8 - 1, addrWidth bits),
        MatShape.M8N32K16  -> U(32 - 1, addrWidth bits),
    )
    val rshN = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(3, 2 bits)
    )
    val colBound = numN |>> rshN
    val last = (colB === colBound) && (rowA === numM)

    when (work) {
        rowA := Mux(colB === colBound, rowA + 1, rowA)
        colB := Mux(colB === colBound, U(0), colB + 1)
    } otherwise {
        rowA := U(0)
        colB := U(0)
    }
    when (work) {
        work := ~last
    } otherwise {
        work := io.start
    }

    val data_fp16_i = io.rdMem.payload.subdivideIn(2 slices)(Delay(rowA(0, 1 bits), readLatency))
    val data_int8_i = io.rdMem.payload.subdivideIn(4 slices)(Delay(rowA(0, 2 bits), readLatency))
    val data_fp32_o = io.rdMem.payload
    val data_fp16_o = Bits(dataWidth bits)
    val data_int8_o = Bits(dataWidth bits)
    for (i <- 0 until 16) {
        data_fp16_o(i * 32, 32 bits) := data_fp16_i(i * 16, 16 bits) #* 2
        data_int8_o(i * 32, 32 bits) := data_int8_i(i *  8,  8 bits) #* 4
    }
    val wrflw = Flow(Fragment(Bits(dataWidth bits)))
    wrflw.payload.fragment := arithMode.mux(    // INT4 is not Support
        ArithOp.FP32     -> data_fp32_o,
        ArithOp.FP16     -> data_fp16_o,
        ArithOp.FP16_MIX -> data_fp16_o,
        ArithOp.INT8     -> data_int8_o,
        ArithOp.INT4     -> data_int8_o
    )
    wrflw.payload.last := Delay(work & last, readLatency, init = False)
    wrflw.valid := io.rdMem.valid

    // True === io.arMem.ready
    io.arMem.valid := work
    io.arMem.payload := rowA |>> rshN
    io.rdMem.ready := True
    io.wrflw << wrflw.m2sPipe()
}

case class bufB_Loader(addrWidth : Int = 5, dataWidth : Int = 512, readLatency : Int = 1) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val arMem = master Stream(UInt(addrWidth bits))
        val rdMem = slave  Stream(Bits(dataWidth bits))
        val wrflw = master Flow(Fragment(Bits(dataWidth bits)))
    }
    assert(dataWidth == 512)

    val work = Reg(Bool)
    val rowA = Reg(UInt(addrWidth bits), init = U(0))
    val colB = Reg(UInt(addrWidth bits), init = U(0))
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)

    val numM = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 - 1, addrWidth bits),
        MatShape.M32N8K16  -> U(32 - 1, addrWidth bits),
        MatShape.M8N32K16  -> U( 8 - 1, addrWidth bits),
    )
    val numN = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 - 1, addrWidth bits),
        MatShape.M32N8K16  -> U( 8 - 1, addrWidth bits),
        MatShape.M8N32K16  -> U(32 - 1, addrWidth bits),
    )
    val rshN = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(3, 2 bits)
    )
    val colBound = numN |>> rshN
    val last = (colB === colBound) && (rowA === numM)

    when (work) {
        rowA := Mux(colB === colBound, rowA + 1, rowA)
        colB := Mux(colB === colBound, U(0), colB + 1)
    } otherwise {
        rowA := U(0)
        colB := U(0)
    }
    when (work) {
        work := ~last
    } otherwise {
        work := io.start
    }

    val data_fp32 = io.rdMem.payload
    val data_fp16 = Bits(dataWidth bits)
    val data_int8 = Bits(dataWidth bits)
    for (i <- 0 until 2; j <- 0 until 16) {
        data_fp16(j * 32 + i * 16, 16 bits) := io.rdMem.payload(i * 256 + j * 16, 16 bits)
    }
    for (i <- 0 until 4; j <- 0 until 16) {
        data_int8(j * 32 + i *  8,  8 bits) := io.rdMem.payload(i * 128 + j *  8,  8 bits)
    }
    val wrflw = Flow(Fragment(Bits(dataWidth bits)))
    wrflw.payload.fragment := arithMode.mux(
        ArithOp.FP32     -> data_fp32,
        ArithOp.FP16     -> data_fp16,
        ArithOp.FP16_MIX -> data_fp16,
        ArithOp.INT8     -> data_int8,
        ArithOp.INT4     -> data_int8
    )
    wrflw.payload.last := Delay(work & last, readLatency, init = False)
    wrflw.valid := io.rdMem.valid

    // True === io.arMem.ready
    io.arMem.valid := work
    io.arMem.payload := colB
    io.rdMem.ready := True
    io.wrflw << wrflw.m2sPipe()
}

case class bufC_Loader(addrWidth : Int = 5, dataWidth : Int = 256, readLatency : Int = 1) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val arMem = master Stream(UInt(addrWidth bits))
        val rdMem = slave  Stream(Bits(dataWidth bits))
        val wrflw = master Flow(Fragment(Bits(4 * 32 bits)))
    }
    assert(dataWidth == 256)

    val work = Reg(Bool)
    val addr = Reg(UInt(8 bits), init = U(0))
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)

    val rshN = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(2, 2 bits)
    )
    val addrBound = U(256 - 1) |>> rshN
    val last = (addr === addrBound)

    when (work) {
        addr := addr + 1
    } otherwise {
        addr := U(0)
    }
    when (work) {
        work := ~last
    } otherwise {
        work := io.start
    }

    val data_mux2 = io.rdMem.payload.subdivideIn(2 slices)(Delay(addr(0, 1 bits), readLatency)) // 128 Bits
    val data_mux4 = io.rdMem.payload.subdivideIn(4 slices)(Delay(addr(0, 2 bits), readLatency)) //  64 Bits
    val data_mux8 = io.rdMem.payload.subdivideIn(8 slices)(Delay(addr(0, 3 bits), readLatency)) //  32 Bits
    val wrflw = Flow(Fragment(Bits(4 * 32 bits)))
    wrflw.payload.fragment := arithMode.mux(
        ArithOp.FP32     -> B"96'b0" ## data_mux8,
        ArithOp.FP16     -> B"64'b0" ## B"16'b0" ## data_mux8(16, 16 bits) ## B"16'b0" ## data_mux8(0, 16 bits),
        ArithOp.FP16_MIX -> B"64'b0" ## data_mux4,
        ArithOp.INT8     -> data_mux2,
        ArithOp.INT4     -> data_mux2
    )
    val rshA = arithMode.mux(
        ArithOp.FP32     -> U(3, 2 bits),
        ArithOp.FP16     -> U(3, 2 bits),
        ArithOp.FP16_MIX -> U(2, 2 bits),
        ArithOp.INT8     -> U(1, 2 bits),
        ArithOp.INT4     -> U(1, 2 bits)
    )
    wrflw.payload.last := Delay(work & last, readLatency, init = False)
    wrflw.valid := io.rdMem.valid

    // True === io.arMem.ready
    io.arMem.valid := work
    io.arMem.payload := (addr |>> rshA)(0, addrWidth bits)
    io.rdMem.ready := True
    io.wrflw << wrflw.m2sPipe()
}

case class bufD_Loader(addrWidth : Int = 5, dataWidth : Int = 256, readLatency : Int = 1) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val arMem = master Stream(UInt(addrWidth bits))
        val rdMem = slave  Stream(Bits(dataWidth bits))
        val wrStm = master Stream(Fragment(Bits(dataWidth bits)))
    }
    assert(dataWidth == 256)

    val work = Reg(Bool)
    val addr = Reg(UInt(addrWidth bits), init = U(0))
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)

    val rshN = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(0, 2 bits),
        ArithOp.INT8     -> U(0, 2 bits),
        ArithOp.INT4     -> U(0, 2 bits)
    )
    val addrBound = U(32 - 1) |>> rshN
    val last = (addr === addrBound)

    when (work) {
        addr := Mux(io.arMem.ready, addr + 1, addr)
    } otherwise {
        addr := U(0)
    }
    when (work) {
        work := Mux(io.arMem.ready, ~last, work)
    } otherwise {
        work := io.start
    }

    val wrStm = Stream(Fragment(Bits(dataWidth bits)))
    wrStm.payload.fragment := io.rdMem.payload
    wrStm.payload.last := Delay(work & last, readLatency, when = io.arMem.ready, init = False)
    wrStm.valid := io.rdMem.valid

    io.arMem.valid := work
    io.arMem.payload := addr
    io.rdMem.ready := wrStm.ready
    io.wrStm << wrStm.m2sPipe()
}

import sharpTPU.Config
object bufferLoaderVerilog extends App {
    Config.spinal.generateVerilog(bufA_Loader())
    Config.spinal.generateVerilog(bufB_Loader())
    Config.spinal.generateVerilog(bufC_Loader())
    Config.spinal.generateVerilog(bufD_Loader())
}
