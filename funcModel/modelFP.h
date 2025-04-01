#ifndef MODELFP_H_
#define MODELFP_H_

#include <cstddef>
#include <cstdint>

/*
    FP32: We = 8, Wf = 23
    FP16: We = 5, Wf = 10
    BP16: We = 8, Wf = 7
    TF32: We = 8, Wf = 10
*/
struct mFP
{
    int We;    // exponent width
    int Wf;    // fraction width
    int64_t M; // M = 1.f    (1 <= f < 2)
    int32_t E; // E = e - Bias
    bool S;    // 0: positive, 1: negative
    bool isZero;
    bool isInf;
    bool isNaN;

    // 默认构造函数，初始化所有成员变量
    mFP() : We(0), Wf(0), M(0), E(0), S(false), isZero(false), isInf(false), isNaN(false) {}
    mFP(int We = 0, int Wf = 0, int64_t M = 0,
        int32_t E = 0, bool S = false, bool isZero = false,
        bool isInf = false, bool isNaN = false) : We(We), Wf(Wf), M(M), E(E), S(S), isZero(isZero), isInf(isInf), isNaN(isNaN) {}

public:
    void show() const;
};
// Value = (-1) ^ S * M * 2 ^ (E - Bias)

// Float unPack & Pack
mFP unPack(int We, int Wf, const void *elem, size_t elemSize);
mFP unPack(const float *fp32);
void pack(mFP x, void *elem, size_t elemSize);
float pack_FP32(mFP x);

// Float Multiplication
mFP mFP_mul(mFP x, mFP y);
float mFP32_mul(float xx, float yy);

// Float Addition
mFP mFP_add(mFP x, mFP y);
float mFP32_add(float xx, float yy);

// Utility
uint32_t F32toU32(float x);
float U32toF32(uint32_t x);
bool fp32_equ(float x, float y);

// 从 X 中取出从 LSB 开始的 POS 位长度为 LEN 的二进制数
#define BIT(X, POS, LEN) (((X) >> (POS)) & ((1UL << (LEN)) - 1UL))

// 打印任意类型数据的十六进制表示
template <typename T>
void printHex(const T &value)
{
    uint32_t hexValue;
    std::memcpy(&hexValue, &value, sizeof(T)); // 将浮点数的内存内容复制到 uint32_t
    printf("0x%08x ", hexValue);               // 以十六进制格式打印
}

#endif
