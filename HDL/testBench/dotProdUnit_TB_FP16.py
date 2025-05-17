import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge

#%%

# SIZE_M = 32
# SIZE_N = 8
# SIZE_K = 16
# ARITHOP = "FP32"


SIZE_M = 16
SIZE_N = 16
SIZE_K = 16
ARITHOP = "FP16"


def vec2bits(vec_or_vecs, row_count=1):
    """
    将一维或二维NumPy数组转换为位模式，支持多行拼接
    
    参数:
        vec_or_vecs: 一维数组(单行)或二维数组(多行)
        row_count: 要处理的行数(默认为1)
    
    返回:
        拼接后的整数位模式
    """
    # 处理输入是单行的情况
    if isinstance(vec_or_vecs, np.ndarray) and vec_or_vecs.ndim == 1:
        # 单行版本，原有实现
        if np.issubdtype(vec_or_vecs.dtype, np.integer):
            bitwidth = np.iinfo(vec_or_vecs.dtype).bits
        else:
            bitwidth = np.finfo(vec_or_vecs.dtype).bits
            
        z = int(0)
        for i, x in enumerate(vec_or_vecs):
            z |= int(x) << (bitwidth * i)
        return z
        
    # 处理多行情况
    # 确保输入是一个行列表
    if not isinstance(vec_or_vecs, list):
        vec_or_vecs = [vec_or_vecs]
    
    # 确保我们最多处理row_count行
    rows_to_process = min(len(vec_or_vecs), row_count)
    
    # 获取数据类型位宽
    if np.issubdtype(vec_or_vecs[0].dtype, np.integer):
        bitwidth = np.iinfo(vec_or_vecs[0].dtype).bits
    else:
        bitwidth = np.finfo(vec_or_vecs[0].dtype).bits
    
    z = int(0)
    
    # 按行处理
    for row_idx in range(rows_to_process):
        vec = vec_or_vecs[row_idx]
        assert vec.ndim == 1, f"第{row_idx}行必须是一维数组"
        
        # 计算此行的位移基数 - 高位行在高位
        base_shift = row_idx * (bitwidth * len(vec))
        
        # 拼接当前行的所有元素
        for i, x in enumerate(vec):
            # 按左高右低的顺序排列
            z |= int(x) << (base_shift + bitwidth * i)
    
    return z


