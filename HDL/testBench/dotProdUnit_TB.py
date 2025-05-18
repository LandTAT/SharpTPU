import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge

#%%
def vec2bits(vec : np.ndarray, itemBits : int = 0):
    assert vec.ndim == 1
    itemBits = max(itemBits, vec.itemsize * 8)
    z = int(0)
    for i, x in enumerate(vec):
        z |= int(x) << (itemBits * i)
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

    # M, N, K = 16, 16, 16
    # M, N, K = 32,  8, 16
    M, N, K =  8, 32, 16
    LATENCY = 15

    # Load Data
    name = "../../funcModel/output/FP32_m{:d}n{:d}k{:d}.npz".format(M, N, K)
    data = np.load(name)
    A = data["A"].view(dtype=np.uint32).reshape(M, K)
    B = data["B"].view(dtype=np.uint32).reshape(N, K)
    C = data["C"].view(dtype=np.uint32).reshape(M, N)
    D = data["D"].view(dtype=np.uint32).reshape(M, N)

    dut.io_op.value = 0x1     # ArithOp.FP32

    for _ in range(20):
        await RisingEdge(dut.clk)

    err = 0
    for i in range(M * N + LATENCY + 1):
        rowA = i // N
        colB = i  % N
        if i < M * N:
            dut.io_vecA.value = vec2bits(A[rowA])
            dut.io_vecB.value = vec2bits(B[colB])
            dut.io_vecC.value = int(C[rowA, colB])
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            rowD = j // N
            colD = j  % N
            recv = int(dut.io_vecD) & 0xFFFFFFFF
            gold = D[rowD, colD]
            # print("#{:2d},{:2d} {:08x} {:08x} {:x}".format(rowD, colD, C[rowD, colD], gold, recv))
            if int(recv) != int(gold):
                err += 1
        await RisingEdge(dut.clk)
    
    for _ in range(20):
        await RisingEdge(dut.clk)
    print("[FP32_m{:d}n{:d}k{:d}] Err = {:d}".format(M, N, K, err))
    assert(err == 0)

