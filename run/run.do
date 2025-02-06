################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib

set rtl_dir         ../PurdNyUart/rtl/UartRx    ;   # RTL design folders for PurdNyUart
set rtl_ck_dir      ../CHIPKIT/ip/commctrl      ;   # RTL design folders for CHIPKIT
set uvm_dir         ../                         ;   # UVM libraries' directory
set top_level       top                         ;   # testbench top name
set top_level_sim   uart_sim_lib                ;   # top_level simulation library.
set test_bench      ${top_level}_tb             ;   # testbench name 
set uvm_test_name   tc_direct_urx               ;   # UVM testname

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

################################################################################
# COMPILE RTL_DESIGN MODULES
###############################################################################

##  for all libraries do the following: 
# create library, map to library, compile sources into library 
# tmpv stands for temporary variable 
set lib_folder uart;
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $rtl_dir UartRx.sv]

## for all libraries do the following: 
# create library, map to library, compile sources into library 
# tmpv stands for temporary variable 
set lib_folder uart ;
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name -E rtl_macros.svh ../CHIPKIT/ip/rtl_inc/RTL.svh
vlog -work $lib_name  [file join $rtl_ck_dir comm_defs_pkg.sv]
vlog -work $lib_name -mfcu ../CHIPKIT/ip/rtl_inc/RTL.svh [file join $rtl_ck_dir uart.sv]

################################################################################
# COMPILE SIMULATION MODULES
###############################################################################

set lib_name ${top_level_sim}
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name $uvm_dir/UVM_1.2/src/uvm_pkg.sv \+incdir+$uvm_dir/UVM_1.2/src/ +define+UVM_NO_DPI
vlog -work $lib_name -f compile_sv.f

# ################################################################################
# SIMULATE
# ################################################################################

vsim -voptargs=+acc                 \
    -L uart_lib                     \
    -lib ${top_level_sim}           \
    ${test_bench}                   \
    +UVM_TESTNAME=tc_direct_urx     \
    -t 1ns 
set NoQuitOnFinish 1
add wave -divider CHIPKIT
add wave -radix hexadecimal -position insertpoint sim:/top_tb/uart_rx_CHIPKIT_inst/*
add wave -divider PurdNyUart
add wave -radix hexadecimal -position insertpoint sim:/top_tb/uart_rx_PurdNyUart_inst/*
run -all