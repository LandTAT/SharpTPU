import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge

#%%
@cocotb.test()
async def matTrans_test(dut):
    # Create Clock
    clock = Clock(dut.clk, 5, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Reset DUT
    dut.resetn.value = 0
    dut.io_inValid.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)

    # 生成测试数据
    N = 8
    random_float32 = np.random.random((N, N)).astype(np.float32)
    random_uint32 = random_float32.view(dtype=np.uint32)
    
    # 创建输出矩阵
    output_matrix = np.zeros((N, N), dtype=np.uint32)
    
    # 等待输入就绪
    while dut.io_inReady.value == 0:
        await RisingEdge(dut.clk)
    
    # 输入就绪后，连续N个周期发送每一行数据
    if dut.io_inReady.value == 1:
        dut.io_inValid.value = 1  # 设置输入有效信号
        
        for row in range(N):
            # 设置这一行的所有数据
            for col in range(N):
                getattr(dut, f"io_inBus_{col}").value = int(random_uint32[row][col])
            
            # 等待一个时钟周期进入下一行
            await RisingEdge(dut.clk)
        
        # 所有数据发送完毕后清除有效信号
        dut.io_inValid.value = 0
    
    # 等待输出就绪
    timeout_cycles = 10
    for _ in range(timeout_cycles):
        if dut.io_outReady.value == 1:
            break
        await RisingEdge(dut.clk)
    
    # 输出就绪后，连续N个周期接收每一行数据
    if dut.io_outReady.value == 1:
        for row in range(N):
            # 收集当前行的输出数据
            for col in range(N):
                if(dut.io_outValid.value == 1):
                    output_matrix[row][col] = int(getattr(dut, f"io_outBus_{col}").value)
            # 等待一个时钟周期进入下一行
            await RisingEdge(dut.clk)
    
       # 等待输出就绪
    timeout_cycles = 10
    for _ in range(timeout_cycles):
        if dut.io_inReady.value == 1:
            break
        await RisingEdge(dut.clk)

    # 将原始矩阵转置以进行比较
    expected_transpose = np.transpose(random_uint32)
    
    # 比较结果
    is_correct = np.array_equal(output_matrix, expected_transpose)
    if is_correct:
        print("矩阵转置成功！输出与预期完全匹配")
    else:
        print("矩阵转置不匹配")
        print(f"预期矩阵:\n{expected_transpose}")
        print(f"实际输出:\n{output_matrix}")
        
        # 分析差异
        diff_indices = np.where(output_matrix != expected_transpose)
        print(f"不匹配的元素数量: {len(diff_indices[0])}")
        for i, j in zip(diff_indices[0], diff_indices[1]):
            print(f"位置 [{i},{j}]: 预期 {expected_transpose[i,j]} 实际 {output_matrix[i,j]}")

    # 浮点数比较
    # expected_float = expected_transpose.view(dtype=np.float32)
    # output_float = output_matrix.view(dtype=np.float32)

    # print(f"作为浮点数比较:")
    # print(f"预期浮点矩阵:\n{expected_float}")
    # print(f"实际浮点矩阵:\n{output_float}")

# %%
