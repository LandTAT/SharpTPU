# Makefile

# defaults
# SIM ?= icarus
# WAVES ?= 1
SIM ?= verilator
EXTRA_ARGS += --trace --trace-fst --trace-structs
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += ../hw/gen/FloatMultiplier.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = FloatMultiplier

# MODULE is the basename of the Python test file
MODULE = test_FloatMul

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
