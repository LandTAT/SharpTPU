import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge

#%%
def vec2bits(vec : np.ndarray):
    assert vec.ndim == 1
    assert vec.dtype == np.uint32
    z = int(0)
    for i, x in enumerate(vec):
        z |= int(x) << (32 * i)
    return z

# SIZE_M = 16
# SIZE_N = 16
# SIZE_K = 16
# ARITHOP = "FP32"
SIZE_M = 32
SIZE_N = 8
SIZE_K = 16
ARITHOP = "FP32"


# object ArithOp extends SpinalEnum {
#     val FP32, FP16, FP16_MIX, INT8, INT4 = newElement()
#     defaultEncoding = SpinalEnumEncoding("staticEncoding") (
#         FP32     -> 0x1,
#         FP16     -> 0x2,
#         FP16_MIX -> 0x3,
#         INT8     -> 0x4,
#         INT4     -> 0x5
#     )
# }


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

    # Load Data
    dataPath = "../../funcModel/output/" + ARITHOP + "_m" + str(SIZE_M) + "n" + str(SIZE_N) + "k" + str(SIZE_K) +".npz"
    # data = np.load("../../funcModel/output/FP32_m16n16k16.npz")
    data = np.load(dataPath)

    A = data["A"].view(dtype=np.uint32).reshape(SIZE_M, SIZE_K)
    B = data["B"].view(dtype=np.uint32).reshape(SIZE_K, SIZE_N)
    C = data["C"].view(dtype=np.uint32).reshape(SIZE_M, SIZE_N)
    D = data["D"].view(dtype=np.uint32).reshape(SIZE_M, SIZE_N)
    print("Loading data from", dataPath)
    print("A.shape", A.shape)   
    print("B.shape", B.shape)
    print("C.shape", C.shape)
    print("D.shape", D.shape)
    dut.io_op.value = 0x1     # ArithOp.FP32

    for _ in range(20):
        await RisingEdge(dut.clk)

    # dut.io_vecA.value = vec2bits(A[8])
    # dut.io_vecB.value = vec2bits(B[11])
    # dut.io_vecC.value = int(C[8, 11])
    # print(hex(A[8]))
    # print(hex(B[11]))
    # print(hex(C[8, 11]), hex(D[8, 11]))

    err = 0

    LATENCY = 15
    # FP16/FP32: 15

    for i in range(SIZE_M * SIZE_N + LATENCY + 1):
        r = i // SIZE_N
        c = i  % SIZE_N
        # print("i", i, "r", r, "c", c)
        if i < SIZE_M * SIZE_N:
            dut.io_vecA.value = vec2bits(A[r])  
            dut.io_vecB.value = vec2bits(B[c])
            dut.io_vecC.value = int(C[r, c])
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            r1 = j // SIZE_N
            c1 = j  % SIZE_N
            print("i", i, "j", j, "r1", r1, "c1", c1)
            print("#{:2d},{:2d} {:x} {:x} {:x}".format(r1, c1, C[r1, c1], D[r1, c1], int(dut.io_vecD.value) & 0xFFFFFFFF))
            if (int(dut.io_vecD) & 0xFFFFFFFF) != int(D[r1, c1]):
                err += 1
            # assert (int(dut.io_vecD) & 0xFFFFFFFF) == int(D[r1, c1])
        await RisingEdge(dut.clk)
    
    for _ in range(20):
        await RisingEdge(dut.clk)

    print("Err =", err)
    assert(err == 0)

    # print(int(dut.io_vecD) & 0xFFFFFFFF)
    # assert (int(dut.io_vecD) & 0xFFFFFFFF) == int(D[8, 11])
