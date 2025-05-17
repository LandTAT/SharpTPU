#include <cstdio>
#include <cstring>
#include <vector>
#include "modelFP.h"

mFP mFP_accum(int N, const mFP* x)
{
    // x[i].We == x[j].We, for any 0 <= i, j < N
    // x[i].Wf == x[j].Wf, for any 0 <= i, j < N
    mFP z = {0};
    z.We = x->We;   // x[0].We
    z.Wf = x->Wf;   // x[0].Wf

    int maxE = 0;
    bool existNaN = false;
    bool existPosInf = false;
    bool existNegInf = false;

    for (int i = 0; i < N; ++i)
    {
        existNaN |= x[i].isNaN();
        existPosInf |= x[i].isInf() && !x[i].S;
        existNegInf |= x[i].isInf() &&  x[i].S;
        maxE = maxE < x[i].E ? x[i].E : maxE;
    }

    if (existNaN || (existPosInf && existNegInf))
    {
        z.setNaN();
        z.S = false;
        return z;
    }

    if (existPosInf || existNegInf)
    {
        z.setInf();
        z.S = existNegInf;
        return z;
    }

    int64_t acc = 0;
    int64_t m = 0;

    for (int i = 0; i < N; ++i)
    {
        int rsh = maxE - x[i].E;
        if (x[i].isNorm())
        {
            // truncate & Prevent UB
            m = rsh < 64 ? x[i].M >> rsh : 0;
            // printf("#%d 0x%lx >> %d = 0x%lx\n", i, x[i].M, rsh, m);
        }
        else
        {
            m = 0;  // x[i] is Zero
        }
        if (x[i].S)
        {
            m = -m;
        }
        acc += m;
    }

    z.S = false;
    if (acc < 0)
    {
        acc = -acc;
        z.S = true;
    }

    if (acc == 0)
    {
        z.setZero();
    }
    else
    {
        z.M = acc;
        z.E = maxE;
        z.exn = EXN_NORM;
    }

    return z;
}

// Normalize + Round to Nearest Even
// Output Wf: Wo
mFP mFP_norm_rtne(mFP x, int Wo)
{
    // assert x.Wf >= Wo
    mFP z = {0};
    z.We = x.We;
    z.Wf = Wo;
    z.S = x.S;
    z.exn = x.exn;
    const int allOneE = (1 << z.We) - 1;

    if (x.isNaN())
    {
        z.setNaN();
        return z;
    }

    if (x.isInf())
    {
        z.setInf();
        return z;
    }

    if (x.isZero())
    {
        z.setZero();
        return z;
    }

    // Non-zero width
    int Wnz = 0;
    for (uint64_t m = uint64_t(x.M); m != 0; m >>= 1)
    {
        ++Wnz;
    }

    int adj = Wnz - (x.Wf + 1);
    int rsh = Wnz - (z.Wf + 1);

    z.E = x.E + adj;
    if (z.E < 1)
    {
        rsh += 1 - z.E;
        z.E  = 1;
    }
    // printf("%d %d\n", rsh, adj);

    int64_t round_bit = 0;
    int64_t stick_bit = 0;

    if (rsh > 0)
    {
        round_bit = BIT(x.M, rsh - 1, 1);
        if (rsh > 1)
            stick_bit = BIT(x.M, 0, rsh - 2);
        z.M = rsh < 64 ? x.M >> rsh : 0;
        // printf("%d %ld %lx\n", rsh, round_bit, stick_bit);
    }
    else
    {
        z.M = x.M << (-rsh);
    }

    if (round_bit == 1 && (stick_bit != 0 || (z.M & 0x1)))
    {
        z.M = z.M + 1;
    }

    // Normalization
    int64_t M_int = BIT(z.M, z.Wf, 2);
    if (M_int & 0x2)
    {
        z.M = z.M >> 1;
        z.E = z.E + 1;
    }

    // Underflow
    if (z.M == 0)
    {
        z.setZero();
    }
    // Overflow
    if (z.E >= allOneE)
    {
        z.setInf();
    }

    return z;
}

float mFP32_accum(int N, const float* v)
{
    const int Wf = 23;
    const int Wm = 23 + 3;

    std::vector<mFP> vec(N);

    for (int i = 0; i < N; ++i)
    {
        mFP x = unPack(v + i);
        // x.show();
        if (x.isNorm())
        {
            x.M <<= Wm - Wf;
        }
        x.Wf = Wm;
        vec[i] = x;
        // vec[i].show();
    }

    mFP z = mFP_accum(N, vec.data());
    // z.show();

    z = mFP_norm_rtne(z, Wf);
    // z.show();

    return pack_FP32(z);
}

float mFP32_add2(float x, float y)
{
    float v[] = {x, y};
    return mFP32_accum(2, v);
}
