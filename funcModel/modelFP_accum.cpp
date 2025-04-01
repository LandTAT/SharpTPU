#include <cstdio>
#include <cstring>
#include "modelFP.h"

mFP mFP_accum(const mFP* x, int N, int Wf)
{
    // assert x[i].We == x[j].We
    mFP z = {0};
    z.We = x->We;   // x[0].We
    z.Wf = Wf;

    const int maxE = (1 << z.We) - 1;
    int xx = 0;
    
    bool existNaN = false;
    bool existPosInf = false;
    bool existNegInf = false;

    for (int i = 0; i < N; ++i)
    {
        existNaN |= x[i].isNaN();
        existPosInf |= x[i].isInf() && !x[i].S;
        existNegInf |= x[i].isInf() &&  x[i].S;
        
    }

    if (existNaN || (existPosInf && existNegInf))
    {
        z.M = -1;
        z.E = maxE;
        z.S = false;
        z.exn = EXN_NAN;
        return z;
    }

    if (existPosInf || existNegInf)
    {
        z.M = 0;
        z.E = maxE;
        z.S = existNegInf;
        z.exn = EXN_INF;
        return z;
    }

    return z;
}
