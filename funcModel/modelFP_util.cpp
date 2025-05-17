#include <cstdio>
#include <cstring>
#include <cmath>
#include <cfloat>
#include "modelFP.h"

uint32_t F32toU32(float x)
{
    uint32_t y = 0;
    memcpy(&y, &x, sizeof(float));
    return y;
}

float U32toF32(uint32_t x)
{
    float y = 0.0f;
    memcpy(&y, &x, sizeof(float));
    return y;
}

bool fp32_equ(float x, float y)
{
    int xCatagory = std::fpclassify(x);
    int yCatagory = std::fpclassify(y);

    if (xCatagory == FP_NAN || yCatagory == FP_NAN)
    {
        return xCatagory == FP_NAN && yCatagory == FP_NAN;
    }
    /*
    if (xCatagory == FP_SUBNORMAL)
    {
        xCatagory = FP_ZERO;
        x = std::signbit(x) ? -0.0f : +0.0f;
    }
    if (yCatagory == FP_SUBNORMAL)
    {
        yCatagory = FP_ZERO;
        y = std::signbit(y) ? -0.0f : +0.0f;
    }
    */
    // Bit level equal
    return x == y;
}

bool mFP::isSubnorm() const
{
    return exn == EXN_NORM && E == 1 && BIT(M, Wf, 1) == 0;
}

void mFP::setZero()
{
    M = 0;
    E = 1;
    exn = EXN_ZERO;
}

void mFP::setInf()
{
    const int allOneE = (1 << We) - 1;
    M = 0;
    E = allOneE;
    exn = EXN_INF;
}

void mFP::setNaN()
{
    const int allOneE = (1 << We) - 1;
    M = -1;
    E = allOneE;
    exn = EXN_NAN;
}

void mFP::adjustWf(int new_Wf)
{
    int lsh = new_Wf - Wf;
    if (isNorm())
    {
        if (lsh >= 0)
            M <<= +lsh;
        else
            M >>= -lsh;
    }
    Wf = new_Wf;
}

void mFP::adjustWe(int new_We)
{
    const int dffBias = (1 << (new_We - 1)) - (1 << (We - 1));
    const int allOneE = (1 << new_We) - 1;
    We = new_We;
    switch (exn)
    {
    case EXN_ZERO:
        setZero();
        break;
    case EXN_NORM:
        E += dffBias;
        if (E < 1)
        {
            // Shoule be deal in later function: mFP_norm_rtne
        }
        if (E >= allOneE)
        {
            // setInf();
        }
        break;
    case EXN_INF:
        setInf();
        break;
    case EXN_NAN:
        setNaN();
        break;
    }
}

void mFP::show() const
{
    printf("E%df%d: %c M 0x%lx E %d ", We, Wf, S ? '-' : '+', M, E);
    if (isNaN())
        printf("isNaN ");
    if (isInf())
        printf("isInf ");
    if (isZero())
        printf("isZero ");
    printf("\n");
}
