#include <cstdio>
#include <cstring>
#include <cassert>
#include <vector>
#include "modelFP.h"

mFP mFP_dotv2(int N, const mFP* a, const mFP* b, mFP c, int Wf_acc, int Wf_add)
{
    const int Wf_dst = c.Wf;
    std::vector<mFP> vp(N);

    for (int i = 0; i < N; ++i)
    {
        vp[i] = mFP_mul(a[i], b[i]);
    }
    for (int i = 0; i < N; ++i)
    {
        vp[i].adjustWf(Wf_acc);
    }
    mFP z = mFP_accum(N, vp.data());

    assert(z.We <= c.We);
    z.adjustWe(c.We);

    mFP d = {0};
    d.We = c.We;
    d.Wf = c.Wf;

    if (c.isNaN() || z.isNaN() || ((c.S != z.S) && c.isInf() && z.isInf()))
    {
        d.setNaN();
        d.S = false;
        return d;
    }
    if (c.isInf() || z.isInf())
    {
        d.setInf();
        d.S = c.isInf() ? c.S : z.S;
        return d;
    }

    // Non-zero width
    int Wnz = 0;
    for (uint64_t m = uint64_t(z.M); m != 0; m >>= 1)
    {
        ++Wnz;
    }
    int lsh = (z.Wf + 1) - Wnz;
    if (lsh > 0)
    {
        z.M <<= lsh;
        z.E  -= lsh;
    }

    z.adjustWf(Wf_add);
    c.adjustWf(Wf_add);
    d.Wf = Wf_add;
    d.exn = EXN_NORM;

    // z.show();
    // c.show();

    int rsh = c.E - z.E;
    if (rsh >= 0)
    {
        z.M >>= std::min(+rsh, 63);
        d.E = c.E;
    }
    else
    {
        c.M >>= std::min(-rsh, 63);
        d.E = z.E;
    }

    d.M = (z.S ? -z.M : +z.M) + (c.S ? -c.M : +c.M);

    if (d.M < 0)
    {
        d.M = -d.M;
        d.S = true;
    }
    if (d.M == 0)
    {
        d.setZero();
    }
    // d.show();

    d = mFP_norm_rtne(d, Wf_dst);
    // d.show();
    return d;
}

float mFP32_dotv2(int N, const float* a, const float* b, float c)
{
    // assert Wf_acc >= Wf * 2
    const int Wf_acc = 56 - 1 - 5;
    const int Wf_add = Wf_acc;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack(a + i);
        vb[i] = unPack(b + i);
    }

    mFP xd = mFP_dotv2(N, va.data(), vb.data(), xc, Wf_acc, Wf_add);
    return pack_FP32(xd);
}

mfp16 mFP16_dotv2(int N, const mfp16* a, const mfp16* b, mfp16 c)
{
    const int Wf_acc = 40 - 1 - 5;
    const int Wf_add = Wf_acc;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack_FP16(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack_FP16(a + i);
        vb[i] = unPack_FP16(b + i);
    }

    mFP xd = mFP_dotv2(N, va.data(), vb.data(), xc, Wf_acc, Wf_add);
    return pack_FP16(xd);
}

float mFP16_mix_dotv2(int N, const mfp16* a, const mfp16* b, float c)
{
    const int Wf_acc = 40 - 1 - 5;
    const int Wf_add = Wf_acc;

    std::vector<mFP> va(N);
    std::vector<mFP> vb(N);
    mFP xc = unPack(&c);

    for (int i = 0; i < N; ++i)
    {
        va[i] = unPack_FP16(a + i);
        vb[i] = unPack_FP16(b + i);
    }

    mFP xd = mFP_dotv2(N, va.data(), vb.data(), xc, Wf_acc, Wf_add);
    return pack_FP32(xd);
}
