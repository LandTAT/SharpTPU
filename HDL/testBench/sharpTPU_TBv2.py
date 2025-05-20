import os
import logging
import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge
from cocotbext.axi import AxiBus, AxiRam
from cocotbext.axi import AxiLiteBus, AxiLiteMaster

#%%
ROOT_DATASET = "../../dataset/"
ROOT_FUNCMOD = "../../funcModel/output"
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
def loadBin(M, N, K, mat, folder, typeName = None):
    assert mat in ("a", "b", "c")
    if  typeName is None:
        typeName = folder
    shape = f"m{M}n{N}k{K}"
    fpath = os.path.join(ROOT_DATASET, folder, shape, f"{mat}_{typeName}_{shape}.bin")
    dtype = {
        "fp32" : np.uint32,
        "fp16" : np.uint16,
        "int8" : np.int8  ,
        "int32": np.int32
    } [typeName]
    data = np.fromfile(fpath, dtype=dtype)
    return data

def loadGoldenFP(arith, M, N, K = 16):
    shape = f"m{M}n{N}k{K}"
    fpath = os.path.join(ROOT_FUNCMOD, f"{arith}_{shape}.npz")
    data  = np.load(fpath)
    return data["D"].reshape(M, N)

def calcGoldenInt(A, B, C):
    AA = A.astype(np.int32)
    BB = B.astype(np.int32)
    CC = C.copy()
    DD = np.matmul(AA, BB) + CC
    return DD

def loadDataset(arith, M, N, K = 16):
    if   arith == "FP32":
        A = loadBin(M, N, K, "a", "fp32").reshape(M, K)
        B = loadBin(M, N, K, "b", "fp32").reshape(K, N)
        C = loadBin(M, N, K, "c", "fp32").reshape(M, N)
        D = loadGoldenFP(arith, M, N, K).view(dtype=C.dtype)
    elif arith == "FP16":
        A = loadBin(M, N, K, "a", "fp16").reshape(M, K)
        B = loadBin(M, N, K, "b", "fp16").reshape(K, N)
        C = loadBin(M, N, K, "c", "fp16").reshape(M, N)
        D = loadGoldenFP(arith, M, N, K).view(dtype=C.dtype)
    elif arith == "FP16_Mix":
        A = loadBin(M, N, K, "a", "fp16").reshape(M, K)
        B = loadBin(M, N, K, "b", "fp16").reshape(K, N)
        C = loadBin(M, N, K, "c", "fp32").reshape(M, N)
        D = loadGoldenFP(arith, M, N, K).view(dtype=C.dtype)
    elif arith == "INT8":
        A = loadBin(M, N, K, "a", "int8_int32", "int8" ).reshape(M, K)
        B = loadBin(M, N, K, "b", "int8_int32", "int8" ).reshape(K, N)
        C = loadBin(M, N, K, "c", "int8_int32", "int32").reshape(M, N)
        D = calcGoldenInt(A, B, C)
    else:
        assert False    # arith Error
    return A, B, C, D

