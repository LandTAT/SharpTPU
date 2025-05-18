import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.handle import SimHandleBase
from cocotb.regression import TestFactory
from cocotb.binary import BinaryValue
from cocotbext.axi import AxiLite4Master

# AXI4-Lite 总线操作助手类
class AxiLite4Master:
    def __init__(self, dut, name="aLiteCtrl", clock=None):
        self.dut = dut
        self.prefix = name
        self.clock = clock
        
        # 设置初始状态
        self.dut._id(f"{self.prefix}_awvalid", extended=False).value = 0
        self.dut._id(f"{self.prefix}_wvalid", extended=False).value = 0
        self.dut._id(f"{self.prefix}_bready", extended=False).value = 1
        self.dut._id(f"{self.prefix}_arvalid", extended=False).value = 0
        self.dut._id(f"{self.prefix}_rready", extended=False).value = 1

    # 写入操作
    async def write(self, address, data, strb=None):
        if strb is None:
            strb = 0xF  # 默认所有字节都启用

        # 发送地址
        self.dut._id(f"{self.prefix}_awaddr", extended=False).value = address
        self.dut._id(f"{self.prefix}_awvalid", extended=False).value = 1
        self.dut._id(f"{self.prefix}_awprot", extended=False).value = 0
        
        # 同时发送数据
        self.dut._id(f"{self.prefix}_wdata", extended=False).value = data
        self.dut._id(f"{self.prefix}_wstrb", extended=False).value = strb
        self.dut._id(f"{self.prefix}_wvalid", extended=False).value = 1
        
        # 等待握手完成
        while True:
            await RisingEdge(self.clock)
            aw_ready = int(self.dut._id(f"{self.prefix}_awready", extended=False).value)
            w_ready = int(self.dut._id(f"{self.prefix}_wready", extended=False).value)
            if aw_ready and w_ready:
                break
                
        # 清除有效信号
        self.dut._id(f"{self.prefix}_awvalid", extended=False).value = 0
        self.dut._id(f"{self.prefix}_wvalid", extended=False).value = 0
        
        # 等待响应
        while True:
            await RisingEdge(self.clock)
            b_valid = int(self.dut._id(f"{self.prefix}_bvalid", extended=False).value)
            if b_valid:
                break
                
        # 检查响应
        b_resp = int(self.dut._id(f"{self.prefix}_bresp", extended=False).value)
        return b_resp

    # 读取操作
    async def read(self, address):
        # 发送地址
        self.dut._id(f"{self.prefix}_araddr", extended=False).value = address
        self.dut._id(f"{self.prefix}_arvalid", extended=False).value = 1
        self.dut._id(f"{self.prefix}_arprot", extended=False).value = 0
        
        # 等待地址握手
        while True:
            await RisingEdge(self.clock)
            ar_ready = int(self.dut._id(f"{self.prefix}_arready", extended=False).value)
            if ar_ready:
                break
                
        # 清除有效信号
        self.dut._id(f"{self.prefix}_arvalid", extended=False).value = 0
        
        # 等待数据响应
        while True:
            await RisingEdge(self.clock)
            r_valid = int(self.dut._id(f"{self.prefix}_rvalid", extended=False).value)
            if r_valid:
                break
                
        # 获取数据和响应
        r_data = int(self.dut._id(f"{self.prefix}_rdata", extended=False).value)
        r_resp = int(self.dut._id(f"{self.prefix}_rresp", extended=False).value)
        return r_data, r_resp

# 寄存器映射
class Registers:
    START = 0x00
    FIELD = 0x04
    ADDR_A_LO = 0x08
    ADDR_A_HI = 0x0C
    ADDR_B_LO = 0x10
    ADDR_B_HI = 0x14
    ADDR_C_LO = 0x18
    ADDR_C_HI = 0x1C
    ADDR_D_LO = 0x20
    ADDR_D_HI = 0x24

