# Makefile

# defaults
# SIM ?= icarus
# WAVES ?= 1
SIM ?= verilator
EXTRA_ARGS += --trace --trace-fst --trace-structs
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../hw/gen/MatTransNxNStream.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = MatTransNxNStream

# MODULE is the basename of the Python test file
MODULE = test_MatTrans

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
