#ifndef HALF_CONVERTOR_H_
#define HALF_CONVERTOR_H_

#include <vector>
#include "modelFP.h"

mfp16 fp32_to_fp16(float x);
float fp16_to_fp32(mfp16 x);

std::vector<mfp16> fp32_to_fp16(const std::vector<float>& x);
std::vector<float> fp16_to_fp32(const std::vector<mfp16>& x);

#endif
