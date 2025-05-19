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
from cocotbext.axi import AxiRam, AxiBus, AxiMaster

@cocotb.test()
async def test_axi4(dut):
    """测试AXI4-Lite接口的寄存器读写功能"""
    
    # 初始化时钟和复位
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # 创建 AXI4-Lite 总线和主设备
    axi_bus = AxiBus.from_prefix(dut, "m_axi")
    axi_ram_A = AxiRam(axi_bus,dut.clk, dut.resetn, reset_active_level=False, size =  2**13)
    axi_ram_B = AxiRam(axi_bus,dut.clk, dut.resetn, reset_active_level=False, size =  2**13)
    axi_ram_C = AxiRam(axi_bus,dut.clk, dut.resetn, reset_active_level=False, size =  2**13)
    axi_ram_D = AxiRam(axi_bus,dut.clk, dut.resetn, reset_active_level=False, size =  2**13)
    
    # 复位DUT
    dut.resetn.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.resetn.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    dut._log.info("测试开始")