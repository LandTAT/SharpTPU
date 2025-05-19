import os
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge
from cocotbext.axi import AxiBus, AxiRam
from cocotbext.axi import AxiLiteBus, AxiLiteMaster

#%%
arithOp_Code = {
    "FP32": 0x1,
    "FP16": 0x2,
    "FP16_Mix": 0x3,
    "INT8": 0x4,
    "INT4": 0x5
}
matShape_Code = {
    (16, 16): 0x1,
    (32,  8): 0x2,
    ( 8, 32): 0x3
}
#%%
@cocotb.test()
async def sharpTPU_FPx(dut):
    # Load Data
    arith = "FP32"
    M, N, K = 32, 8, 16
    name = "../../funcModel/output/{:s}_m{:d}n{:d}k{:d}.npz".format(arith, M, N, K)
    tag = f"{arith} m{M}n{N}k{K}"
    data = np.load(name)
    A = data["A"].view(dtype=np.uint32).reshape(M, K)
    B = data["B"].view(dtype=np.uint32).reshape(N, K)
    C = data["C"].view(dtype=np.uint32).reshape(M, N)
    D = data["D"].view(dtype=np.uint32).reshape(M, N)
    B = B.transpose(1, 0)

    # VIP init
    axil_master = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "cfg"), dut.clk, dut.resetn, reset_active_level=False)
    axi_ram = AxiRam(AxiBus.from_prefix(dut, "axi"), dut.clk, dut.resetn, size=2**16, reset_active_level=False)
    axi_ram.write(0x1000, A.tobytes())
    axi_ram.write(0x2000, B.tobytes())
    axi_ram.write(0x3000, C.tobytes())

    # Create Clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Reset DUT
    dut.resetn.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)

    # Main
    await axil_master.write(0x04, (arithOp_Code[arith] | matShape_Code[M, N] << 8).to_bytes(4, byteorder="little"))
    await axil_master.write(0x08, 0x1000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x10, 0x2000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x18, 0x3000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x20, 0x4000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x0, 0x1.to_bytes(4, byteorder="little"))
    # for _ in range(512):
        # await RisingEdge(dut.clk)

    reg = -1
    while reg != 0x0:
        reg = await axil_master.read_dword(0x00)

    reg = await axil_master.read_dword(0x04)
    if reg & 0x10000:
        print(f"[{tag}] Detected Float NaN")
    if reg & 0x20000:
        print(f"[{tag}] Detected Float Inf")
    if reg & 0x40000:
        print(f"[{tag}] Detected Int Overflow")

    resItem = 2 if arith == "FP16" else 4
    result = axi_ram.read(0x4000, M * N * resItem)
    Z = np.frombuffer(result, dtype=np.uint32).reshape(M, N)

    print("[{:s}] {:s}".format(tag, "PASS" if np.all(Z == D) else "FAIL"))

    # print(Z == D)
    # print(Z)
    # print(D)

    for i in range(M):
        for j in range(N):
            # print("#{:2d},{:2d} {:08x} {:08x}".format(i, j, C[i, j], D[i, j]))
            if Z[i, j] != D[i, j]:
                print("#{:2d},{:2d} {:08x} {:08x} {:08x}".format(i, j, Z[i, j], D[i, j], Z[i, j] ^ D[i, j]))

    assert np.all(Z == D)

#%%
# @cocotb.test()
async def sharpTPU_Int8(dut):
    # Load Data
    arith = "INT8"
    M, N, K = 8, 32, 16
    path  = "../../dataset/int8_int32/"
    shape = "m{:d}n{:d}k{:d}".format(M, N, K)
    tag = f"{arith} {shape}"
    A = np.fromfile(os.path.join(path, shape, "a_int8_{:s}.bin".format(shape)) , dtype=np.int8 ).reshape(M, K)
    B = np.fromfile(os.path.join(path, shape, "b_int8_{:s}.bin".format(shape)) , dtype=np.int8 ).reshape(K, N)
    C = np.fromfile(os.path.join(path, shape, "c_int32_{:s}.bin".format(shape)), dtype=np.int32).reshape(M, N)
    # B = B.transpose(1, 0)

    AA = A.astype(np.int32)
    BB = B.astype(np.int32)
    CC = C.copy()
    DD = np.matmul(AA, BB) + CC

    # VIP init
    axil_master = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "cfg"), dut.clk, dut.resetn, reset_active_level=False)
    axi_ram = AxiRam(AxiBus.from_prefix(dut, "axi"), dut.clk, dut.resetn, size=2**16, reset_active_level=False)
    axi_ram.write(0x1000, A.tobytes())
    axi_ram.write(0x2000, B.tobytes())
    axi_ram.write(0x3000, C.tobytes())

    # Create Clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    # Reset DUT
    dut.resetn.value = 0
    for _ in range(10):
        await RisingEdge(dut.clk)
    
    dut.resetn.value = 1
    for _ in range(10):
        await RisingEdge(dut.clk)

    # Main
    await axil_master.write(0x04, (arithOp_Code[arith] | matShape_Code[M, N] << 8).to_bytes(4, byteorder="little"))
    await axil_master.write(0x08, 0x1000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x10, 0x2000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x18, 0x3000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x20, 0x4000.to_bytes(4, byteorder="little"))
    await axil_master.write(0x0, 0x1.to_bytes(4, byteorder="little"))
    # for _ in range(512):
    #     await RisingEdge(dut.clk)

    reg = -1
    while reg != 0x0:
        reg = await axil_master.read_dword(0x00)

    reg = await axil_master.read_dword(0x04)
    if reg & 0x10000:
        print(f"[{tag}] Detected Float NaN")
    if reg & 0x20000:
        print(f"[{tag}] Detected Float Inf")
    if reg & 0x40000:
        print(f"[{tag}] Detected Int Overflow")

    resItem = 2 if arith == "FP16" else 4
    result = axi_ram.read(0x4000, M * N * resItem)
    Z = np.frombuffer(result, dtype=np.int32).reshape(M, N)

    print("[{:s}] {:s}".format(tag, "PASS" if np.all(Z == DD) else "FAIL"))
    # print(Z)
    # print(D)
    # print(Z == DD)

    # for i in range(M):
    #     for j in range(N):
    #         # print("#{:2d},{:2d} {:08x} {:08x}".format(i, j, C[i, j], D[i, j]))
    #         if Z[i, j] != DD[i, j]:
    #             print("#{:2d},{:2d} {:08x} {:08x} {:08x}".format(i, j, Z[i, j], D[i, j], Z[i, j] ^ D[i, j]))

    assert np.all(Z == DD)
