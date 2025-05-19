# Makefile

# defaults
SIM ?= icarus
WAVES ?= 1
# SIM ?= verilator
# EXTRA_ARGS += --trace --trace-fst --trace-structs
TOPLEVEL_LANG ?= verilog

# VERILOG_SOURCES += ../hw/gen/dotProdUnit.v
VERILOG_SOURCES += ../hw/gen/sharpTPUTop.v ../hw/verilog/z_sdpram.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
# TOPLEVEL = dotProdUnit
TOPLEVEL = sharpTPUTop

# MODULE is the basename of the Python test file
# MODULE = dotProdUnit_TB
MODULE = sharpTPU_TB

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
