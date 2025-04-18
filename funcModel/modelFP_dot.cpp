#include <cstdio>
#include <cstring>
#include <vector>
#include "modelFP.h"

float mFP32_dotv1(int N, const float* a, const float* b, float c)
{
    // assert Vm >= Wf * 2
    const int Wf = 23;
    const int Wm = 46 + 7;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    std::vector<mFP> vp(N + 1);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack(a + i);
        vb[i] = unPack(b + i);
        vp[i] = mFP_mul(va[i], vb[i]);
    }
    vp[N] = xc;

    for (int i = 0; i < N + 1; ++i)
    {
        if (vp[i].isNorm())
        {
            vp[i].M <<= Wm - vp[i].Wf;
        }
        vp[i].Wf = Wm;
    }

    mFP acc = mFP_accum(N + 1, vp.data());

    mFP xd = mFP_norm_rtne(acc, Wf);

    return pack_FP32(xd);
}

float mFP32_dotv2(int N, const float* a, const float* b, float c)
{
    // assert Vm >= Wf * 2
    const int Wf = 23;
    const int Wm = 46 + 7;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    std::vector<mFP> vp(N);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack(a + i);
        vb[i] = unPack(b + i);
        vp[i] = mFP_mul(va[i], vb[i]);
    }

    for (int i = 0; i < N; ++i)
    {
        if (vp[i].isNorm())
        {
            vp[i].M <<= Wm - vp[i].Wf;
        }
        vp[i].Wf = Wm;
    }

    mFP acc = mFP_accum(N, vp.data());

    // TODO: xd = xc + acc

    return 0.0;
}
