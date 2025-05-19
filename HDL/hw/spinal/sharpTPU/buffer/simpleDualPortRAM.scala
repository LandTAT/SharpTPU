package sharpTPU.buffer

import spinal.core._

case class simpleDualPortRAM(
    dataWidth : Int, wordWidth : Int, depth : Int, readLatency : Int = 1, ramType : String = "auto"
) extends Component {
    assert(dataWidth % wordWidth == 0)
    val wordCount = dataWidth / wordWidth
    val addrWidth = log2Up(depth)
    val io = new Bundle {
        val wr = new Bundle {
            val ena  = in  Bool
            val addr = in  UInt(addrWidth bits)
            val data = in  Bits(dataWidth bits)
            val mask = in  Bits(wordCount bits)
        }
        val rd = new Bundle {
            val ena  = in  Bool
            val addr = in  UInt(addrWidth bits)
            val data = out Bits(dataWidth bits)
        }
    }
    val ram = Array.fill(wordCount)(z_sdpram(addrWidth, wordWidth, depth, readLatency, ramType))

    for (i <- 0 until wordCount) {
        ram(i).io.ena_w  := io.wr.ena
        ram(i).io.wea    := io.wr.mask(i)
        ram(i).io.addr_w := io.wr.addr
        ram(i).io.din    := io.wr.data(i * wordWidth, wordWidth bits)
        ram(i).io.ena_r  := io.rd.ena
        ram(i).io.addr_r := io.rd.addr
        io.rd.data(i * wordWidth, wordWidth bits) := ram(i).io.dout
    }
}

case class z_sdpram(
    addr_width: Int, data_width : Int, depth : Int, latency : Int, ramType : String = "auto"
) extends BlackBox {
    assert(latency >= 1)
    assert(ramType == "auto" || ramType == "block" || ramType == "distributed" || ramType == "register")

    val generic = new Generic {
        val ADDR_WIDTH = addr_width
        val DATA_WIDTH = data_width
        val DEPTH   = depth
        val LATENCY = latency
        val RAMTYPE = ramType
    }

    val io = new Bundle {
        val clk = in Bool
        val ena_w  = in  Bool
        val wea    = in  Bool
        val addr_w = in  UInt(addr_width bits)
        val din    = in  Bits(data_width bits)
        val ena_r  = in  Bool
        val addr_r = in  UInt(addr_width bits)
        val dout   = out Bits(data_width bits)
    }
    // Map the clk
    mapCurrentClockDomain(clock = io.clk)

    // Remove io_ prefix
    noIoPrefix()

    // Add all rtl dependencies
    addRTLPath("../../../verilog/z_sdpram.v")
}

import sharpTPU.Config
object simpleDualPortRAMVerilog extends App {
    Config.spinal.generateVerilog(simpleDualPortRAM(512, 128, 32, 2, "block"))
}
