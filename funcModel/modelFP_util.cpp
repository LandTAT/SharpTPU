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
    // Bit level equal
    return x == y;
}

void mFP::show() const
{
    printf("E%df%d: %c M = %lx E = %d ", We, Wf, S ? '-' : '+', M, E);
    if (isNaN)
        printf("isNaN ");
    if (isInf)
        printf("isInf ");
    if (isZero)
        printf("isZero ");
    printf("\n");
}
