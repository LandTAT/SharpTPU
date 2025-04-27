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
async def fpMul_test(dut):
    # Create Clock
    clock = Clock(dut.clk, 5, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Initial values
    dut.io_xf.value = 0
    dut.io_yf.value = 0

    # Reset DUT
    dut.resetn.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)

    # Feed Data
    data = np.load("../../funcModel/output/FP32_MUL_corner_case.npz")
    X = data["A"].view(dtype=np.uint32)
    Y = data["B"].view(dtype=np.uint32)
    Z = data["Z"].view(dtype=np.uint32)
    N = Z.size
    print("N =", N)

    LATENCY = 5
    for i in range(N + LATENCY):
        if i < N:
            dut.io_xf.value = int(X[i])
            dut.io_yf.value = int(Y[i])
        else:
            dut.io_xf.value = 0
            dut.io_yf.value = 0
        if i > LATENCY:
            j = i - (LATENCY + 1)
            print("#{:d} {:x} {:x} {:x} {:x}".format(j, X[j], Y[j], Z[j], int(dut.io_zf.value)))
            assert dut.io_zf.value == int(Z[j])
        await RisingEdge(dut.clk)
    
    for _ in range(10):
        await RisingEdge(dut.clk)
