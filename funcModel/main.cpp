#include <cstdio>
#include <cstdint>
#include <iostream>
#include "modelFP.h"

int main()
{
    float x = 1.1234f;
    float y = 9.8765f;
    float z = x * y;

        // NaN 测试数据：expn == maxE, frac != 0
    float NaN = 0x7fc00000; // NaN 形式的浮点数
    std::cout << "NaN: " << NaN << std::endl;

    // Infinity 测试数据：expn == maxE, frac == 0
    float inf = 0x7f800000; // 正无穷大
    std::cout << "Infinity: " << inf << std::endl;

    // Zero 测试数据：expn == 0, frac == 0
    float zero = 0x00000000; // 零
    std::cout << "Zero: " << zero << std::endl;

    // 正常数：expn != 0, expn != maxE
    float normal = 1.0f; // 1.0 是一个普通的数
    std::cout << "Normal: " << normal << std::endl;

    // 非规格化数（Denormalized Number）：expn == 0, frac != 0
    float denormalized = 0x00000001; // 非规格化数
    std::cout << "Denormalized: " << denormalized << std::endl;
    float t = mFP32_mul(x, y);

    printf("%f * %f = %f\n", x, y, z);
    printf("model Out = %f\n", t);
    printf("Error = %f\n", t - z);

    return 0;
}
