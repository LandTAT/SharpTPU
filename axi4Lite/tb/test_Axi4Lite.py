import os
import random
from pathlib import Path

import numpy as np
import cocotb
from cocotb.clock import Clock
from cocotb.runner import get_runner
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.regression import TestFactory

# 导入 cocotbext.axi 中的 AxiLiteMaster
from cocotbext.axi import AxiLiteBus, AxiLiteMaster

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
    
    # 创建 AXI4-Lite 总线和主设备
    axi_lite_bus = AxiLiteBus.from_prefix(dut, "aLiteCtrl")
    axi_master = AxiLiteMaster(axi_lite_bus, dut.clk, dut.resetn, reset_active_level=False)
    
    # 复位DUT
    dut.resetn.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.resetn.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    dut._log.info("测试开始")
    
    # 测试 START 信号 (应该是一个脉冲信号)
    await axi_master.write(Registers.START, b'\x01\x00\x00\x00')  # 写入1 (小端序)
    data = await axi_master.read(Registers.START, 4)
    read_val = int.from_bytes(data, byteorder='little')
    assert read_val == 0, f"START寄存器应该自动清零, 读取到 {read_val}"
    dut._log.info("START寄存器测试通过")

    # 测试 FIELD 寄存器 (32位)
    test_value = 0xA5A5A5A5
    dut.field.value = 0x114514  # 设置输入值
    
    # 写入测试值
    await axi_master.write(Registers.FIELD, test_value.to_bytes(4, byteorder='little'))
    
    # 读取并验证
    data = await axi_master.read(Registers.FIELD, 4)
    read_val = int.from_bytes(data, byteorder='little')
    
    # field是输入信号，所以应该保持dut.field的值，而不是我们写入的值
    assert read_val == 0x114514, f"FIELD寄存器值不匹配: 期望 0x114514, 读取到 {read_val:08x}"
    dut._log.info("FIELD寄存器测试通过")
    
    # 测试40位地址寄存器 addrA
    addr_a_lo = 0x12345678
    addr_a_hi = 0xAB
    
    await axi_master.write(Registers.ADDR_A_LO, addr_a_lo.to_bytes(4, byteorder='little'))
    await axi_master.write(Registers.ADDR_A_HI, addr_a_hi.to_bytes(4, byteorder='little'))
    
    data_lo = await axi_master.read(Registers.ADDR_A_LO, 4)
    data_hi = await axi_master.read(Registers.ADDR_A_HI, 4)
    
    read_lo = int.from_bytes(data_lo, byteorder='little')
    read_hi = int.from_bytes(data_hi, byteorder='little') & 0xFF
    
    assert read_lo == addr_a_lo, f"addrA低32位值不匹配: 写入 {addr_a_lo:08x}, 读取到 {read_lo:08x}"
    assert read_hi == addr_a_hi, f"addrA高8位值不匹配: 写入 {addr_a_hi:02x}, 读取到 {read_hi:02x}"
    dut._log.info("addrA寄存器测试通过")
    
    # 测试其他40位地址寄存器 (addrB, addrC, addrD)
    addresses = [
        (Registers.ADDR_B_LO, Registers.ADDR_B_HI, "addrB"),
        (Registers.ADDR_C_LO, Registers.ADDR_C_HI, "addrC"),
        (Registers.ADDR_D_LO, Registers.ADDR_D_HI, "addrD"),
    ]
    
    for lo_reg, hi_reg, name in addresses:
        # 生成随机测试值
        lo_value = random.randint(0, 0xFFFFFFFF)
        hi_value = random.randint(0, 0xFF)
        
        # 写入值
        await axi_master.write(lo_reg, lo_value.to_bytes(4, byteorder='little'))
        await axi_master.write(hi_reg, hi_value.to_bytes(4, byteorder='little'))
        
        # 读取并验证
        data_lo = await axi_master.read(lo_reg, 4)
        data_hi = await axi_master.read(hi_reg, 4)
        
        read_lo = int.from_bytes(data_lo, byteorder='little')
        read_hi = int.from_bytes(data_hi, byteorder='little') & 0xFF
        
        assert read_lo == lo_value, f"{name}低32位值不匹配: 写入 {lo_value:08x}, 读取到 {read_lo:08x}"
        assert read_hi == hi_value, f"{name}高8位值不匹配: 写入 {hi_value:02x}, 读取到 {read_hi:02x}"
        
        dut._log.info(f"{name}寄存器测试通过")
    
    # 测试同一个40位地址的连续写入和读取
    addr_combined_value = 0x9876543210
    lo_value = addr_combined_value & 0xFFFFFFFF  # 低32位
    hi_value = (addr_combined_value >> 32) & 0xFF  # 高8位
    
    print(f"写入的40位地址: {addr_combined_value:010x}, 低32位: {lo_value:08x}, 高8位: {hi_value:02x}")
    
    await axi_master.write(Registers.ADDR_D_LO, lo_value.to_bytes(4, byteorder='little'))
    await axi_master.write(Registers.ADDR_D_HI, hi_value.to_bytes(4, byteorder='little'))
    
    data_lo = await axi_master.read(Registers.ADDR_D_LO, 4)
    data_hi = await axi_master.read(Registers.ADDR_D_HI, 4)
    
    read_lo = int.from_bytes(data_lo, byteorder='little')
    read_hi = int.from_bytes(data_hi, byteorder='little') & 0xFF
    
    combined_read = (read_hi << 32) | read_lo
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
    test_axi4lite()

