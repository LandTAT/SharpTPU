#include <cstdio>
#include <cstring>
#include "modelFP.h"

mFP unPack(int We, int Wf, const void *elem, size_t elemSize)
{
    int64_t data = 0;
    memcpy(&data, elem, elemSize);

    mFP info = {0};

    const int maxE = (1 << We) - 1;

    int64_t frac = BIT(data, 0, Wf);
    int64_t expn = BIT(data, Wf, We);
    int64_t sign = BIT(data, Wf + We, 1);

    info.We = We;
    info.Wf = Wf;

    info.M = frac;
    info.E = expn;
    info.S = sign != 0;

    // info.isZero = expn == 0 && frac == 0;
    // info.isInf = expn == maxE && frac == 0;
    // info.isNaN = expn == maxE && frac != 0;
    if (expn == maxE)
    {
        info.exn = frac == 0 ? EXN_INF  : EXN_NAN ;
    }
    else if (expn == 0)
    {
        // M = 0.frac, Denormalized number
        info.exn = frac == 0 ? EXN_ZERO : EXN_NORM;
        info.E = 1;
    }
    else
    {
        // M = 1.frac, Normalized number
        info.exn = EXN_NORM;
        info.M |= (1L << Wf);
    }

    return info;
}

mFP unPack(const float *fp32)
{
    return unPack(8, 23, fp32, sizeof(float));
}

void pack(mFP x, void *elem, size_t elemSize)
{
    // x.show();
    if (x.E == 1 && BIT(x.M, x.Wf, 1) == 0)
    {
        x.E = 0;
    }
    uint64_t data = BIT(x.M, 0, x.Wf);
    data |= uint64_t(x.E) << (x.Wf);
    data |= uint64_t(x.S) << (x.Wf + x.We);
    memcpy(elem, &data, elemSize);
    return;
}

float pack_FP32(mFP x)
{
    // assert x.We == 8 && x.Wf == 23
    float z = 0.0f;
    pack(x, &z, sizeof(float));
    return z;
}
