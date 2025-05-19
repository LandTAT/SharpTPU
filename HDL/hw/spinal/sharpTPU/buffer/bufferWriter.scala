package sharpTPU.buffer

import spinal.core._
import spinal.lib._
import sharpTPU.arithmetic.ArithOp

case class bufferSeqWriter(addrWidth : Int = 5, inWidth : Int = 256, outWidth : Int = 512) extends Component {
    val io = new Bundle {
        val rdStm = slave  Stream(Fragment(Bits(inWidth bits)))
        val wrMem = master Stream(streamRAM_wrCmd(addrWidth, outWidth, inWidth))
        val done  = out Bool
    }
    assert(outWidth % inWidth == 0)
    val maskWidth = outWidth / inWidth

    val addr = Reg(UInt(addrWidth bits), init = U(0))
    val mask = Reg(Bits(maskWidth bits), init = B(1))

    when (io.rdStm.fire) {
        when (io.rdStm.last) {
            addr := U(0)
            mask := B(1)
        } otherwise {
            addr := Mux(mask.msb, addr + 1, addr)
            mask := mask.rotateLeft(1)
        }
    }

    io.rdStm.ready := io.wrMem.ready
    io.wrMem.valid := io.rdStm.valid
    io.wrMem.payload.addr := addr
    io.wrMem.payload.mask := mask
    io.wrMem.payload.data := io.rdStm.payload.fragment #* maskWidth
    io.done := io.rdStm.fire & io.rdStm.last
}

case class bufD_Writer(addrWidth : Int = 5, dataWidth : Int = 256) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val start = in Bool
        val rdFlw = slave  Flow(Fragment(Bits(4 * 32 bits)))
        val wrMem = master Stream(streamRAM_wrCmd(addrWidth, dataWidth, 32))
        val done  = out Bool
    }
    assert(dataWidth == 256)
    assert(dataWidth % 32 == 0)
    val maskWidth = dataWidth / 32

    val work = Reg(Bool)
    val addr = Reg(UInt(8 bits), init = U(0))
    val mask = Reg(Bits(maskWidth bits), init = B(0))
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val rdFlw = Flow(Fragment(Bits(4 * 32 bits)))
    rdFlw << io.rdFlw

    val rshN = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(2, 2 bits)
    )
    val rshA = arithMode.mux(
        ArithOp.FP32     -> U(3, 2 bits),
        ArithOp.FP16     -> U(3, 2 bits),
        ArithOp.FP16_MIX -> U(2, 2 bits),
        ArithOp.INT8     -> U(1, 2 bits),
        ArithOp.INT4     -> U(1, 2 bits)
    )
    val lshM = arithMode.mux(
        ArithOp.FP32     -> U(1, 3 bits),
        ArithOp.FP16     -> U(1, 3 bits),
        ArithOp.FP16_MIX -> U(2, 3 bits),
        ArithOp.INT8     -> U(4, 3 bits),
        ArithOp.INT4     -> U(4, 3 bits)
    )
    val mask_init = io.arith.mux(
        ArithOp.FP32     -> B(0x1, maskWidth bits),
        ArithOp.FP16     -> B(0x1, maskWidth bits),
        ArithOp.FP16_MIX -> B(0x3, maskWidth bits),
        ArithOp.INT8     -> B(0xF, maskWidth bits),
        ArithOp.INT4     -> B(0xF, maskWidth bits)
    )
    val addrBound = U(256 - 1) |>> rshN
    val last = (addr === addrBound)

    when (work) {
        addr := Mux(rdFlw.fire, addr + 1, addr)
        mask := Mux(rdFlw.fire, mask.rotateLeft(lshM), mask)
    } otherwise {
        addr := U(0)
        mask := mask_init
    }
    when (work) {
        work := Mux(rdFlw.fire, ~last, work)
    } otherwise {
        work := io.start
    }

    val data_fp32 = (rdFlw.payload.fragment(0, 32 bits)) #* maskWidth
    val data_fp16 = (rdFlw.payload.fragment(32, 16 bits) ## rdFlw.payload.fragment(0, 16 bits)) #* maskWidth
    val data_fm16 = (rdFlw.payload.fragment(0, 64 bits)) #* (maskWidth / 2)
    val data_int8 = (rdFlw.payload.fragment(0, 128 bits)) #* (maskWidth / 4)

    val wrMem = Stream(streamRAM_wrCmd(addrWidth, dataWidth, 32))
    wrMem.valid := work & rdFlw.fire
    wrMem.payload.addr := (addr |>> rshA)(0, addrWidth bits)
    wrMem.payload.mask := mask
    wrMem.payload.data := arithMode.mux(
        ArithOp.FP32     -> data_fp32,
        ArithOp.FP16     -> data_fp16,
        ArithOp.FP16_MIX -> data_fm16,
        ArithOp.INT8     -> data_int8,
        ArithOp.INT4     -> data_int8
    )

    io.wrMem << wrMem.m2sPipe()
    io.done := RegNext(work & rdFlw.fire & last, init = False)
}

import sharpTPU.Config
object bufferWriterVerilog extends App {
    Config.spinal.generateVerilog(bufferSeqWriter())
    Config.spinal.generateVerilog(bufD_Writer())
}
