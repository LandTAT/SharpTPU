#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <string>
#include <vector>
#include "modelFP.h"

const std::string ROOT = "../../dataset";

// A[M, N] -> B[N, M]
template<typename T>
std::vector<T> transpose(std::vector<T> A, int M, int N)
{
    assert(A.size() == M * N);
    std::vector<T> B(A.size());
    for (int i = 0; i < M; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            B[j * M + i] = A[i * N + j];
        }
    }
    return B;
}

template<typename T>
std::vector<T> loadBin(int M, int N, int K, char mat, const char* folder, const char* typeName=nullptr)
{
    assert(mat == 'a' || mat == 'b' || mat == 'c');
    if (typeName == nullptr)
    {
        typeName = folder;
    }

    char shape[16];
    char fpath[64];
    snprintf(shape, sizeof(shape), "m%dn%dk%d", M, N, K);
    snprintf(fpath, sizeof(fpath), "%s/%s/%s/%c_%s_%s.bin", ROOT.c_str(), folder, shape, mat, typeName, shape);

    FILE* fp = fopen(fpath, "rb");
    if (fp == nullptr)
    {
        printf("Can not open file %s\n", fpath);
        exit(-1);
    }

    size_t size = 0;
    switch (mat)
    {
    case 'a':
        size = M * K;
        break;
    case 'b':
        size = K * N;
        break;
    case 'c':
        size = M * N;
        break;
    }

    std::vector<T> buf(size);
    size_t rCnt = fread(buf.data(), sizeof(T), size, fp);
    if (rCnt != size)
    {
        printf("Failed to Read file %s, %ld in %ld\n", fpath, rCnt, size);
        exit(-1);
    }
    fclose(fp);

    if (mat == 'b')
    {
        return transpose(buf, K, N);
    }
    return buf;
}

int TB_dataset_mFP32(int M, int N, int K)
{
    char shape[16];
    snprintf(shape, sizeof(shape), "m%dn%dk%d", M, N, K);

    int err = 0;
    std::vector<float> A = loadBin<float>(M, N, K, 'a', "fp32");  // M x K
    std::vector<float> B = loadBin<float>(M, N, K, 'b', "fp32");  // N x K
    std::vector<float> C = loadBin<float>(M, N, K, 'c', "fp32");  // M x N

    for (int i = 0; i < M; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            const float* pA = A.data() + i * K;
            const float* pB = B.data() + j * K;
            float c = C[i * N + j];
            float z = mFP32_dotv2(K, pA, pB, c);
            float g = ref_fp32_dotv2(K, pA, pB, c);
            if (!fp32_equ(z, g))
            {
                ++err;
                float df = z - g;
                uint32_t di = F32toU32(z) - F32toU32(g);
                di = std::min(+di, -di);
                printf("[FP32 %s] #%d, #%d: %g %g, Err = %e, Diff = 0x%x\n", shape, i, j, z, g, df, di);
            }
        }
    }

    if (err == 0)
    {
        printf("[FP32 %s] PASS %d Cases\n", shape, M * N);
    }
    else
    {
        printf("[FP32 %s] Fail %d in %d\n", shape, err, M * N);
    }
    return err;
}
