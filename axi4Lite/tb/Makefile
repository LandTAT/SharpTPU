# Makefile

# defaults
# SIM ?= icarus
# WAVES ?= 1
SIM ?= verilator
EXTRA_ARGS += --trace --trace-fst --trace-structs
TOPLEVEL_LANG ?= verilog


TOPLEVEL = axi4LiteFactory
VERILOG_SOURCES += ../hw/gen/axi4LiteFactory.v
MODULE = test_Axi4Lite


# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# 清理所有生成的文件
clean_all: clean
	rm -rf __pycache__ *.xml
	rm -rf results.xml
	rm -rf sim_build