# 测试开始
@cocotb.test()
async def test_axi4Lite_registers(dut):
    """测试AXI4-Lite接口的寄存器读写功能"""
    
    # 初始化时钟和复位
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # 创建AXI主机
    axi_master = AxiLite4Master(dut, clock=dut.clk)
    
    # 复位DUT
    dut.resetn.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.resetn.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    dut._log.info("测试开始")
    
    # 测试 START 信号 (应该是一个脉冲信号)
    await axi_master.write(Registers.START, 1)
    data, resp = await axi_master.read(Registers.START)
    assert data == 0, f"START寄存器应该自动清零, 读取到 {data}"
    dut._log.info("START寄存器测试通过")

    # 测试 FIELD 寄存器 (32位)
    dut.field.value = 0x114514
    test_value = 0xA5A5A5A5
    await axi_master.write(Registers.FIELD, test_value)
    data, resp = await axi_master.read(Registers.FIELD)
    assert data == 0x114514, f"FIELD寄存器值不匹配: 写入 {test_value:08x}, 读取到 {data:08x}"
    dut._log.info("FIELD寄存器测试通过")
    
    # 测试40位地址寄存器 addrA
    addr_a_lo = 0x12345678
    addr_a_hi = 0xAB
    await axi_master.write(Registers.ADDR_A_LO, addr_a_lo)
    await axi_master.write(Registers.ADDR_A_HI, addr_a_hi)
    
    data_lo, resp = await axi_master.read(Registers.ADDR_A_LO)
    data_hi, resp = await axi_master.read(Registers.ADDR_A_HI)
    
    assert data_lo == addr_a_lo, f"addrA低32位值不匹配: 写入 {addr_a_lo:08x}, 读取到 {data_lo:08x}"
    assert (data_hi & 0xFF) == addr_a_hi, f"addrA高8位值不匹配: 写入 {addr_a_hi:02x}, 读取到 {data_hi & 0xFF:02x}"
    dut._log.info("addrA寄存器测试通过")
    
    # 测试其他40位地址寄存器 (addrB, addrC, addrD)
    addresses = [
        # (lo_reg, hi_reg, name)
        (Registers.ADDR_B_LO, Registers.ADDR_B_HI, "addrB"),
        (Registers.ADDR_C_LO, Registers.ADDR_C_HI, "addrC"),
        (Registers.ADDR_D_LO, Registers.ADDR_D_HI, "addrD"),
    ]
    
    for lo_reg, hi_reg, name in addresses:
        # 生成随机测试值
        lo_value = random.randint(0, 0xFFFFFFFF)
        hi_value = random.randint(0, 0xFF)
        
        # 写入值
        await axi_master.write(lo_reg, lo_value)
        await axi_master.write(hi_reg, hi_value)
        
        # 读取并验证
        data_lo, resp = await axi_master.read(lo_reg)
        data_hi, resp = await axi_master.read(hi_reg)
        
        assert data_lo == lo_value, f"{name}低32位值不匹配: 写入 {lo_value:08x}, 读取到 {data_lo:08x}"
        assert (data_hi & 0xFF) == hi_value, f"{name}高8位值不匹配: 写入 {hi_value:02x}, 读取到 {data_hi & 0xFF:02x}"
        
        dut._log.info(f"{name}寄存器测试通过")
    
    # 测试同一个40位地址的连续写入和读取
    addr_combined_value = 0x9876543210
    lo_value = addr_combined_value & 0xFFFFFFFF  # 低32位
    hi_value = (addr_combined_value >> 32) & 0xFF  # 高8位
    print(f"写入的40位地址: {addr_combined_value:010x}, 低32位: {lo_value:08x}, 高8位: {hi_value:02x}")
    
    await axi_master.write(Registers.ADDR_D_LO, lo_value)
    await axi_master.write(Registers.ADDR_D_HI, hi_value)
    
    data_lo, _ = await axi_master.read(Registers.ADDR_D_LO)
    data_hi, _ = await axi_master.read(Registers.ADDR_D_HI)
    
    combined_read = (data_hi & 0xFF) << 32 | data_lo
    assert combined_read == addr_combined_value, f"40位组合值不匹配: 写入 {addr_combined_value:010x}, 读取到 {combined_read:010x}"
    dut._log.info("40位组合值测试通过")
    
    dut._log.info("所有测试通过!")


# 可以直接通过Python运行测试的入口点
def test_axi4lite():
    """运行测试的入口点"""
    # 设置测试路径
    tests_dir = os.path.dirname(__file__)
    dut_path = os.path.join(os.path.dirname(tests_dir), "hw/gen/axi4LiteFactory.v")
    
    # 运行测试
    runner = get_runner("icarus")
    runner.build(
        verilog_sources=[dut_path],
        toplevel="axi4LiteFactory",
        includes=[os.path.dirname(dut_path)]
    )
    runner.test(toplevel="axi4LiteFactory", py_module="test_Axi4Lite")


if __name__ == "__main__":
    # test_axi4lite()
    test_axi4Lite_registers()

