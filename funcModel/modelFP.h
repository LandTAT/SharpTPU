#ifndef MODELFP_H_
#define MODELFP_H_

#include <cstddef>
#include <cstdint>
#include <cstring>

using mFP_exn_t = uint8_t;
constexpr mFP_exn_t EXN_ZERO = 0x0;
constexpr mFP_exn_t EXN_NORM = 0x1;
constexpr mFP_exn_t EXN_INF  = 0x2;
constexpr mFP_exn_t EXN_NAN  = 0x3;

/*
    FP32: We = 8, Wf = 23
    FP16: We = 5, Wf = 10
    BP16: We = 8, Wf = 7
    TF32: We = 8, Wf = 10
*/
struct mFP
{
    int We;         // exponent width
    int Wf;         // fraction width
    int64_t M;      // M = 1.f    (1 <= f < 2)
    int32_t E;      // E = e - Bias
    bool S;         // 0: positive, 1: negative
    mFP_exn_t exn;  // 00: Zero, 01: Norm, 10: Inf, 11: NaN
public:
    bool isZero() const { return exn == EXN_ZERO; }
    bool isNorm() const { return exn == EXN_NORM; }
    bool isInf()  const { return exn == EXN_INF ; }
    bool isNaN()  const { return exn == EXN_NAN ; }
    void setZero();
    void setInf();
    void setNaN();
    void adjustWf(int new_Wf);
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

// Float Accumulation
mFP mFP_accum(int N, const mFP* x);
mFP mFP_norm_rtne(mFP x, int Wo);
float mFP32_accum(int N, const float* x);
float mFP32_add2(float x, float y);

// Float Dot Production
mFP mFP_dotv1(int N, const mFP* a, const mFP* b, mFP c, int Wm);
mFP mFP_dotv2(int N, const mFP* a, const mFP* b, mFP c, int Wm);
float mFP32_dotv1(int N, const float* a, const float* b, float c);
float mFP32_dotv2(int N, const float* a, const float* b, float c);

// Utility
uint32_t F32toU32(float x);
float U32toF32(uint32_t x);
bool fp32_equ(float x, float y);

// Test Case
int TB_corner_mFP32_mul(const char* npzName = nullptr);
int TB_random_mFP32_mul(uint32_t seed, int N, const char* npzName = nullptr);
int TB_manual_mFP32_dot(const char* npzName = nullptr);
int TB_random_mFP32_dot(uint32_t seed, int N, int K, const char* npzName = nullptr);

// Dataset Test Case
int TB_dataset_mFP32(int M, int N, int K);
int TB_dataset_mFP16(int M, int N, int K);

// Ref Function
float ref_fp32_mul(float x, float y);
float ref_fp32_add(float x, float y);
float ref_fp32_accum(int N, const float* x);
float ref_fp32_dotv1(int N, const float* a, const float* b, float c);
float ref_fp32_dotv2(int N, const float* a, const float* b, float c);

// 从 X 中取出从 LSB 开始的 POS 位长度为 LEN 的二进制数
#define BIT(X, POS, LEN) (((X) >> (POS)) & ((1UL << (LEN)) - 1UL))

// 打印任意类型数据的十六进制表示
template <typename T>
void printHex(const T &value)
{
    uint32_t hexValue;
    memcpy(&hexValue, &value, sizeof(T)); // 将浮点数的内存内容复制到 uint32_t
    printf("0x%08x ", hexValue);               // 以十六进制格式打印
}

#endif
