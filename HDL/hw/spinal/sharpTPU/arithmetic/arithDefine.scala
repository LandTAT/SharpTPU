package sharpTPU.arithmetic

import spinal.core._

object ArithParm {
    def FP32_fracW = 23
    def FP32_mtsaW = FP32_fracW + 1
    def FP32_mulWidth = FP32_mtsaW * 2
    def FP32_mulFracW = FP32_fracW * 2
    def FP16_fracW = 11
    def FP16_mtsaW = FP16_fracW + 1
    def FP16_mulWidth = FP16_mtsaW * 2  // Padding 1'b0 in UnPack stage
    def FP16_mulFracW = FP16_fracW * 2
    def accWidth = 56
    def accFracW = accWidth - 8
    def expWidth = 10
}

object ArithOp extends SpinalEnum {
    val FP32, FP16, FP16_MIX, INT8, INT4 = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        FP32     -> 0x1,
        FP16     -> 0x2,
        FP16_MIX -> 0x3,
        INT8     -> 0x4,
        INT4     -> 0x5
    )
}

object PackOp extends SpinalEnum {
    val INTx, FP32, FP16 = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        INTx -> 0x0,
        FP32 -> 0x1,
        FP16 -> 0x2,
    )
}

object FpFlag extends SpinalEnum {
    val ZERO, NORM, INF, NAN = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding") (
        ZERO -> 0x0,
        NORM -> 0x1,
        INF  -> 0x2,
        NAN  -> 0x3
    )
    def isZero(x : FpFlag.C) = (x === FpFlag.ZERO)
    def isNorm(x : FpFlag.C) = (x === FpFlag.NORM)
    def isInf (x : FpFlag.C) = (x === FpFlag.INF )
    def isNaN (x : FpFlag.C) = (x === FpFlag.NAN )
}
