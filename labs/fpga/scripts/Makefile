# Generate the actual projects for building
MAKEFLAGS += --no-print-directory

# Top module for synthesis
TOPNAME = counter_top

default: 
	@echo "Please choose a specific target to build."
	@echo "'make bitfile' to generate a bit file for the Pynq Z1 board."

## Project generation
# Add "> ../build/logs/fpga.log 2>&1" after the @vivado command to reduce
# log output on screen
../build/fpga/$(TOPNAME).xpr: 
	@echo "Creating the Xilinx project"
	@mkdir -p ../build/fpga
	@mkdir -p ../build/logs
	@vivado -mode batch -nolog -nojou -source create_proj.tcl -tclargs $(TOPNAME)
	@echo "Created project"

# Add "> ../build/logs/fpga_impl.log 2>&1" after the @vivado command to 
# reduce log output on screen
bitfile: ../build/fpga/$(TOPNAME).xpr
	@echo "Synth and generate bitstream"
	@vivado -mode batch -nolog -nojou -source run_synth.tcl 
	

clean:
	@echo "Removing existing project"
	@$(RM) -rf ../build/fpga

