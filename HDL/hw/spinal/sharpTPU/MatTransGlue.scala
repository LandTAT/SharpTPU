package sharpTPU

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi._
import sharpTPU.arithmetic.ArithOp
import sharpTPU.buffer.MatShape
import spinal.lib.bus.amba4.axi.Axi4.size

case class FragmentWidthAdapter(inWidth : Int, outWidth : Int) extends Component {
    val io = new Bundle {
        val recv = slave  Stream(Fragment(Bits( inWidth bits)))
        val send = master Stream(Fragment(Bits(outWidth bits)))
    }
    if (inWidth == outWidth) {
        io.send << io.recv
    }
    if (inWidth > outWidth) {
        assert(inWidth % outWidth == 0)
        val ratio = inWidth / outWidth
        val vecF = Stream(Vec(Fragment(Bits(outWidth bits)), size = ratio))
        for (i <- 0 until ratio) {
            vecF.payload(i).fragment := io.recv.payload.fragment(i * outWidth, outWidth bits)
            vecF.payload(i).last := (if (i == ratio - 1) io.recv.payload.last else False)
        }
        vecF.arbitrationFrom(io.recv)
        val adapter = StreamWidthAdapter(vecF, io.send)
    }
    if (inWidth < outWidth) {
        assert(outWidth % inWidth == 0)
        val ratio = outWidth / inWidth
        val vecF = Stream(Vec(Fragment(Bits(inWidth bits)), size = ratio))
        for (i <- 0 until ratio) {
            io.send.payload.fragment(i * inWidth, inWidth bits) := vecF.payload(i).fragment
        }
        io.send.payload.last := vecF.payload(ratio - 1).last
        io.send.arbitrationFrom(vecF)
        val adapter = StreamWidthAdapter(io.recv, vecF)
    }
}

case class MatTransPadZero(dataWidth : Int = 256) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val recvB = slave  Stream(Fragment(Bits(dataWidth bits)))
        val sendB = master Stream(Fragment(Bits(dataWidth bits)))
    }
    val arithMode = RegNext(io.arith)
    val select = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(3, 2 bits)
    )
    def padZero(x : Fragment[Bits]): Fragment[Bits] = {
        assert(dataWidth % x.fragment.getWidth == 0)
        val ratio = dataWidth / x.fragment.getWidth
        val elemWidth = 32 / ratio
        val elemCount = dataWidth / 32
        val y = Fragment(Bits(dataWidth bits))
        for (i <- 0 until elemCount) {
            y.fragment(i * 32, 32 bits) := B(0, 32 - elemWidth bits) ## x.fragment(i * elemWidth, elemWidth bits)
        }
        y.last := x.last
        y
    }

    val deMux = StreamDemux(io.recvB.m2sPipe(), select, 3)

    val pathFP32 = FragmentWidthAdapter(dataWidth, dataWidth)
    val pathFP16 = FragmentWidthAdapter(dataWidth, dataWidth / 2)
    val pathINT8 = FragmentWidthAdapter(dataWidth, dataWidth / 4)
    pathFP32.io.recv << deMux(0)
    pathFP16.io.recv << deMux(1)
    pathINT8.io.recv << deMux(2)
    
    val muxOut = StreamMux(select, Vec(
        pathFP32.io.send,
        pathFP16.io.send.map(padZero),
        pathINT8.io.send.map(padZero),
    ))
    io.sendB << muxOut.m2sPipe(collapsBubble = false)
}

case class MatTransDelZero(dataWidth : Int = 256) extends Component {
    val io = new Bundle {
        val arith = in (ArithOp)
        val shape = in (MatShape)
        val recvB = slave  Stream(Fragment(Bits(dataWidth bits)))
        val sendB = master Stream(Fragment(Bits(dataWidth bits)))
    }
    val arithMode = RegNext(io.arith)
    val select = arithMode.mux(
        ArithOp.FP32     -> U(0, 2 bits),
        ArithOp.FP16     -> U(1, 2 bits),
        ArithOp.FP16_MIX -> U(1, 2 bits),
        ArithOp.INT8     -> U(2, 2 bits),
        ArithOp.INT4     -> U(3, 2 bits)
    )
    def delZero(x : Fragment[Bits], ratio : Int): Fragment[Bits] = {
        assert(x.fragment.getWidth == dataWidth)
        assert(ratio >= 1)
        val elemWidth = 32 / ratio
        val elemCount = dataWidth / 32
        val y = Fragment(Bits(dataWidth / ratio bits))
        for (i <- 0 until elemCount) {
            y.fragment(i * elemWidth, elemWidth bits) := x.fragment(i * 32, elemWidth bits)
        }
        y.last := x.last
        y
    }
    def delZero2(x : Fragment[Bits]): Fragment[Bits] = delZero(x, 2)
    def delZero4(x : Fragment[Bits]): Fragment[Bits] = delZero(x, 4)

    val deMux = StreamDemux(io.recvB.m2sPipe(), select, 3)

    val pathFP32 = FragmentWidthAdapter(dataWidth / 1, dataWidth)
    val pathFP16 = FragmentWidthAdapter(dataWidth / 2, dataWidth)
    val pathINT8 = FragmentWidthAdapter(dataWidth / 4, dataWidth)
    pathFP32.io.recv << deMux(0)
    pathFP16.io.recv << deMux(1).map(delZero2)
    pathINT8.io.recv << deMux(2).map(delZero4)
    
    val muxOut = StreamMux(select, Vec(
        pathFP32.io.send,
        pathFP16.io.send,
        pathINT8.io.send
    ))
    io.sendB << muxOut.m2sPipe(collapsBubble = true)
}

import sharpTPU.Config
object MatTransGlueVerilog extends App {
    // Config.spinal.generateVerilog(FragmentWidthAdapter(64, 128))
    // Config.spinal.generateVerilog(MatTransPadZero(256))
    Config.spinal.generateVerilog(MatTransDelZero(256))
}
