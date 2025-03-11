#include <cstdio>
#include <cstdint>
#include <iostream>
#include "modelFP.h"

int main()
{
    float x = 1.1234f;
    float y = 9.8765f;
    float z = x * y;

    float t = mFP32_mul(x, y);

    printf("%f * %f = %f\n", x, y, z);
    printf("model Out = %f\n", t);
    printf("Error = %f\n", t - z);

    return 0;
}
