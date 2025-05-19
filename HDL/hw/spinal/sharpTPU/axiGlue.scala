package sharpTPU

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import sharpTPU.arithmetic.ArithOp
import sharpTPU.buffer.MatShape

case class axiARIssuer(axiCfg : Axi4Config) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val addrA = in UInt(axiCfg.addressWidth bits)
        val addrB = in UInt(axiCfg.addressWidth bits)
        val addrC = in UInt(axiCfg.addressWidth bits)
        val axiAr = master Stream(Axi4Ar(axiCfg))
    }
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)
    val lenA = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits),
        MatShape.M32N8K16  -> U(32 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits),
        MatShape.M8N32K16  -> U( 8 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits)
    )
    val lenB = shapeMode.mux(
        MatShape.M16N16K16 -> U(16 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits),
        MatShape.M32N8K16  -> U( 8 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits),
        MatShape.M8N32K16  -> U(32 * 16 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits)
    )
    val rshAB = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(3, 2 bits)
    )
    val lenC = U(256 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits)
    val rshC = arithMode.mux(
        ArithOp.FP32     -> U(0, 1 bits),
        ArithOp.FP16     -> U(1, 1 bits),
        ArithOp.FP16_MIX -> U(0, 1 bits),
        ArithOp.INT8     -> U(0, 1 bits),
        ArithOp.INT4     -> U(0, 1 bits)
    )
    val axiAr = Stream(Axi4Ar(axiCfg))

    val sel = Reg(UInt(2 bits), init = U(0))
    when (sel =/= 0) {
        sel := Mux(axiAr.ready, sel + 1, sel)
    } otherwise {
        sel := Mux(io.start, U"2'b01", U"2'b00")
    }

    axiAr.valid := sel =/= 0
    axiAr.payload.id   := U(1)
    axiAr.payload.addr := sel.mux(
        0x0 -> U(0, axiCfg.addressWidth bits),
        0x1 -> io.addrB,
        0x2 -> io.addrA,
        0x3 -> io.addrC
    )
    axiAr.payload.len  := sel.mux(
        0x0 -> U(0, axiCfg.lenWidth bits),
        0x1 -> (lenB |>> rshAB),
        0x2 -> (lenA |>> rshAB),
        0x3 -> (lenC |>> rshC )
    )
    axiAr.payload.setBurstINCR()
    axiAr.payload.setFullSize()
    axiAr.payload.setLock(B"1'b0")
    axiAr.payload.setCache(B"4'b0")
    axiAr.payload.setQos(B"4'b0")
    axiAr.payload.setProt(B"3'b010")
    if (axiCfg.useRegion)
        axiAr.payload.region := B"4'b0"
    io.axiAr << axiAr.m2sPipe()
}

case class axiAWIssuer(axiCfg : Axi4Config) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val start = in Bool
        val addrD = in UInt(axiCfg.addressWidth bits)
        val axiAw = master Stream(Axi4Aw(axiCfg))
    }
    val arithMode = RegNextWhen(io.arith, cond = io.start)
    val shapeMode = RegNextWhen(io.shape, cond = io.start)
    val lenD = U(256 * 32 / axiCfg.dataWidth - 1, axiCfg.lenWidth bits)
    val rshD = arithMode.mux(
        ArithOp.FP32     -> U(0, 1 bits),
        ArithOp.FP16     -> U(1, 1 bits),
        ArithOp.FP16_MIX -> U(0, 1 bits),
        ArithOp.INT8     -> U(0, 1 bits),
        ArithOp.INT4     -> U(0, 1 bits)
    )
    val axiAw = Stream(Axi4Aw(axiCfg))

    val work = Reg(Bool, init = False)
    when (work) {
        work := ~axiAw.ready
    } otherwise {
        work := io.start
    }

    axiAw.valid := work
    axiAw.payload.id   := U(1)
    axiAw.payload.addr := io.addrD
    axiAw.payload.len  := lenD |>> rshD
    axiAw.payload.setBurstINCR()
    axiAw.payload.setFullSize()
    axiAw.payload.setLock(B"1'b0")
    axiAw.payload.setCache(B"4'b0")
    axiAw.payload.setQos(B"4'b0")
    axiAw.payload.setProt(B"3'b010")
    if (axiCfg.useRegion)
        axiAw.payload.region := B"4'b0"
    io.axiAw << axiAw.m2sPipe()
}

case class axiRdDispatcher(axiCfg : Axi4Config) extends Component {
    val io = new Bundle {
        val axiRd = slave  Stream(Axi4R(axiCfg))
        val mat_A = master Stream(Fragment(Bits(axiCfg.dataWidth bits)))
        val mat_B = master Stream(Fragment(Bits(axiCfg.dataWidth bits)))
        val mat_C = master Stream(Fragment(Bits(axiCfg.dataWidth bits)))
    }
    
    val axiRd = Stream(Fragment(Bits(axiCfg.dataWidth bits)))
    axiRd.payload.fragment := io.axiRd.payload.data
    axiRd.payload.last     := io.axiRd.payload.last
    axiRd.valid := io.axiRd.valid
    io.axiRd.ready := axiRd.ready

    val axiRd_pipe = axiRd.s2mPipe().m2sPipe(collapsBubble = false)

    val select = Reg(UInt(2 bits), init = U"2'b00")
    when (axiRd_pipe.fire & axiRd_pipe.last) {
        select := Mux(select === U"2'b10", U"2'b00", select + 1)
    }

    val axiRd_demux = StreamDemux(axiRd_pipe, select, 3)
    io.mat_A << axiRd_demux(1)
    io.mat_B << axiRd_demux(0)
    io.mat_C << axiRd_demux(2)
}

import sharpTPU.Config
object axiGlueVerilog extends App {
    val axi_cfg = Axi4Config(
        40, 256, 5
    )
    // Config.spinal.generateVerilog(axiRdDispatcher(axi_cfg))
    Config.spinal.generateVerilog(axiARIssuer(axi_cfg))
    Config.spinal.generateVerilog(axiAWIssuer(axi_cfg))
}
