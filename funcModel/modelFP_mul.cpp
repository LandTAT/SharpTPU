#include <cstdio>
#include <cstring>
#include "modelFP.h"

mFP mFP_mul(mFP x, mFP y)
{
    // assert x.We == y.We
    mFP z = {0};
    // z.show();
    z.We = x.We;
    z.Wf = x.Wf;
    z.S = x.S ^ y.S;

    const int maxE = (1 << z.We) - 1;

    if (x.isNaN() || y.isNaN() || (x.isZero() && y.isInf()) || (x.isInf() && y.isZero()))
    {
        z.M = -1;
        z.E = maxE;
        z.exn = EXN_NAN;
        return z;
    }

    if (x.isInf() || y.isInf())
    {
        z.M = 0;
        z.E = maxE;
        z.exn = EXN_INF;
        return z;
    }

    if (x.isZero() || y.isZero())
    {
        z.M = 0;
        z.E = 0;
        z.exn = EXN_ZERO;
        return z;
    }

    // exact multiplication
    // require normize and rounding in next stage
    z.Wf = x.Wf + y.Wf;
    z.M = x.M * y.M;
    z.E = x.E + y.E + 1 - (1 << (z.We - 1));
    z.exn = EXN_NORM;

    return z;
}

float mFP32_mul(float xx, float yy)
{
    // assert x.We == y.We == 8
    // assert x.Wf == y.Wf == 23
    mFP x = unPack(&xx);
    mFP y = unPack(&yy);

    // printf("\n");
    // x.show();
    // y.show();
    // printf("\n");

    mFP z = mFP_mul(x, y);

    // z.show();

    if (z.isNaN() || z.isInf() || z.isZero())
    {
        return pack_FP32(z);
    }

    int64_t M_int = BIT(z.M, z.Wf, 2); // z.M in [1, 4)

    // Normalization
    if (M_int & 0x2)
    {
        z.M = z.M >> 1;
        z.E = z.E + 1;
    }

    // Round to Even
    int64_t round_bit = BIT(z.M, z.Wf - x.Wf - 1, 1);
    int64_t stick_bit = BIT(z.M, 0, z.Wf - x.Wf - 2);
    z.M = z.M >> (z.Wf - x.Wf); // Clip to Wf = 23
    z.Wf = x.Wf;
    if (round_bit == 1 && (stick_bit != 0 || (z.M & 0x1)))
    {
        z.M = z.M + 1;
    }

    // Normalization
    M_int = BIT(z.M, z.Wf, 2);
    if (M_int & 0x2)
    {
        z.M = z.M >> 1;
        z.E = z.E + 1;
    }

    const int maxE = (1 << z.We) - 1;

    // Underflow
    if (z.E <= 0)
    {
        z.M = 0;
        z.E = 0;
        z.exn = EXN_ZERO;
    }
    // Overflow
    if (z.E >= maxE)
    {
        z.M = 0;
        z.E = maxE;
        z.exn = EXN_INF;
    }

    return pack_FP32(z);
}
