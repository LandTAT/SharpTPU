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

    if (x.isNaN() || y.isNaN() || (x.isZero() && y.isInf()) || (x.isInf() && y.isZero()))
    {
        z.setNaN();
        return z;
    }

    if (x.isInf() || y.isInf())
    {
        z.setInf();
        return z;
    }

    if (x.isZero() || y.isZero())
    {
        z.setZero();
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

    z = mFP_norm_rtne(z, x.Wf);
    
    // z.show();
    return pack_FP32(z);
}
