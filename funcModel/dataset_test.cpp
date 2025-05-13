#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <string>
#include <vector>
#include <cnpy.h>
#include "modelFP.h"
#include "half_convertor.h"

#define OUTPUT_NPZ 1

const std::string ROOT = "../../dataset";
const std::string NPZ_PATH = "../output";

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
    std::vector<float> D(M * N);
    std::vector<float> G(M * N);

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
            D[i * N + j] = z;
            G[i * N + j] = g;
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
    #if OUTPUT_NPZ
    char npzName[64];
    snprintf(npzName, sizeof(npzName), "%s/FP32_%s.npz", NPZ_PATH.c_str(), shape);
    cnpy::npz_save(npzName, "A"  , A, "w");
    cnpy::npz_save(npzName, "B"  , B, "a");
    cnpy::npz_save(npzName, "C"  , C, "a");
    cnpy::npz_save(npzName, "D"  , D, "a");
    cnpy::npz_save(npzName, "Ref", G, "a");
    printf("[FP32 %s] Save NPZ: %s\n", shape, npzName);
    #endif
    return err;
}

int TB_dataset_mFP16(int M, int N, int K)
{
    char shape[16];
    snprintf(shape, sizeof(shape), "m%dn%dk%d", M, N, K);

    int err = 0;
    std::vector<mfp16> A_f16 = loadBin<mfp16>(M, N, K, 'a', "fp16");  // M x K
    std::vector<mfp16> B_f16 = loadBin<mfp16>(M, N, K, 'b', "fp16");  // N x K
    std::vector<mfp16> C_f16 = loadBin<mfp16>(M, N, K, 'c', "fp16");  // M x N
    std::vector<float> A_f32 = fp16_to_fp32(A_f16);
    std::vector<float> B_f32 = fp16_to_fp32(B_f16);
    std::vector<float> C_f32 = fp16_to_fp32(C_f16);
    std::vector<mfp16> D_f16(M * N);
    std::vector<mfp16> G_f16(M * N);

    for (int i = 0; i < M; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            const mfp16* pA_f16 = A_f16.data() + i * K;
            const mfp16* pB_f16 = B_f16.data() + j * K;
            mfp16 c_f16 = C_f16[i * N + j];
            const float* pA_f32 = A_f32.data() + i * K;
            const float* pB_f32 = B_f32.data() + j * K;
            float c_f32 = C_f32[i * N + j];
            mfp16 z_f16 = mFP16_dotv2(K, pA_f16, pB_f16, c_f16);
            float z_f32 = fp16_to_fp32(z_f16);
            float g_f32 = ref_fp32_dotv2(K, pA_f32, pB_f32, c_f32);
            mfp16 g_f16 = fp32_to_fp16(g_f32);
            if (z_f16 != g_f16)
            {
                ++err;
                uint16_t di = z_f16 - g_f16;
                di = std::min(+di, -di);
                printf("[FP16 %s] #%d, #%d: %g %g, 0x%x 0x%x, Diff = 0x%x\n", shape, i, j, z_f32, g_f32, z_f16, g_f16, di);
            }
            D_f16[i * N + j] = z_f16;
            G_f16[i * N + j] = g_f16;
        }
    }

    if (err == 0)
    {
        printf("[FP16 %s] PASS %d Cases\n", shape, M * N);
    }
    else
    {
        printf("[FP16 %s] Fail %d in %d\n", shape, err, M * N);
    }
    #if OUTPUT_NPZ
    char npzName[64];
    snprintf(npzName, sizeof(npzName), "%s/FP16_%s.npz", NPZ_PATH.c_str(), shape);
    cnpy::npz_save(npzName, "A"  , A_f16, "w");
    cnpy::npz_save(npzName, "B"  , B_f16, "a");
    cnpy::npz_save(npzName, "C"  , C_f16, "a");
    cnpy::npz_save(npzName, "D"  , D_f16, "a");
    cnpy::npz_save(npzName, "Ref", G_f16, "a");
    printf("[FP16 %s] Save NPZ: %s\n", shape, npzName);
    #endif
    return err;
}

int TB_dataset_mFP16_mix(int M, int N, int K)
{
    char shape[16];
    snprintf(shape, sizeof(shape), "m%dn%dk%d", M, N, K);

    int err = 0;
    std::vector<mfp16> A_f16 = loadBin<mfp16>(M, N, K, 'a', "fp16");  // M x K
    std::vector<mfp16> B_f16 = loadBin<mfp16>(M, N, K, 'b', "fp16");  // N x K
    std::vector<float> C_f32 = loadBin<float>(M, N, K, 'c', "fp32");  // M x N
    std::vector<float> A_f32 = fp16_to_fp32(A_f16);
    std::vector<float> B_f32 = fp16_to_fp32(B_f16);
    std::vector<float> D_f32(M * N);
    std::vector<float> G_f32(M * N);

    for (int i = 0; i < M; ++i)
    {
        for (int j = 0; j < N; ++j)
        {
            const mfp16* pA_f16 = A_f16.data() + i * K;
            const mfp16* pB_f16 = B_f16.data() + j * K;
            const float* pA_f32 = A_f32.data() + i * K;
            const float* pB_f32 = B_f32.data() + j * K;
            float c_f32 = C_f32[i * N + j];
            float z = mFP16_mix_dotv2(K, pA_f16, pB_f16, c_f32);
            float g = ref_fp32_dotv2(K, pA_f32, pB_f32, c_f32);
            if (!fp32_equ(z, g))
            {
                ++err;
                float df = z - g;
                uint32_t di = F32toU32(z) - F32toU32(g);
                di = std::min(+di, -di);
                printf("[FP16 Mix %s] #%d, #%d: %g %g, Err = %e, Diff = 0x%x\n", shape, i, j, z, g, df, di);
            }
            D_f32[i * N + j] = z;
            G_f32[i * N + j] = g;
        }
    }

    if (err == 0)
    {
        printf("[FP16 Mix %s] PASS %d Cases\n", shape, M * N);
    }
    else
    {
        printf("[FP16 Mix %s] Fail %d in %d\n", shape, err, M * N);
    }
    #if OUTPUT_NPZ
    char npzName[64];
    snprintf(npzName, sizeof(npzName), "%s/FP16_Mix_%s.npz", NPZ_PATH.c_str(), shape);
    cnpy::npz_save(npzName, "A"  , A_f16, "w");
    cnpy::npz_save(npzName, "B"  , B_f16, "a");
    cnpy::npz_save(npzName, "C"  , C_f32, "a");
    cnpy::npz_save(npzName, "D"  , D_f32, "a");
    cnpy::npz_save(npzName, "Ref", G_f32, "a");
    printf("[FP16 Mix %s] Save NPZ: %s\n", shape, npzName);
    #endif
    return err;
}
