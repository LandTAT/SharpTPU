package sharpTPU

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import spinal.lib.bus.amba4.axilite._
import sharpTPU.arithmetic.dotProdUnit
import sharpTPU.buffer._
import sharpTPU.arithmetic.ArithOp
import sharpTPU.buffer.MatShape

object mState extends SpinalEnum {
    val IDLE, LOAD, CALC, STORE = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        IDLE  -> 0x0,
        LOAD  -> 0x1,
        CALC  -> 0x2,
        STORE -> 0x3
    )
}

// Hardware definition
case class sharpTPUTop() extends Component {
    val axil_cfg = AxiLite4Config(
        40, 32
    )
    val axi_cfg = Axi4Config(
        40, 256, 5
    )
    val io = new Bundle {
        val cfg = slave  (AxiLite4(axil_cfg))
        val axi = master (Axi4(axi_cfg))
    }
    noIoPrefix()
    AxiLite4SpecRenamer(io.cfg)
    Axi4SpecRenamer(io.axi)

    val U_regIF = axiLiteRegIF(axil_cfg)
    val U_axiARIssuer = axiARIssuer(axi_cfg)
    val U_axiDispatch = axiRdDispatcher(axi_cfg)
    val U_bufA_Writer = bufferSeqWriter(5, axi_cfg.dataWidth, 512)
    val U_bufB_Writer = bufferSeqWriter(5, axi_cfg.dataWidth, 512)
    val U_bufC_Writer = bufferSeqWriter(5, axi_cfg.dataWidth, axi_cfg.dataWidth)

    val U_bufA = streamSdpRAM(512, axi_cfg.dataWidth, depth = 32, readLatency = 1, ramType = "distributed")
    val U_bufB = streamSdpRAM(512, axi_cfg.dataWidth, depth = 32, readLatency = 1, ramType = "distributed")
    val U_bufC = streamSdpRAM(axi_cfg.dataWidth, axi_cfg.dataWidth, depth = 32, readLatency = 1, ramType = "distributed")
    val U_bufD = streamSdpRAM(axi_cfg.dataWidth,                32, depth = 32, readLatency = 1, ramType = "distributed")

    val U_bufA_Loader = bufA_Loader(5, 512, readLatency = 1)
    val U_bufB_Loader = bufB_Loader(5, 512, readLatency = 1)
    val U_bufC_Loader = bufC_Loader(5, axi_cfg.dataWidth, readLatency = 1)
    val U_bufD_Writer = bufD_Writer(5, axi_cfg.dataWidth)
    val U_prod = dotProdUnit(K = 16)

    val U_axiAWIssuer = axiAWIssuer(axi_cfg)
    val U_bufD_Loader = bufD_Loader(5, axi_cfg.dataWidth, readLatency = 1)
    
    val U_fsm = new Area {
        val nextState = mState()
        val state = RegNext(nextState) init(mState.IDLE)
        val loaded = Reg(Bits(3 bits), init = B"3'b0")

        switch (state) {
            is (mState.IDLE) {
                nextState := Mux(U_regIF.io.start, mState.LOAD, mState.IDLE)
            }
            is (mState.LOAD) {
                nextState := Mux(loaded.andR, mState.CALC, mState.LOAD)
            }
            is (mState.CALC) {
                nextState := Mux(U_bufD_Writer.io.done, mState.STORE, mState.CALC)
            }
            is (mState.STORE) {
                nextState := Mux(io.axi.b.valid, mState.IDLE, mState.STORE)
            }
        }
        when (state === mState.LOAD) {
            loaded(0) := Mux(U_bufA_Writer.io.done, True, loaded(0))
            loaded(1) := Mux(U_bufB_Writer.io.done, True, loaded(1))
            loaded(2) := Mux(U_bufC_Writer.io.done, True, loaded(2))
        } otherwise {
            loaded := B"3'b0"
        }
    }
    U_regIF.io.state := U_fsm.state
    U_regIF.io.saxil << io.cfg
    U_axiARIssuer.io.arith := U_regIF.io.arith
    U_axiARIssuer.io.shape := U_regIF.io.shape
    U_axiARIssuer.io.start := U_fsm.state === mState.IDLE && U_fsm.nextState === mState.LOAD
    U_axiARIssuer.io.addrA := U_regIF.io.addrA
    U_axiARIssuer.io.addrB := U_regIF.io.addrB
    U_axiARIssuer.io.addrC := U_regIF.io.addrC
    U_axiARIssuer.io.axiAr >> io.axi.ar
    U_axiDispatch.io.axiRd << io.axi.r
    U_bufA_Writer.io.rdStm << U_axiDispatch.io.mat_A
    U_bufB_Writer.io.rdStm << U_axiDispatch.io.mat_B
    U_bufC_Writer.io.rdStm << U_axiDispatch.io.mat_C
    // U_bufA_Writer.io.done
    // U_bufB_Writer.io.done
    // U_bufC_Writer.io.done
    U_bufA.io.aw << U_bufA_Writer.io.wrMem
    U_bufB.io.aw << U_bufB_Writer.io.wrMem
    U_bufC.io.aw << U_bufC_Writer.io.wrMem

    U_bufA_Loader.io.arith := U_regIF.io.arith
    U_bufA_Loader.io.shape := U_regIF.io.shape
    U_bufA_Loader.io.start := U_fsm.state === mState.LOAD && U_fsm.nextState === mState.CALC
    U_bufB_Loader.io.arith := U_regIF.io.arith
    U_bufB_Loader.io.shape := U_regIF.io.shape
    U_bufB_Loader.io.start := U_fsm.state === mState.LOAD && U_fsm.nextState === mState.CALC
    U_bufC_Loader.io.arith := U_regIF.io.arith
    U_bufC_Loader.io.shape := U_regIF.io.shape
    U_bufC_Loader.io.start := U_fsm.state === mState.LOAD && U_fsm.nextState === mState.CALC
    U_bufA_Loader.io.arMem >> U_bufA.io.ar
    U_bufA_Loader.io.rdMem << U_bufA.io.rd
    U_bufB_Loader.io.arMem >> U_bufB.io.ar
    U_bufB_Loader.io.rdMem << U_bufB.io.rd
    U_bufC_Loader.io.arMem >> U_bufC.io.ar
    U_bufC_Loader.io.rdMem << U_bufC.io.rd

    U_prod.io.op   := U_regIF.io.arith
    U_prod.io.vecA := U_bufA_Loader.io.wrflw.payload.fragment
    U_prod.io.vecB := U_bufB_Loader.io.wrflw.payload.fragment
    U_prod.io.vecC := U_bufC_Loader.io.wrflw.payload.fragment
    // U_prod.io.nan_f
    // U_prod.io.inf_f
    // U_prod.io.ovf_i

    val U_delay = new Area {
        val valid_f = Delay(U_bufC_Loader.io.wrflw.valid,        15, init = False)
        val  last_f = Delay(U_bufC_Loader.io.wrflw.payload.last, 15, init = False)
        val valid_i = Delay(U_bufC_Loader.io.wrflw.valid,        10, init = False)
        val  last_i = Delay(U_bufC_Loader.io.wrflw.payload.last, 10, init = False)
        val valid = Mux(U_regIF.io.arith === ArithOp.INT8 || U_regIF.io.arith === ArithOp.INT4, valid_i, valid_f)
        val  last = Mux(U_regIF.io.arith === ArithOp.INT8 || U_regIF.io.arith === ArithOp.INT4,  last_i,  last_f)
    }
    U_bufD_Writer.io.arith := U_regIF.io.arith
    U_bufD_Writer.io.start := U_fsm.state === mState.LOAD && U_fsm.nextState === mState.CALC
    U_bufD_Writer.io.rdFlw.payload.fragment := U_prod.io.vecD
    U_bufD_Writer.io.rdFlw.payload.last := U_delay.last
    U_bufD_Writer.io.rdFlw.valid := U_delay.valid
    U_bufD_Writer.io.wrMem >> U_bufD.io.aw
    // U_bufD_Writer.io.done

    U_bufD_Loader.io.arith := U_regIF.io.arith
    U_bufD_Loader.io.shape := U_regIF.io.shape
    U_bufD_Loader.io.start := U_fsm.state === mState.CALC && U_fsm.nextState === mState.STORE
    U_bufD_Loader.io.arMem >> U_bufD.io.ar
    U_bufD_Loader.io.rdMem << U_bufD.io.rd

    U_axiAWIssuer.io.arith := U_regIF.io.arith
    U_axiAWIssuer.io.shape := U_regIF.io.shape
    U_axiAWIssuer.io.start := U_fsm.state === mState.CALC && U_fsm.nextState === mState.STORE
    U_axiAWIssuer.io.addrD := U_regIF.io.addrD
    U_axiAWIssuer.io.axiAw >> io.axi.aw
    io.axi.w.payload.data := U_bufD_Loader.io.wrStm.payload.fragment
    io.axi.w.payload.last := U_bufD_Loader.io.wrStm.payload.last
    io.axi.w.payload.strb.setAll()
    io.axi.w.valid := U_bufD_Loader.io.wrStm.valid
    U_bufD_Loader.io.wrStm.ready := io.axi.w.ready

    io.axi.b.ready := True
}

object sharpTPUTopVerilog extends App {
    Config.spinal.generateVerilog(sharpTPUTop())
}
