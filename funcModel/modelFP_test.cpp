#include <cstdio>
#include <cstring>
#include <limits>
#include <random>
#include <cnpy.h>
#include "modelFP.h"

using FP32Limit = std::numeric_limits<float>;

const std::vector<float> cornerCase = {
    +3.14159F, -3.14159F,
    +2.71828F, -2.71828F,
    +0.0F, -0.0F,
    +1.0F, -1.0F,
    +1e+30F, -1e+30F,
    +1e-30F, -1e-30F,
    +FP32Limit::min(), -FP32Limit::min(),
    +FP32Limit::max(), -FP32Limit::max(),
    +FP32Limit::epsilon(), -FP32Limit::epsilon(),
    +FP32Limit::denorm_min(), -FP32Limit::denorm_min(),
    +FP32Limit::infinity(), -FP32Limit::infinity(),
    +FP32Limit::quiet_NaN(), -FP32Limit::quiet_NaN(),
    +1.0F + FP32Limit::epsilon(), +1.0F - FP32Limit::epsilon(), 
    -1.0F + FP32Limit::epsilon(), -1.0F - FP32Limit::epsilon()
};

int TB_corner_mFP32_mul(const char* npzName)
{
    const int N = cornerCase.size();
    int err = 0;
    std::vector<float> vA;
    std::vector<float> vB;
    std::vector<float> vZ;
    std::vector<float> vR;

    if (npzName)
    {
        vA.reserve(N * N);
        vB.reserve(N * N);
        vZ.reserve(N * N);
        vR.reserve(N * N);
    }

    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            float x = cornerCase[i];
            float y = cornerCase[j];
            float z = mFP32_mul(x, y);
            float g = ref_fp32_mul(x, y);    // Standard Float Mul
            if (!fp32_equ(z, g))
            {
                ++err;
                float df = z - g;
                uint32_t di = F32toU32(z) - F32toU32(g);
                di = std::min(+di, -di);
                printf("[FP32 MUL Corner] #%d, #%d: %g * %g = %g %g, Err = %e, Diff = 0x%x\n", i, j, x, y, z, g, df, di);
            }
            if (npzName)
            {
                vA.push_back(x);
                vB.push_back(y);
                vZ.push_back(z);
                vR.push_back(g);
            }
        }
    }

    if (err == 0)
    {
        printf("[FP32 MUL Corner] PASS %d Cases\n", N * N);
    }
    else
    {
        printf("[FP32 MUL Corner] Fail %d in %d\n", err, N * N);
    }

    if (npzName)
    {
        cnpy::npz_save(npzName, "A"  , vA, "w");
        cnpy::npz_save(npzName, "B"  , vB, "a");
        cnpy::npz_save(npzName, "Z"  , vZ, "a");
        cnpy::npz_save(npzName, "Ref", vR, "a");
        printf("[FP32 MUL Corner] Save NPZ: %s\n", npzName);
    }

    return err;
}

int TB_random_mFP32_mul(uint32_t seed, int N, const char* npzName)
{
    std::mt19937 rGen(seed);
    printf("std::mt19937 min = %ld, max = %ld\n", rGen.min(), rGen.max());
    return 0;
}

int TB_manual_mFP32_dot(const char* npzName)
{
    // const int N = 1;
    const int N = cornerCase.size();
    int err = 0;

    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            for (int k = 0; k < N; ++k)
            {
                float a = cornerCase[i];
                float b = cornerCase[j];
                float c = cornerCase[k];
                // float a = cornerCase[8];
                // float b = cornerCase[12];
                // float c = cornerCase[17];
                float z = mFP32_dotv2(1, &a, &b, c);
                float g = ref_fp32_dotv1(1, &a, &b, c);
                if (!fp32_equ(z, g))
                {
                    ++err;
                    float df = z - g;
                    uint32_t di = F32toU32(z) - F32toU32(g);
                    di = std::min(+di, -di);
                    printf("[FP32 DOT Manual] #%d, #%d, #%d: %g * %g + %g = %g %g, Err = %e, Diff = 0x%x\n", i, j, k, a, b, c, z, g, df, di);
                    // unPack(&z).show();
                    // unPack(&g).show();
                }
            }
        }
    }

    if (err == 0)
    {
        printf("[FP32 DOT Manual] PASS %d Cases\n", N * N * N);
    }
    else
    {
        printf("[FP32 DOT Manual] Fail %d in %d\n", err, N * N * N);
    }
    return err;
}

float ref_fp32_mul(float x, float y)
{
    return x * y;
}

float ref_fp32_add(float x, float y)
{
    return x + y;
}

float ref_fp32_accum(int N, const float* x)
{
    double acc = 0.0;
    for (int i = 0; i < N; ++i)
    {
        acc += static_cast<double>(x[i]);
    }
    return static_cast<float>(acc);
}

float ref_fp32_dotv1(int N, const float* a, const float* b, float c)
{
    double acc = static_cast<double>(c);
    for (int i = 0; i < N; ++i)
    {
        acc = std::fma(
            static_cast<double>(a[i]), 
            static_cast<double>(b[i]), 
            acc
        );
    }
    return static_cast<float>(acc);
}

float ref_fp32_dotv2(int N, const float* a, const float* b, float c)
{
    double acc = 0.0;
    for (int i = 0; i < N; ++i)
    {
        acc = std::fma(
            static_cast<double>(a[i]), 
            static_cast<double>(b[i]), 
            acc
        );
    }
    acc += static_cast<double>(c);
    return static_cast<float>(acc);
}