#%%
@cocotb.test()
async def fp32dot_smoke(dut):
    # Create Clock
    clock = Clock(dut.clk, 5, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Initial values
    dut.io_op.value   = 0
    dut.io_vecA.value = 0
    dut.io_vecB.value = 0
    dut.io_vecC.value = 0

    # Reset DUT
    dut.resetn.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)


    if (ARITHOP == "FP32"):
        dut.io_op.value = 0x1     # ArithOp.FP32
        DATA_TYPE_AB = np.uint32
        DATA_TYPE_CD = np.uint32
        SPEED = 1
    elif (ARITHOP == "FP16"):
        dut.io_op.value = 0x2
        DATA_TYPE_AB = np.uint16
        DATA_TYPE_CD = np.uint16
        SPEED = 2
    elif (ARITHOP == "FP16_MIX"):
        dut.io_op.value = 0x3
        DATA_TYPE_AB = np.uint16
        DATA_TYPE_CD = np.uint32
        SPEED
    elif (ARITHOP == "INT8"):
        dut.io_op.value = 0x4
        DATA_TYPE_AB = np.uint8
        DATA_TYPE_CD = np.uint32
        SPEED = 4
    elif (ARITHOP == "INT4"):
        dut.io_op.value = np.uint4
        DATA_TYPE_AB = np.uint32
        DATA_TYPE_CD = np.uint32
        SPEED = 8
    else:
        raise ValueError("Invalid ARITHOP value")
    

    # Load Data
    dataPath = "../../funcModel/output/" + ARITHOP + "_m" + str(SIZE_M) + "n" + str(SIZE_N) + "k" + str(SIZE_K) +".npz"
    # data = np.load("../../funcModel/output/FP32_m16n16k16.npz")
    data = np.load(dataPath)

    A = data["A"].view(dtype=DATA_TYPE_AB).reshape(SIZE_M, SIZE_K)
    B = data["B"].view(dtype=DATA_TYPE_AB).reshape(SIZE_N, SIZE_K)
    C = data["C"].view(dtype=DATA_TYPE_CD).reshape(SIZE_M, SIZE_N)
    D = data["D"].view(dtype=DATA_TYPE_CD).reshape(SIZE_M, SIZE_N)
    print("Loading data from", dataPath)
    print("A.shape", A.shape)   
    print("B.shape", B.shape)
    print("C.shape", C.shape)
    print("D.shape", D.shape)



    for _ in range(20):
        await RisingEdge(dut.clk)

    err = 0

    LATENCY = 15
    # FP16/FP32: 15

    # 在不同精度模式下正确处理矩阵乘法

    # 修正后的循环
    for i in range(0, (SIZE_M*SIZE_N)//SPEED + LATENCY + 1):
        r_base = (i * SPEED) // SIZE_N  # 基础行索引
        c_base = (i * SPEED) % SIZE_N   # 基础列索引
        
        if r_base < SIZE_M:
            # 处理A矩阵 - 需要SPEED行数据
            a_rows = []
            for s in range(SPEED):
                if r_base + s < SIZE_M:
                    a_rows.append(A[r_base + s])
                else:
                    # 填充0行
                    a_rows.append(np.zeros_like(A[0]))
            
            # 处理B矩阵 - 对于矩阵乘法，我们需要SIZE_K列的数据
            dut.io_vecA.value = vec2bits(a_rows, row_count=SPEED)
            dut.io_vecB.value = vec2bits(B[c_base])  # B只需要一列
            
            # 处理C矩阵 - 需要对应的SPEED个元素
            c_values = []
            for s in range(SPEED):
                if r_base + s < SIZE_M and c_base < SIZE_N:
                    c_values.append(C[r_base + s, c_base])
                else:
                    c_values.append(0)
            
            # 根据硬件设计，C值可能需要特定打包
            if SPEED == 1:
                # FP32模式 - 单个C值
                dut.io_vecC.value = int(c_values[0])
            elif SPEED == 2:
                # FP16模式 - 打包两个C值
                c_packed = 0
                for idx, val in enumerate(c_values):
                    c_packed |= int(val) << (32 * idx)
                dut.io_vecC.value = c_packed
            elif SPEED == 4:
                # INT8模式 - 打包四个C值
                c_packed = 0
                for idx, val in enumerate(c_values):
                    c_packed |= int(val) << (32 * idx)
                dut.io_vecC.value = c_packed
            else:
                # 其他模式
                dut.io_vecC.value = vec2bits(np.array(c_values, dtype=DATA_TYPE_CD))
        else:
            # 循环结束后的值置零
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        
        # 检查输出
        if i > LATENCY:
            j = i - (LATENCY + 1)
            r1_base = (j * SPEED) // SIZE_N
            c1_base = (j * SPEED) % SIZE_N
            
            # 检查SPEED个输出结果
            for s in range(SPEED):
                if r1_base + s < SIZE_M and c1_base < SIZE_N:
                    # 从vecD中提取对应位置的结果
                    shift = s * 32  # 每个结果32位
                    result_val = (int(dut.io_vecD.value) >> shift) & 0xFFFFFFFF
                    expected_val = int(D[r1_base + s, c1_base])
                    
                    print(f"#{r1_base+s:2d},{c1_base:2d} {C[r1_base+s,c1_base]:x} {expected_val:x} {result_val:x}")
                    
                    if result_val != expected_val:
                        err += 1
                        print(f"错误: 位置[{r1_base+s},{c1_base}] 期望:{expected_val:x} 实际:{result_val:x}")
        
        # 等待下一个时钟周期
        await RisingEdge(dut.clk)
    
    for _ in range(20):
        await RisingEdge(dut.clk)

    print("Err =", err)
    assert(err == 0)
