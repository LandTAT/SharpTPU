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

// 打印浮点数的十六进制表示
void printHex(float value)
{
    uint32_t hexValue;
    std::memcpy(&hexValue, &value, sizeof(value)); // 将浮点数的内存内容复制到 uint32_t
    printf("0x%08x ", hexValue);                   // 以十六进制格式打印
}

// 定义非规格化数
float createDenormalized(uint32_t bitPattern)
{
    float result;
    std::memcpy(&result, &bitPattern, sizeof(result));
    return result;
}

int main()
{
    // 初始化随机数种子
    std::srand(std::time(nullptr));

    // 定义随机数生成范围
    const float minRand = -100.0f; // 随机数最小值
    const float maxRand = 100.0f;  // 随机数最大值

    // 生成随机数的函数
    auto getRandomFloat = [&]() -> float
    {
        return minRand + static_cast<float>(std::rand()) / (static_cast<float>(RAND_MAX / (maxRand - minRand)));
    };

    // 替换 x 和 y 为随机数
    float x = getRandomFloat();
    float y = getRandomFloat();
    float z = x * y;

    // NaN 测试数据
    float NaN = std::numeric_limits<float>::quiet_NaN();

    // 正无穷大测试数据
    float posInf = std::numeric_limits<float>::infinity();

    // 负无穷大测试数据
    float negInf = -std::numeric_limits<float>::infinity();

    // Zero 测试数据：expn == 0, frac == 0
    float zero = 0.0f;

    // 正常数：expn != 0, expn != maxE
    float normal = 1.0f;

    // 非规格化数（Denormalized Number）：expn == 0, frac != 0
    float denormalized = createDenormalized(0x00000001);  // 最小的非规格化数
    float denormalized2 = createDenormalized(0x00000002); // 较大的非规格化数

    // 将随机数 x 和 y 添加到测试数据中
    std::vector<float> test_data = {NaN, posInf, negInf, zero, normal, denormalized, x, y};

    int i, j, cnt = 0;

    // 用于存储出错的结果
    std::vector<std::tuple<int, float, float, float, float, float>> error_cases;

    for (i = 0; i < test_data.size(); i++)
    {
        for (j = 0; j < test_data.size(); j++)
        {
            float t = mFP32_mul(test_data[i], test_data[j]);
            float error = test_data[i] * test_data[j] - t;

            // 略过 error 为 NaN 或正负无穷的情况
            if (error == 0.0 || std::isnan(error) || std::isinf(error) || error == denormalized)
            {
                continue;
            }
            else
            {
                printf("\nTest %d: %.10f * %.10f\n", cnt, test_data[i], test_data[j]);
                printf("Ref out: %.20f, Model out: %.20f, Error = %.20f\n", test_data[i] * test_data[j], t, error);
                printHex(test_data[i] * test_data[j]);
                printHex(t);
                printHex(error);

                // 记录出错的结果
                error_cases.emplace_back(cnt++, test_data[i], test_data[j], test_data[i] * test_data[j], t, error);
            }
        }
    }

    // 打印所有记录的错误信息
    printf("\nTotal ERROR cases: %d\n", (int)error_cases.size());
    for (const auto &[id, a, b, ref_out, model_out, err] : error_cases)
    {
        printf("\nError Case %d:\n", id);
        printf("Inputs: %.10f * %.10f\n", a, b);
        printf("hex Inputs: ");
        printHex(a);
        printf(" ");
        printHex(b);
        printf("\n");
        printf("Ref out: %.20f, Model out: %.20f, Error = %.20f\n", ref_out, model_out, err);
        printf("Hex Outputs: ");
        printHex(ref_out);
        printf(" ");
        printHex(model_out);
        printf(" ");
        printHex(err);
        printf("\n");
    }
    return 0;
}
