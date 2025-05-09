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
    TB_corner_mFP32_mul(nullptr);
    // TB_corner_mFP32_mul("../output/FP32_MUL_corner_case.npz");
    // TB_random_mFP32_mul(0x123, 1000, nullptr);
    TB_manual_mFP32_dot();
    TB_dataset_mFP32(16, 16, 16);
    TB_dataset_mFP32( 8, 32, 16);
    TB_dataset_mFP32(32,  8, 16);
    return 0;
}
