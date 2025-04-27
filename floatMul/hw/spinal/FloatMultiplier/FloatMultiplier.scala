package FloatMultiplier

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.core

case class FloatConfig(
    expnWidth : Int = 8,
    fracWidth : Int = 23) {
    def mtsaWidth = 1 + fracWidth   // Width of mantissa
    def width = 1 + expnWidth + fracWidth
    def expnBias = (1 << (expnWidth - 1)) - 1
    def expnOnes = (1 << (expnWidth)) - 1
}

object FloatFlag extends SpinalEnum {
    val ZERO, NORM, INF, NAN = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        ZERO -> 0x0,
        NORM -> 0x1,
        INF  -> 0x2,
        NAN  -> 0x3
    )
    def isZero(x : FloatFlag.C) = (x === FloatFlag.ZERO)
    def isNorm(x : FloatFlag.C) = (x === FloatFlag.NORM)
    def isInf (x : FloatFlag.C) = (x === FloatFlag.INF )
    def isNaN (x : FloatFlag.C) = (x === FloatFlag.NAN )
}

// Hardware definition
case class FloatMultiplier(config : FloatConfig = FloatConfig()) extends Component {
    val io = new Bundle {
        val xf = in  Bits(config.width bits)
        val yf = in  Bits(config.width bits)
        val zf = out Bits(config.width bits)
    }
    def unPack(xf : Bits) = new Area {
        assert(xf.getWidth == config.width)
        
        val sign = xf.msb
        val expn = xf(config.fracWidth, config.expnWidth bits).asUInt
        val frac = xf(0, config.fracWidth bits).asUInt
        val mtsa = (B"1'b1" ## frac).asUInt
        val flag = FloatFlag()
        val expnAllone = expn === expn.getAllTrue
        val expnEquZero = expn === 0
        val fracEquZero = frac === 0

        when (expnAllone) {
            flag := Mux(fracEquZero, FloatFlag.INF , FloatFlag.NAN )
        } otherwise {
            flag := Mux(expnEquZero, FloatFlag.ZERO, FloatFlag.NORM)
        }
    }
    
    val pipeBuilder = new NodesBuilder()

    val n0 = new pipeBuilder.Node {
        val XIN = insert(io.xf)
        val YIN = insert(io.yf)
    }

    val n1 = new pipeBuilder.Node {
        val xUpack = unPack(n0.XIN)
        val yUpack = unPack(n0.YIN)
        val SIGN_X = insert(xUpack.sign)
        val EXPN_X = insert(xUpack.expn)
        val MTSA_X = insert(xUpack.mtsa)
        val FLAG_X = insert(xUpack.flag)
        val SIGN_Y = insert(yUpack.sign)
        val EXPN_Y = insert(yUpack.expn)
        val MTSA_Y = insert(yUpack.mtsa)
        val FLAG_Y = insert(yUpack.flag)
    }

    import FloatFlag.{isZero, isNorm, isInf, isNaN}
    val n2 = new pipeBuilder.Node {
        val m_sign = n1.SIGN_X ^  n1.SIGN_Y
        val m_mtsa = n1.MTSA_X *  n1.MTSA_Y
        val m_expn = n1.EXPN_X +^ n1.EXPN_Y -^ config.expnBias
        val m_flag = FloatFlag()
        when (isNaN(n1.FLAG_X) || isNaN(n1.FLAG_Y) || (isZero(n1.FLAG_X) && isInf(n1.FLAG_Y)) || (isInf(n1.FLAG_X) && isZero(n1.FLAG_Y))) {
            m_flag := FloatFlag.NAN
        } elsewhen (isInf (n1.FLAG_X) || isInf (n1.FLAG_Y)) {
            m_flag := FloatFlag.INF
        } elsewhen (isZero(n1.FLAG_X) || isZero(n1.FLAG_Y)) {
            m_flag := FloatFlag.ZERO
        } otherwise {
            m_flag := FloatFlag.NORM
        }
        assert(m_expn.getWidth == config.expnWidth + 2)
        assert(m_mtsa.getWidth == config.mtsaWidth * 2)
        val SIGN_M = insert(m_sign)
        val EXPN_M = insert(m_expn)
        val MTSA_M = insert(m_mtsa)
        val FLAG_M = insert(m_flag)
    }

    val x = Payload(Bool())

    val n3 = new pipeBuilder.Node {
        val mtsa_norm_1 = UInt(n2.MTSA_M.getWidth - 1 bits)
        val expn_norm_1 = UInt(n2.EXPN_M.getWidth bits)
        when (n2.MTSA_M(config.fracWidth * 2 + 1)) {
            mtsa_norm_1 := n2.MTSA_M(1, mtsa_norm_1.getWidth bits)
            expn_norm_1 := n2.EXPN_M + 1
        } otherwise {
            mtsa_norm_1 := n2.MTSA_M(0, mtsa_norm_1.getWidth bits)
            expn_norm_1 := n2.EXPN_M
        }

        val mtsa_round = UInt(config.mtsaWidth + 1 bits)
        val mtsa_chop = mtsa_norm_1(config.fracWidth, config.mtsaWidth bits)
        val round_bit = mtsa_norm_1(config.fracWidth - 1)
        val stick_bit = mtsa_norm_1(0, config.fracWidth - 1 bits)
        when (round_bit && (stick_bit.orR || mtsa_chop.lsb)) {
            mtsa_round := mtsa_chop +^ 1
        } otherwise {
            mtsa_round := (B"1'b0" ## mtsa_chop).asUInt
        }

        val mtsa_norm_2 = UInt(config.mtsaWidth bits)
        val expn_norm_2 = UInt(config.expnWidth + 2 bits)
        when (mtsa_round.msb) {
            mtsa_norm_2 := mtsa_round(1, config.mtsaWidth bits)
            expn_norm_2 := expn_norm_1 + 1
        } otherwise {
            mtsa_norm_2 := mtsa_round(0, config.mtsaWidth bits)
            expn_norm_2 := expn_norm_1
        }

        // val SIGN_M = insert(n2.SIGN_M())
        val EXPN_M = insert(expn_norm_2)
        val MTSA_M = insert(mtsa_norm_2)
        // val FLAG_M = insert(n2.FLAG_M())
    }

    val n4 = new pipeBuilder.Node {
        val frac = UInt(config.fracWidth bits)
        val expn = UInt(config.expnWidth bits)
        val flag = FloatFlag()
        when (isNorm(n2.FLAG_M)) {
            when (n3.EXPN_M.asSInt <= 0) {
                flag := FloatFlag.ZERO
            } elsewhen(n3.EXPN_M.asSInt >= config.expnOnes) {
                flag := FloatFlag.INF
            } otherwise {
                flag := FloatFlag.NORM
            }
        } otherwise {
            flag := n2.FLAG_M
        }
        switch (flag) {
            is (FloatFlag.ZERO) {
                frac.clearAll()
                expn.clearAll()
            }
            is (FloatFlag.NORM) {
                frac := n3.MTSA_M(0, config.fracWidth bits)
                expn := n3.EXPN_M(0, config.expnWidth bits)
            }
            is (FloatFlag.INF) {
                frac.clearAll()
                expn.setAll()
            }
            is (FloatFlag.NAN) {
                frac.setAll()
                expn.setAll()
            }
        }
        // val SIGN_M = insert(n3.SIGN_M())
        val EXPN_M = insert(expn)
        val FRAC_M = insert(frac)
        val FLAG_M = insert(flag)
    }

    val n5 = new pipeBuilder.Node {
        io.zf := n2.SIGN_M.asBits ## n4.EXPN_M.asBits ## n4.FRAC_M.asBits
    }

    pipeBuilder.genStagedPipeline()
}

object MyTopLevelVerilog extends App {
    Config.spinal.generateVerilog(FloatMultiplier())
}

/*
case class NFloat(config : FloatConfig = FloatConfig()) extends Bundle {
    val sign = out Bool()
    val expn = out UInt(config.expnWidth bits)
    val mtsa = out UInt(config.mtsaWidth bits)
    val flag = out (FloatFlag)

    def isZero = this.flag === FloatFlag.ZERO
    def isNorm = this.flag === FloatFlag.NORM
    def isInf  = this.flag === FloatFlag.INF
    def isNaN  = this.flag === FloatFlag.NAN

    def unPack(xf : Bits) : this.type = {
        assert(xf.getWidth == config.width)
        
        val fraction = xf(0, config.fracWidth bits).asBits
        val exponent = xf(config.fracWidth + 1, config.expnWidth bits).asBits
        val expnAllone = exponent === exponent.getAllTrue
        val expnEquZero = exponent === 0
        val fracEquZero = fraction === 0
        
        this.sign := xf.msb
        this.expn := exponent.asUInt
        this.mtsa := (B"1'b1" ## fraction).asUInt

        when (expnAllone) {
            this.flag := Mux(fracEquZero, FloatFlag.INF , FloatFlag.NAN )
        } otherwise {
            this.flag := Mux(expnEquZero, FloatFlag.ZERO, FloatFlag.NORM)
        }
        return this
    }
}

case class FloatUnpackerV1(config : FloatConfig = FloatConfig()) extends Component {
    val io = new Bundle {
        val xf   = in  Bits(config.width bits)
        val sign = out Bool()
        val expn = out UInt(config.expnWidth bits)
        val mtsa = out UInt(config.mtsaWidth bits)
        val flag = out (FloatFlag)
    }

    val frac = io.xf(0, config.fracWidth bits).asBits
    val expn = io.xf(config.fracWidth + 1, config.expnWidth bits).asBits

    io.sign := io.xf.msb
    io.expn := expn.asUInt
    io.mtsa := (B"1'b1" ## frac).asUInt
    when (expn === expn.getAllTrue) {
        io.flag := (frac === 0) ? FloatFlag.INF  | FloatFlag.NAN
    } otherwise {
        io.flag := (expn === 0) ? FloatFlag.ZERO | FloatFlag.NORM
    }
}

case class FloatUnpackerV2(config : FloatConfig = FloatConfig()) extends Component {
    val io = new Bundle {
        val xf = in  Bits(config.width bits)
        val nf = out (NFloat(config))
    }
    io.nf.unPack(io.xf)
}
*/

/*
object MyTopLevelVhdl extends App {
    Config.spinal.generateVhdl(FloatMultiplier())
}
*/
