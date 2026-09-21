IVERILOG := iverilog
VVP := vvp

#Flags
IVERILOG_FLAGS := -Wall -g2012 -Iinclude
VVP_FLAGS :=-v -l sim/log

# Directories
BUILD_DIR := build
VCD_DIR := sim
SRC_DIR := src
TB_DIR := tb

# List of all source files (excluding testbenches)
VERILOG_SOURCES := $(wildcard $(SRC_DIR)/*.sv)

# Testbenches to build and run. The names here should match the module names in your testbench files.
TESTBENCHES := \
	booth_tb \


# Default target: compile and run all testbenches
.PHONY: all
all: prepare $(TESTBENCHES)

# Create output directories
prepare:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(VCD_DIR)

# Compile each testbench into .out (intermediate representation for vvp)
# This rule now includes all source files.
# The top module for compilation (-s flag) is passed as a variable here.
$(BUILD_DIR)/%.out: $(TB_DIR)/%.sv $(VERILOG_SOURCES)
	@echo "Compiling $< (and dependencies) -> $@"
	$(IVERILOG) $(IVERILOG_FLAGS) -s $(*F) $(VERILOG_SOURCES) $< -o $@

# Run each compiled testbench and move .vcd output if generated
# This uses the specific testbench name for logging and VCD output.
run_%: $(BUILD_DIR)/%.out
	echo "Running $(*F)"
	$(VVP) $< $(VVP_FLAGS) > $(VCD_DIR)/$*.log
	if [ -f $*.vcd ]; then mv $*.vcd $(VCD_DIR)/; fi




# Pattern rule for running testbenches
$(TESTBENCHES): %: run_%

# Optional clean rule
clean:
	rm -rf $(BUILD_DIR) $(VCD_DIR)
