################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib

set rtl_dir         ../PurdNyUart/rtl/UartRx/   ;   # RTL design folder for PurdNyUart
set rtl_ck_dir      ../CHIPKIT/ip/commctrl/     ;   # RTL design folder for CHIPKIT
set rtl_ck_inc_dir  ../CHIPKIT/ip/rtl_inc/      ;   # RTL design macros folder for CHIPKIT
set agent_dir       ../agent/                   ;   # agent directory
set env_dir         ../environment/             ;   # environment directory
set uvm_dir         ../UVM_1.2/src/             ;   # UVM libraries' directory
set top_level       top                         ;   # testbench top name
set top_level_sim   uart_sim_lib                ;   # top_level simulation library.
set test_bench      ${top_level}_tb             ;   # testbench name 
set top_dir         ../$test_bench              ;   # Top level testbench directory
set uvm_test        tc_direct_urx_utx           ;   # UVM testname
set uvm_verbosity   UVM_LOW                     ;   # Set verbosity level for the prints

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

################################################################################
# COMPILE RTL DESIGN FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 
set lib_folder uart;
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $rtl_dir UartRx.sv]

# for all libraries do the following: 
# create library, map to library, compile sources into library 
# tmpv stands for temporary variable 
set lib_folder uart ;
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name -E rtl_macros.svh  [file join $rtl_ck_inc_dir RTL.svh      ]
vlog -work $lib_name                    [file join $rtl_ck_dir comm_defs_pkg.sv ]
vlog -work $lib_name -mfcu              [file join $rtl_ck_inc_dir RTL.svh      ] \
                                        [file join $rtl_ck_dir uart.sv          ]

################################################################################
# COMPILE VERIFICATION FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 
set lib_name ${top_level_sim}
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $uvm_dir uvm_pkg.sv     ]   +incdir+$uvm_dir +define+UVM_NO_DPI
vlog -work $lib_name [file join $agent_dir uart_pkg.svh ]   +incdir+$agent_dir+$uvm_dir
vlog -work $lib_name [file join $top_dir top_tb.sv      ]   +incdir+$agent_dir+$uvm_dir+$env_dir

# ################################################################################
# SIMULATE
# ################################################################################

vsim -voptargs=+acc                 \
    -L uart_lib                     \
    -lib ${top_level_sim}           \
    ${test_bench}                   \
    +UVM_VERBOSITY=$uvm_verbosity   \
    +UVM_TESTNAME=$uvm_test         \
    -t 1ns 
set NoQuitOnFinish 1
add wave -divider uart_if_inst
add wave -radix hexadecimal -position insertpoint sim:/top_tb/uart_if_inst/*
add wave -divider CHIPKIT
add wave -radix hexadecimal -position insertpoint sim:/top_tb/uart_rx_CHIPKIT_inst/*
add wave -divider PurdNyUart
add wave -radix hexadecimal -position insertpoint sim:/top_tb/uart_rx_PurdNyUart_inst/*
run -all