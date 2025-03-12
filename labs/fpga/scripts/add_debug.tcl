# Top level VIO and ILA for settings and debug

# Generic VIO with inputs and outputs to test counter
# Outputs (input to DUT)
# - clksel - external clock or internal
# - clkpulse: pulse clock for single stepping
# - rst_n  - reset
# - load_en - load enable
# - up_dn  - up/down select
# - enable - counter enable
# - load_val[3:0] - 4 bit input
# Inputs (output of DUT)
# - count[3:0] - 4 bit output
create_ip -name vio -vendor xilinx.com -library ip -version 3.0 \
    -module_name top_vio
set_property -dict [list \
    CONFIG.C_NUM_PROBE_OUT {7} \
    CONFIG.C_PROBE_OUT0_WIDTH {1} \
    CONFIG.C_PROBE_OUT1_WIDTH {1} \
    CONFIG.C_PROBE_OUT2_WIDTH {1} \
    CONFIG.C_PROBE_OUT3_WIDTH {1} \
    CONFIG.C_PROBE_OUT4_WIDTH {1} \
    CONFIG.C_PROBE_OUT5_WIDTH {1} \
    CONFIG.C_PROBE_OUT6_WIDTH {4} \
    CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
    CONFIG.C_NUM_PROBE_IN {1} \
    CONFIG.C_PROBE_IN0_WIDTH {4} \
    ] [get_ips top_vio]

# ILA for monitoring counter output: relevant only in free-running clock
# - depth = 1024 samples
# - 1 probe of 4 bits for counter
# Component name: top_ila
create_ip -name ila -vendor xilinx.com -library ip -version 6.2 \
    -module_name top_ila
set_property -dict [list \
    CONFIG.C_DATA_DEPTH {1024} \
    CONFIG.C_PROBE0_WIDTH {1} \
    CONFIG.C_PROBE1_WIDTH {4} \
    CONFIG.C_NUM_OF_PROBES {2} \
    ] [get_ips top_ila]


################################################################################
# Other examples that can be adapted as needed
################################################################################
# Example of ILA with
# - depth = 1024 samples
# - 7 probes, with widths defined for each probe
# Component name: top_ila
# create_ip -name ila -vendor xilinx.com -library ip -version 6.2 \
#     -module_name top_ila
# set_property -dict [list \
#     CONFIG.C_DATA_DEPTH {1024} \
#     CONFIG.C_PROBE6_WIDTH {16} \
#     CONFIG.C_PROBE5_WIDTH {16} \
#     CONFIG.C_PROBE4_WIDTH {16} \
#     CONFIG.C_PROBE3_WIDTH {16} \
#     CONFIG.C_PROBE2_WIDTH {1} \
#     CONFIG.C_PROBE1_WIDTH {1} \
#     CONFIG.C_PROBE0_WIDTH {8} \
#     CONFIG.C_NUM_OF_PROBES {7} \
#     ] [get_ips top_ila]
