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

mFP unPack(int We, int Wf, const void *elem, size_t elemSize);
mFP unPack(const float *fp32);

mFP mFP_mul(mFP x, mFP y);

float mFP32_mul(float xx, float yy);

mFP mFP_add(mFP x, mFP y);

float mFP32_add(float xx, float yy);

void pack(mFP x, void *elem, size_t elemSize);
float pack_FP32(mFP x);

void printHex(float value);

#endif