#%%
@cocotb.test()
async def fp16dot_smoke(dut):
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

    # M, N, K = 16, 16, 16
    # M, N, K = 32,  8, 16
    M, N, K =  8, 32, 16
    P = 2
    LATENCY = 15

    # Load Data
    name = "../../funcModel/output/FP16_m{:d}n{:d}k{:d}.npz".format(M, N, K)
    data = np.load(name)
    A = data["A"].view(dtype=np.uint16).reshape(M, K)
    B = data["B"].view(dtype=np.uint16).reshape(N // P, P, K)
    C = data["C"].view(dtype=np.uint16).reshape(M, N // P, P)
    D = data["D"].view(dtype=np.uint16).reshape(M, N // P, P)
    B = B.transpose(0, 2, 1).reshape(-1, P * K)

    dut.io_op.value = 0x2     # ArithOp.FP16
    for _ in range(10):
        await RisingEdge(dut.clk)

    err = 0
    for i in range(M * N // P + LATENCY + 1):
        rowA = i // (N // P)
        colB = i  % (N // P)
        if i < M * N // P:
            vA = vec2bits(A[rowA], 32)
            vB = vec2bits(B[colB], 16)
            dut.io_vecA.value = vA | (vA << 16)
            dut.io_vecB.value = vB
            dut.io_vecC.value = vec2bits(C[rowA, colB], 32)
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            rowD = j // (N // P)
            colD = j  % (N // P)
            for p in range(P):
                recv = (int(dut.io_vecD) >> (32 * p)) & 0xFFFFFFFF
                # recv = int(dut.io_vecD)
                gold = D[rowD, colD, p]
                # print("#{:2d},{:2d} {:04x} {:04x} {:x}".format(rowD, colD * P + p, C[rowD, colD, p], gold, recv))
                if int(recv) != int(gold):
                    err += 1
        await RisingEdge(dut.clk)
    print("[FP16_m{:d}n{:d}k{:d}] Err = {:d}".format(M, N, K, err))
    assert(err == 0)

    for _ in range(20):
        await RisingEdge(dut.clk)

#%%
@cocotb.test()
async def fp16mixdot_smoke(dut):
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

    # M, N, K = 16, 16, 16
    # M, N, K = 32,  8, 16
    M, N, K =  8, 32, 16
    P = 2
    LATENCY = 15

    # Load Data
    name = "../../funcModel/output/FP16_Mix_m{:d}n{:d}k{:d}.npz".format(M, N, K)
    data = np.load(name)
    A = data["A"].view(dtype=np.uint16).reshape(M, K)
    B = data["B"].view(dtype=np.uint16).reshape(N // P, P, K)
    C = data["C"].view(dtype=np.uint32).reshape(M, N // P, P)
    D = data["D"].view(dtype=np.uint32).reshape(M, N // P, P)
    B = B.transpose(0, 2, 1).reshape(-1, P * K)

    dut.io_op.value = 0x3     # ArithOp.FP16_MIX
    for _ in range(10):
        await RisingEdge(dut.clk)

    err = 0
    for i in range(M * N // P + LATENCY + 1):
        rowA = i // (N // P)
        colB = i  % (N // P)
        if i < M * N // P:
            vA = vec2bits(A[rowA], 32)
            vB = vec2bits(B[colB], 16)
            dut.io_vecA.value = vA | (vA << 16)
            dut.io_vecB.value = vB
            dut.io_vecC.value = vec2bits(C[rowA, colB])
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            rowD = j // (N // P)
            colD = j  % (N // P)
            for p in range(P):
                recv = (int(dut.io_vecD) >> (32 * p)) & 0xFFFFFFFF
                # recv = int(dut.io_vecD)
                gold = D[rowD, colD, p]
                # print("#{:2d},{:2d} {:04x} {:04x} {:x}".format(rowD, colD * P + p, C[rowD, colD, p], gold, recv))
                if int(recv) != int(gold):
                    err += 1
        await RisingEdge(dut.clk)

    print("[FP16Mix_m{:d}n{:d}k{:d}] Err = {:d}".format(M, N, K, err))
    assert(err == 0)

    for _ in range(20):
        await RisingEdge(dut.clk)

#%%
@cocotb.test()
async def int8dot_smoke(dut):
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

    # M, N, K = 16, 16, 16
    # M, N, K = 32,  8, 16
    M, N, K =  8, 32, 16
    P = 4
    LATENCY = 10

    # Load Data
    path  = "../../dataset/int8_int32/"
    shape = "m{:d}n{:d}k{:d}".format(M, N, K)
    A = np.fromfile(os.path.join(path, shape, "a_int8_{:s}.bin".format(shape)) , dtype=np.int8 ).reshape(M, K)
    B = np.fromfile(os.path.join(path, shape, "b_int8_{:s}.bin".format(shape)) , dtype=np.int8 ).reshape(K, N)
    C = np.fromfile(os.path.join(path, shape, "c_int32_{:s}.bin".format(shape)), dtype=np.int32).reshape(M, N)
    B = B.transpose(1, 0)

    AA = A.astype(np.int32)
    BB = B.astype(np.int32)
    CC = C.copy()

    A = A.view(dtype=np.uint8 )
    B = B.view(dtype=np.uint8 ).reshape(N // P, P, K)
    C = C.view(dtype=np.uint32).reshape(M, N // P, P)
    B = B.transpose(0, 2, 1).reshape(-1, P * K)

    dut.io_op.value = 0x4     # ArithOp.INT8
    for _ in range(10):
        await RisingEdge(dut.clk)

    err = 0
    for i in range(M * N // P + LATENCY + 1):
        rowA = i // (N // P)
        colB = i  % (N // P)
        if i < M * N // P:
            vA = vec2bits(A[rowA], 32)
            vB = vec2bits(B[colB], 8)
            dut.io_vecA.value = vA | (vA << 8) | (vA << 16) | (vA << 24)
            dut.io_vecB.value = vB
            dut.io_vecC.value = vec2bits(C[rowA, colB], 32)
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            rowD = j // (N // P)
            colD = j  % (N // P)
            for p in range(P):
                recv = (int(dut.io_vecD) >> (32 * p)) & 0xFFFFFFFF
                # recv = int(dut.io_vecD)
                gold = np.dot(AA[rowD], BB[colD * P + p]) + CC[rowD, colD * P + p]
                gold = gold.view(dtype=np.uint32)
                # print("#{:2d},{:2d} {:04x} {:04x} {:x}".format(rowD, colD * P + p, C[rowD, colD, p], gold, recv))
                if int(recv) != int(gold):
                    err += 1
        await RisingEdge(dut.clk)
    print("[INT8_m{:d}n{:d}k{:d}] Err = {:d}".format(M, N, K, err))
    assert(err == 0)

    for _ in range(20):
        await RisingEdge(dut.clk)

    # rowA = 1 // (M // P)
    # colB = 1  % (N // P)
    # vA = vec2bits(A[rowA], 32)
    # vB = vec2bits(B[colB], 32)
    # dut.io_vecA.value = vA
    # dut.io_vecB.value = vB
    # dut.io_vecC.value = int(C[rowA, colB])

    # for _ in range(20):
    #     await RisingEdge(dut.clk)

    # prod = AA[rowA] * BB[colB]
    # accm = prod.sum(dtype=np.int32)
    # gold = accm + CC[rowA, colB]
    # gold = gold.view(dtype=np.uint32)
    # recv = int(dut.io_vecD)
    # print(hex(gold), hex(recv))
    # assert gold == recv
