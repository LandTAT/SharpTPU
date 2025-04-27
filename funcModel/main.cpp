#include <cstdio>
#include <cstdint>
#include <iostream>
#include <limits>
#include <vector>
#include <cmath> // 引入 isnan 和 isinf 函数
#include <cstring>
#include <tuple> // 用于存储多项数据
#include "modelFP.h"
#include <cstdlib> // 用于 rand() 和 srand()
#include <ctime>   // 用于 time()

using FP32Limit = std::numeric_limits<float>;

int main()
{
    /*
    std::vector<float> testVec = {
        +3.14159F, -3.14159F,
        +2.71828F, -2.71828F,
        +0.0F, -0.0F,
        +1.0F, -1.0F,
        +1e+30F, -1e+30F,
        +1e-30F, -1e-30F,
        +FP32Limit::min(), -FP32Limit::min(),
        +FP32Limit::max(), -FP32Limit::max(),
        +FP32Limit::epsilon(), -FP32Limit::epsilon(),
        // +FP32Limit::denorm_min(), -FP32Limit::denorm_min(),
        +FP32Limit::infinity(), -FP32Limit::infinity(),
        +FP32Limit::quiet_NaN(), -FP32Limit::quiet_NaN()};

    // 添加一些接近 1 的测试值，验证舍入与精度
    testVec.push_back(1.0F + FP32Limit::epsilon());
    testVec.push_back(1.0F - FP32Limit::epsilon());
    testVec.push_back(-1.0F + FP32Limit::epsilon());
    testVec.push_back(-1.0F - FP32Limit::epsilon());

    // 添加一些极端测试值（在边界附近）
    testVec.push_back(FP32Limit::max() / 2);
    testVec.push_back(-FP32Limit::max() / 2);
    testVec.push_back(FP32Limit::min() * 2);
    testVec.push_back(-FP32Limit::min() * 2);

    const int N = testVec.size();
    int err = 0;

    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            float x = testVec[i];
            float y = testVec[j];
            float z = mFP32_mul(x, y);
            float g = x * y;
            if (!fp32_equ(z, g))
            {
                ++err;
                printf("Error #%d, %d; %f * %f = %f, %f\n", i, j, x, y, z, g);
            }
        }
    }
    printf("Float32 MUL ");
    if (err == 0)
        printf("PASS\n");
    else
        printf("FAIL %d in %d\n", err, N * N);

    err = 0;
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            float x = testVec[i];
            float y = testVec[j];
            float z = mFP32_add2(x, y);
            float g = x + y;
            if (!fp32_equ(z, g))
            {
                ++err;
                printf("Error #%d, %d; %g + %g = %g %g %e 0x%x\n", i, j, x, y, z, g, z - g, F32toU32(z) - F32toU32(g));
            }
        }
    }
    printf("Float32 ADD2 ");
    if (err == 0)
        printf("PASS\n");
    else
        printf("FAIL %d in %d\n", err, N * N);
    */
    /*
        float x = +2.71828F;
        float y = +FP32Limit::epsilon();
        float z = mFP32_add2(x, y);
        float g = x + y;
        printf("%g + %g = %g %g %e 0x%x\n", x, y, z, g, z - g, F32toU32(z) - F32toU32(g));
    */
    TB_corner_mFP32_mul("../output/FP32_MUL_corner_case.npz");
    TB_random_mFP32_mul(0x123, 1000, nullptr);

    return 0;
}
