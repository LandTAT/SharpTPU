# Makefile

# defaults
# SIM ?= icarus
WAVES ?= 1
SIM ?= verilator
# 为Verilator添加波形记录参数
ifeq ($(WAVES), 1)
    EXTRA_ARGS += --trace --trace-fst
    PLUSARGS += -v
endif
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../hw/gen/dotProdUnit.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = dotProdUnit

# MODULE is the basename of the Python test file
MODULE = dotProdUnit_TB

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
