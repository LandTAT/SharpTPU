#include <cstdio>
#include <cstring>
#include <cassert>
#include <vector>
#include "modelFP.h"

mFP mFP_dotv1(int N, const mFP* a, const mFP* b, mFP c, int Wf_acc)
{
    const int Wf_d = c.Wf;
    std::vector<mFP> vp(N + 1);

    for (int i = 0; i < N; ++i)
    {
        vp[i] = mFP_mul(a[i], b[i]);
    }
    vp[N] = c;

    for (int i = 0; i < N + 1; ++i)
    {
        assert(vp[i].We <= c.We);
        vp[i].adjustWe(c.We);
        vp[i].adjustWf(Wf_acc);
    }

    mFP xd = mFP_accum(N + 1, vp.data());
    xd = mFP_norm_rtne(xd, Wf_d);
    return xd;
}

float mFP32_dotv1(int N, const float* a, const float* b, float c)
{
    const int Wf_acc = 64 - 1 - 5;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack(a + i);
        vb[i] = unPack(b + i);
    }

    mFP xd = mFP_dotv1(N, va.data(), vb.data(), xc, Wf_acc);
    return pack_FP32(xd);
}

mfp16 mFP16_dotv1(int N, const mfp16* a, const mfp16* b, mfp16 c)
{
    const int Wf_acc = 40 - 1 - 5;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack_FP16(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack_FP16(a + i);
        vb[i] = unPack_FP16(b + i);
    }

    mFP xd = mFP_dotv1(N, va.data(), vb.data(), xc, Wf_acc);
    return pack_FP16(xd);
}

float mFP16_mix_dotv1(int N, const mfp16* a, const mfp16* b, float c)
{
    const int Wf_acc = 40 - 1 - 5;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack_FP16(a + i);
        vb[i] = unPack_FP16(b + i);
    }

    mFP xd = mFP_dotv1(N, va.data(), vb.data(), xc, Wf_acc);
    return pack_FP32(xd);
}
