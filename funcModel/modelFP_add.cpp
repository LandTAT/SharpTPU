#include <cstdio>
#include <cstring>
#include "modelFP.h"

mFP mFP_add(mFP x, mFP y)
{
    // assert x.We == y.We
    mFP z = {0};
    z.We = x.We;
    z.Wf = x.Wf;
    z.S = x.S && y.S; // 处理NaN，Inf，Zero的符号位

    const int maxE = (1 << z.We) - 1;

    if (x.isNaN || y.isNaN)
    {
        z.M = -1;
        z.E = maxE;
        z.isNaN = true;
        return z;
    }

    if (x.isInf && y.isInf && x.S != y.S)
    {
        z.M = -1;
        z.E = maxE;
        z.isNaN = true;
        return z;
    }

    if (x.isInf || y.isInf)
    {
        z.M = 0;
        z.E = maxE;
        z.isInf = true;
        return z;
    }

    if (x.isZero && y.isZero)
    {
        z.M = 0;
        z.E = 0;
        z.isZero = true;
        return z;
    }

    if (x.isZero)
    {
        return y;
    }

    if (y.isZero)
    {
        return x;
    }

    printf("before exchange\n");
    x.show();
    y.show();
    // Swap x and y, x.E >= y.E
    if (x.E < y.E)
    {
        mFP tmp = x;
        x = y;
        y = tmp;
    }
    else if (x.E == y.E && x.M < y.M)
    {
        mFP tmp = x;
        x = y;
        y = tmp;
    }

    printf("after exchange\n");
    x.show();
    y.show();

    int32_t exp_diff = x.E - y.E;
    // saturation of exp_diff
    if (exp_diff > x.Wf + 2)
        exp_diff = x.Wf + 2;

    // 对x.M和 y.M都扩展 3 位(保护位，舍入位，粘滞位)
    int64_t x_M_shift = x.M << 3;
    int64_t y_M_shift = y.M << 3;
    if (exp_diff > 2)
    {
        uint32_t mask = BIT(y.M, 0, exp_diff - 2);
        y_M_shift >>= (exp_diff - 2);
        y_M_shift |= mask ? 0x1 : 0x0; // 粘滞位
    }
    else
    {
        y_M_shift >>= exp_diff;
    }
    // exact addition
    // require normize and rounding in next stage
    z.Wf = x.Wf; // 默认 x 是大的，所以 z 的小数部分位数和 x 一样
    z.S = x.S;
    // printf("x_M_shift = %lx, y_M_shift = %lx\n", x_M_shift, y_M_shift);

    if (x.S == y.S)
    {
        z.M = x_M_shift + y_M_shift;
    }
    else
    {
        z.M = x_M_shift - y_M_shift;
    }
    z.E = x.E;
    z.show();

    return z;
}

float mFP32_add(float xx, float yy)
{
    // assert x.We == y.We == 8
    // assert x.Wf == y.Wf == 23
    mFP x = unPack(&xx);
    mFP y = unPack(&yy);

    mFP z = mFP_add(x, y);

    // z.show();

    if (z.isNaN || z.isInf || z.isZero)
    {
        return pack_FP32(z);
    }

    printf("z.M = %lx\n", z.M);

    // leading zero count
    int lzc = 0;

    for (int i = z.Wf + 4; i >= 0; --i)
    {
        if (BIT(z.M, i, 1) == 1)
        {
            break;
        }
        lzc++;
    }

    z.show();
    printf("lzc = %d\n", lzc);
    // shift
    z.M = z.M << lzc;

    z.E = z.E - lzc;

    //  Normalization

    printf("Normalization\n");
    z.show();
    uint32_t M_int = BIT(z.M, z.Wf + 3, 2); // z.M in [1, 4)
    // M_int实际上取得是z.M的符号位和进位
    if (M_int & 0x2)
    {
        printf("Normalization\n");
        z.M = z.M >> 1;
        z.E = z.E + 1;
    }

    // Round to Even
    int64_t guard_bit = BIT(z.M, 2, 1);
    int64_t round_bit = BIT(z.M, 1, 1);
    int64_t stick_bit = BIT(z.M, 0, 1);
    printf("z.M = %lx\n", z.M);
    z.M = BIT(z.M, 3, z.Wf);
    printf("z.M = %lx\n", z.M);
    if (guard_bit == 0 || (round_bit == 0 && stick_bit == 0 && z.M & 0x0))
    {
        // do nothing
    }
    else
    {
        z.M = z.M + 1;
    }

    M_int = BIT(z.M, z.Wf, 2); // z.M in [1, 4)
    // M_int实际上取得是z.M的最高两位
    if (M_int & 0x2)
    {
        printf("Normalization\n");
        z.M = z.M >> 1;
        z.E = z.E + 1;
    }

    const int maxE = (1 << z.We) - 1;

    // Underflow
    if (z.E <= 0)
    {
        z.M = 0;
        z.E = 0;
        z.isZero = true;
    }
    // Overflow
    if (z.E >= maxE)
    {
        z.M = 0;
        z.E = maxE;
        z.isInf = true;
    }

    return pack_FP32(z);
}
