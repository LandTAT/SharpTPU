package sharpTPU.buffer

import spinal.core._
import spinal.lib._

case class streamRAM_wrCmd(addrWidth : Int, dataWidth : Int, wordWidth : Int) extends Bundle {
    assert(dataWidth % wordWidth == 0)
    val maskWidth = dataWidth / wordWidth
    val addr = UInt(addrWidth bits)
    val mask = Bits(maskWidth bits)
    val data = Bits(dataWidth bits)
}

case class streamSdpRAM(
    dataWidth : Int, wordWidth : Int, depth : Int, readLatency : Int = 1, ramType : String = "auto"
) extends Component {
    assert(readLatency >= 1)
    val addrWidth = log2Up(depth)
    val io = new Bundle {
        val aw = slave (Stream(streamRAM_wrCmd(addrWidth, dataWidth, wordWidth)))
        val ar = slave (Stream(UInt(addrWidth bits)))
        val rd = master(Stream(Bits(dataWidth bits)))
    }

    val ram = simpleDualPortRAM(dataWidth, wordWidth, depth, readLatency, ramType)

    val r_ena = Bool
    val arvld_delay = Vec(Bool, readLatency + 1)
    arvld_delay(0) := io.ar.valid
    for (i <- 1 to readLatency) {
        arvld_delay(i) := RegNextWhen(arvld_delay(i - 1), cond = r_ena, init = False)
    }
    r_ena := ~arvld_delay(readLatency) | io.rd.ready

    io.aw.ready    := True
    ram.io.wr.ena  := io.aw.valid
    ram.io.wr.addr := io.aw.payload.addr
    ram.io.wr.data := io.aw.payload.data
    ram.io.wr.mask := io.aw.payload.mask
    ram.io.rd.ena  := r_ena
    ram.io.rd.addr := io.ar.payload
    io.rd.payload := ram.io.rd.data
    io.rd.valid   := arvld_delay(readLatency)
    io.ar.ready   := r_ena
}

import sharpTPU.Config
object streamSdpRAMVerilog extends App {
    Config.spinal.generateVerilog(streamSdpRAM(512, 128, 32, 2, "block"))
}
