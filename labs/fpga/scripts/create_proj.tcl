# Script for generating Xilinx project for Pynq and synthesizing
# Original Author: Nitin Chandrachoodan <nitin@ee.iitm.ac.in>
#

if {$argc != 1} {
    puts "Error: Must specify name of top module"
    puts "Usage:  -source create_proj.tcl -tclargs <top_module> "
    exit 1
}
set top_module [lindex $argv 0]

set buildDir "../build/fpga"
set projName "$top_module"

# Create project - FIXME - what if it already exists?
create_project $projName $buildDir -part xc7z020clg400-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

source "./add_hdl_constr.tcl"
source "./add_debug.tcl"

# Set Top module - different for dummy/channel sound
set obj [get_filesets sources_1]
set_property -name "top" -value "$top_module" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj
