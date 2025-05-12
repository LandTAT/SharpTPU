import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge

def concatenate_uint32_row(row):
    result = 0
    for i, val in enumerate(row):
        # 左移相应位数并添加当前值
        result |= (int(val) << (i * 32))
    return result

#%%
@cocotb.test(timeout_time=1000, timeout_unit="ns")
# async def matTrans_test(dut):
#     # Create Clock
#     clock = Clock(dut.clk, 5, units="ns")
#     cocotb.start_soon(clock.start(start_high=False))

#     # Reset DUT
#     dut.resetn.value = 0
#     dut.io_inValid.value = 0
#     for _ in range(10):
#         await RisingEdge(dut.clk)
    
#     dut.resetn.value = 1
#     for _ in range(10):
#         await RisingEdge(dut.clk)

#     # 生成测试数据
#     N = 8
#     # random_float32 = np.random.random((N, N)).astype(np.float32)
#     # random_uint32 = random_float32.view(dtype=np.uint32)
#     random_uint32 = np.arange(1,65, dtype=np.uint32).reshape(N, N)
    
#     # 创建输出矩阵
#     output_matrix = np.zeros((N, N), dtype=np.uint32)
    
#     # 等待输入就绪
#     while dut.io_inReady.value == 0:
#         await RisingEdge(dut.clk)
    
#     # 输入就绪后，连续N个周期发送每一行数据
#     if dut.io_inReady.value == 1:
#         # 先设置输入有效信号为高
#         dut.io_inValid.value = 1
        
#         for row in range(N):
#             # 设置这一行的所有数据
#             for col in range(N):
#                 getattr(dut, f"io_inBus_{col}").value = int(random_uint32[row][col])

#             # 模拟中断 - 注意使用整数除法确保得到整数结果
#             if row == (N-1)//2:  # 使用//进行整数除法
#                 # 输出调试信息
#                 print(f"在第{row}行模拟输入中断10个时钟周期")
                
#                 # 将输入有效信号设为低，模拟中断
#                 dut.io_inValid.value = 0
                
#                 # 等待10个时钟周期
#                 for _ in range(10):
#                     await RisingEdge(dut.clk)
                    
#                 # 恢复输入有效信号
#                 dut.io_inValid.value = 1
                
#                 # 可能需要重新设置当前行数据(取决于你的硬件设计)
#                 for col in range(N):
#                     getattr(dut, f"io_inBus_{col}").value = int(random_uint32[row][col])
            
#             # 等待一个时钟周期进入下一行
#             await RisingEdge(dut.clk)

#         # 所有数据发送完毕后清除有效信号
#         dut.io_inValid.value = 0
        
#         # 清除输入总线数据
#         for col in range(N):
#             getattr(dut, f"io_inBus_{col}").value = 0
    
#     for _ in range(10):
#         await RisingEdge(dut.clk)
#     dut.io_outReady.value = 1

#     while dut.io_outValid.value == 0:
#         await RisingEdge(dut.clk)
    
#     # 输出就绪后，连续N个周期接收每一行数据
#     if dut.io_outValid.value == 1:
#         for row in range(N):
#             for col in range(N):
#                 output_matrix[row][col] = int(getattr(dut, f"io_outBus_{col}").value)
# # 模拟中断 - 注意使用整数除法确保得到整数结果
#             if row == (N-1)//2:  # 使用//进行整数除法
#                 # 输出调试信息
#                 print(f"在第{row}行模拟输入中断10个时钟周期")
                
#                 # 将输入有效信号设为低，模拟中断
#                 dut.io_outReady.value = 0
                
#                 # 等待10个时钟周期
#                 for _ in range(10):
#                     await RisingEdge(dut.clk)
                    
#                 # 恢复输入有效信号
#                 dut.io_outReady.value = 1

#             # 等待一个时钟周期进入下一行
#             await RisingEdge(dut.clk)

            

#     while dut.io_outValid.value == 1:
#         await RisingEdge(dut.clk)

#     # 将原始矩阵转置以进行比较
#     expected_transpose = np.transpose(random_uint32)
    
#     # 比较结果
#     print("测试一")
#     is_correct = np.array_equal(output_matrix, expected_transpose)
#     if is_correct:
#         print("矩阵转置成功！输出与预期完全匹配")
#     else:
#         print("矩阵转置不匹配")
#         print(f"预期矩阵:\n{expected_transpose}")
#         print(f"实际输出:\n{output_matrix}")
        
#         # 分析差异
#         diff_indices = np.where(output_matrix != expected_transpose)
#         print(f"不匹配的元素数量: {len(diff_indices[0])}")
#         for i, j in zip(diff_indices[0], diff_indices[1]):
#             print(f"位置 [{i},{j}]: 预期 {expected_transpose[i,j]} 实际 {output_matrix[i,j]}")

