# Makefile

# defaults
# SIM ?= icarus
# WAVES ?= 1
SIM ?= verilator
EXTRA_ARGS += --trace --trace-fst --trace-structs
TOPLEVEL_LANG ?= verilog

# 根据CONFIG变量选择顶层模块和源文件
ifeq ($(CONFIG), nxn)
  TOPLEVEL = MatTransNxNStream
  VERILOG_SOURCES += ../hw/gen/MatTransNxNStream.v
  MODULE = test_MatTrans
else ifeq ($(CONFIG), mxn)
  TOPLEVEL = MatTransMxNStream
  VERILOG_SOURCES += ../hw/gen/MatTransMxNStream.v
  MODULE = test_MatTransMxN
endif

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# 便捷目标
.PHONY: nxn mxn clean_all

# 不同配置的便捷目标
nxn:
	$(MAKE) CONFIG=nxn

mxn:
	$(MAKE) CONFIG=mxn

# 强制重新构建目标
force_nxn:
	$(MAKE) clean
	$(MAKE) CONFIG=nxn

force_mxn:
	$(MAKE) clean
	$(MAKE) CONFIG=mxn

# 清理所有生成的文件
clean_all: clean
	rm -rf __pycache__ *.xml
	rm -rf results.xml
	rm -rf sim_build
