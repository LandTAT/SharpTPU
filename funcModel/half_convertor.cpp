#include "half/half.hpp"
#include "half_convertor.h"

mfp16 fp32_to_fp16(float x)
{
    constexpr std::float_round_style round_style = (std::float_round_style)(HALF_ROUND_STYLE);
    return static_cast<mfp16>(half_float::detail::float2half<round_style>(x));
}

float fp16_to_fp32(mfp16 x)
{
    return half_float::detail::half2float<float>(x);
}

std::vector<mfp16> fp32_to_fp16(const std::vector<float>& x)
{
    std::vector<mfp16> y(x.size());
    for (size_t i = 0; i < x.size(); ++i)
    {
        y[i] = fp32_to_fp16(x[i]);
    }
    return y;
}

std::vector<float> fp16_to_fp32(const std::vector<mfp16>& x)
{
    std::vector<float> y(x.size());
    for (size_t i = 0; i < x.size(); ++i)
    {
        y[i] = fp16_to_fp32(x[i]);
    }
    return y;
}
