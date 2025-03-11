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
    int We;
    int Wf;
    int64_t M;
    int32_t E;
    bool S;
    bool isZero;
    bool isInf;
    bool isNaN;
public:
    void show() const;
};
// Value = (-1) ^ S * M * 2 ^ (E - Bias)

mFP unPack(int We, int Wf, const void* elem, size_t elemSize);
mFP unPack(const float* fp32);

mFP mFP_mul(mFP x, mFP y);

float mFP32_mul(float xx, float yy);

void pack(mFP x, void* elem, size_t elemSize);
float pack_FP32(mFP x);

#endif