async def matTransNxNStream_test(dut):
    # Create Clock
    clock = Clock(dut.clk, 5, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Reset DUT
    dut.resetn.value = 0
    dut.io_input_valid.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)

    # 生成测试数据
    N = 8
    # random_float32 = np.random.random((N, N)).astype(np.float32)
    # random_uint32 = random_float32.view(dtype=np.uint32)
    random_uint32 = np.arange(1,65, dtype=np.uint32).reshape(N, N)
    
    # 创建输出矩阵
    output_matrix = np.zeros((N, N), dtype=np.uint32)
    
    # 等待输入就绪
    while dut.io_input_ready.value == 0:
        await RisingEdge(dut.clk)
    
    # 输入就绪后，连续N个周期发送每一行数据
    if dut.io_input_ready.value == 1:
        # 先设置输入有效信号为高
        dut.io_input_valid.value = 1
        
        for row in range(N):
            # 设置这一行的所有数据
            dut.io_input_payload.value = concatenate_uint32_row(random_uint32[row])
            # 模拟中断 - 注意使用整数除法确保得到整数结果
            if row == (N-1)//2:  # 使用//进行整数除法
                # 输出调试信息
                print(f"在第{row}行模拟输入中断10个时钟周期")
                
                # 将输入有效信号设为低，模拟中断
                dut.io_input_valid.value = 0
                
                # 等待10个时钟周期
                for _ in range(10):
                    await RisingEdge(dut.clk)
                    
                # 恢复输入有效信号
                dut.io_input_valid.value = 1
                
                # 可能需要重新设置当前行数据(取决于你的硬件设计)
                dut.io_input_payload.value = concatenate_uint32_row(random_uint32[row])
            
            # 等待一个时钟周期进入下一行
            await RisingEdge(dut.clk)

        # 所有数据发送完毕后清除有效信号
        dut.io_input_valid.value = 0
        
        # 清除输入总线数据
        dut.io_input_payload.value = 0
    
    for _ in range(10):
        await RisingEdge(dut.clk)
    dut.io_output_ready.value = 1

    while dut.io_output_valid.value == 0:
        await RisingEdge(dut.clk)
    
    # 输出就绪后，连续N个周期接收每一行数据
    if dut.io_output_valid.value == 1:
        for row in range(N):
            # 接收这一行的所有数据
            output_matrix[row] = np.frombuffer(int(dut.io_output_payload.value).to_bytes(4*N, byteorder='little'), dtype=np.uint32)
            if row == (N-1)//2:  # 使用//进行整数除法
                # 输出调试信息
                print(f"在第{row}行模拟输入中断10个时钟周期")
                
                # 将输入有效信号设为低，模拟中断
                dut.io_output_ready.value = 0
                
                # 等待10个时钟周期
                for _ in range(10):
                    await RisingEdge(dut.clk)
                    
                # 恢复输入有效信号
                dut.io_output_ready.value = 1

            # 等待一个时钟周期进入下一行
            await RisingEdge(dut.clk)

            

    while dut.io_output_valid.value == 1:
        await RisingEdge(dut.clk)

    # 将原始矩阵转置以进行比较
    expected_transpose = np.transpose(random_uint32)
    
    # 比较结果
    print("测试一")
    is_correct = np.array_equal(output_matrix, expected_transpose)
    if is_correct:
        print("矩阵转置成功！输出与预期完全匹配")
        print(f"预期矩阵:\n{expected_transpose}")
        print(f"实际输出:\n{output_matrix}")
    else:
        print("矩阵转置不匹配")
        print(f"预期矩阵:\n{expected_transpose}")
        print(f"实际输出:\n{output_matrix}")
        
        # 分析差异
        diff_indices = np.where(output_matrix != expected_transpose)
        print(f"不匹配的元素数量: {len(diff_indices[0])}")
        for i, j in zip(diff_indices[0], diff_indices[1]):
            print(f"位置 [{i},{j}]: 预期 {expected_transpose[i,j]} 实际 {output_matrix[i,j]}")

if __name__ == "__main__":
    matTransNxNStream_test(dut)


# # 主函数部分
# if __name__ == "__main__":
#     # 导入所需库
#     from cocotb.runner import get_runner
#     import sys
    
#     # 设置测试参数
#     sim = os.getenv("SIMULATOR", "verilator")  # 默认仿真器为xsim
#     test_module = "test_MatTrans"  # 当前模块名称
#     toplevel = "MatTransNxNStream"  # 顶层模块名称
#     verilog_sources = ["../hw/gen/MatTransNxNStream.v"]  # Verilog源文件
    
#     # 如果命令行参数指定了其他测试
#     if len(sys.argv) > 1 and sys.argv[1] == "MatTransNxN":
#         toplevel = "MatTransNxN"
#         verilog_sources = ["../hw/gen/MatTransNxN.v"]
    
#     # 使用cocotb运行器运行测试
#     runner = get_runner(sim)
#     runner.build(
#         verilog_sources=verilog_sources,
#         toplevel=toplevel,
#         always=True  # 始终重新构建
#     )
    
#     # 运行测试
#     runner.test(
#         toplevel=toplevel,
#         test_module=test_module,
#         testcase="matTransNxNStream_test" if toplevel == "MatTransNxNStream" else "matTrans_test"
#     )
    
#     print(f"{'-'*40}")
#     print(f"测试完成: {toplevel}")
#     print(f"{'-'*40}")