#%% Main TB
async def sharpTPU_Test(dut, arith, M, N, K):
    # Load Dataset
    A, B, C, D = loadDataset(arith, M, N, K)
    tag = f"{arith} m{M}n{N}k{K}"

    # AXIL Master VIP
    axil_master = AxiLiteMaster(AxiLiteBus.from_prefix(dut, "cfg"), dut.clk, dut.resetn, reset_active_level=False)
    # AXI4 Slave Memory VIP
    addrA, addrB = 0x1000, 0x2000
    addrC, addrD = 0x3000, 0x4000
    axi_ram = AxiRam(AxiBus.from_prefix(dut, "axi"), dut.clk, dut.resetn, size=2**16, reset_active_level=False)
    axi_ram.write(addrA, A.tobytes())   # Backdoor write MatA to Axi VIP
    axi_ram.write(addrB, B.tobytes())   # Backdoor write MatB to Axi VIP
    axi_ram.write(addrC, C.tobytes())   # Backdoor write MatC to Axi VIP

    # Create Clock
    clock = Clock(dut.clk, 5, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
    # Reset DUT
    dut.resetn.value = 0
    for _ in range(5):
        await RisingEdge(dut.clk)
    dut.resetn.value = 1
    for _ in range(5):
        await RisingEdge(dut.clk)

    # Config TPU
    confg = arithOp_Code[arith] | matShape_Code[M, N] << 8
    await axil_master.write(0x04, confg.to_bytes(4, byteorder="little"))    # Set ArithOp & Matrix Shape
    await axil_master.write(0x08, addrA.to_bytes(4, byteorder="little"))    # Set MatA Address
    await axil_master.write(0x10, addrB.to_bytes(4, byteorder="little"))    # Set MatB Address
    await axil_master.write(0x18, addrC.to_bytes(4, byteorder="little"))    # Set MatC Address
    await axil_master.write(0x20, addrD.to_bytes(4, byteorder="little"))    # Set MatD Address
    await axil_master.write(0x00,   0x1.to_bytes(4, byteorder="little"))    # Start the TPU

    reg = -1
    while reg != 0x0:   # Polling until TPU State == IDLE
        reg = await axil_master.read_dword(0x00)

    # Arithmetic Exception Detection
    reg = await axil_master.read_dword(0x04)
    if reg & 0x10000:
        print(f"[{tag}] Detected Float NaN")
    if reg & 0x20000:
        print(f"[{tag}] Detected Float Inf")
    if reg & 0x40000:
        print(f"[{tag}] Detected Int Overflow")

    # Compare with Golden Result
    memD = axi_ram.read(addrD, M * N * D.itemsize)  # Backdoor read MatD from VIP
    Z = np.frombuffer(memD, dtype=D.dtype).reshape(M, N)
    print("[{:s}] {:s}".format(tag, "PASS" if np.all(Z == D) else "FAIL"))
    assert np.all(Z == D)

#%%
@cocotb.test()
async def sharpTPU_FP32_M16N16K16(dut):
    await sharpTPU_Test(dut, "FP32", 16, 16, 16)
@cocotb.test()
async def sharpTPU_FP32_M8N32K16(dut):
    await sharpTPU_Test(dut, "FP32",  8, 32, 16)
@cocotb.test()
async def sharpTPU_FP32_M32N8K16(dut):
    await sharpTPU_Test(dut, "FP32", 32,  8, 16)

@cocotb.test()
async def sharpTPU_FP16_M16N16K16(dut):
    await sharpTPU_Test(dut, "FP16", 16, 16, 16)
@cocotb.test()
async def sharpTPU_FP16_M8N32K16(dut):
    await sharpTPU_Test(dut, "FP16",  8, 32, 16)
@cocotb.test()
async def sharpTPU_FP16_M32N8K16(dut):
    await sharpTPU_Test(dut, "FP16", 32,  8, 16)

@cocotb.test()
async def sharpTPU_FP16Mix_M16N16K16(dut):
    await sharpTPU_Test(dut, "FP16_Mix", 16, 16, 16)
@cocotb.test()
async def sharpTPU_FP16Mix_M8N32K16(dut):
    await sharpTPU_Test(dut, "FP16_Mix",  8, 32, 16)
@cocotb.test()
async def sharpTPU_FP16Mix_M32N8K16(dut):
    await sharpTPU_Test(dut, "FP16_Mix", 32,  8, 16)

@cocotb.test()
async def sharpTPU_INT8_M16N16K16(dut):
    await sharpTPU_Test(dut, "INT8", 16, 16, 16)
@cocotb.test()
async def sharpTPU_INT8_M8N32K16(dut):
    await sharpTPU_Test(dut, "INT8",  8, 32, 16)
@cocotb.test()
async def sharpTPU_INT8_M32N8K16(dut):
    await sharpTPU_Test(dut, "INT8", 32,  8, 16)
