# Add HDL files

add_files -fileset sources_1 [list \
	"../src/counter.sv" \
	"../src/counter_top.sv" \
]

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Add/Import constrs file and set constrs file properties
add_files -fileset constrs_1 [list \
	"../src/PYNQ-Z1_C.xdc"\
	]
