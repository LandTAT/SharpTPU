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
    data = np.load("../../funcModel/output/FP32_m16n16k16.npz")
    A = data["A"].view(dtype=np.uint32).reshape(16, 16)
    B = data["B"].view(dtype=np.uint32).reshape(16, 16)
    C = data["C"].view(dtype=np.uint32).reshape(16, 16)
    D = data["D"].view(dtype=np.uint32).reshape(16, 16)

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
    for i in range(16 * 16 + LATENCY + 1):
        r = i // 16
        c = i  % 16
        if i < 16 * 16:
            dut.io_vecA.value = vec2bits(A[r])
            dut.io_vecB.value = vec2bits(B[c])
            dut.io_vecC.value = int(C[r, c])
        else:
            dut.io_vecA.value = 0
            dut.io_vecB.value = 0
            dut.io_vecC.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            r1 = j // 16
            c1 = j  % 16
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
