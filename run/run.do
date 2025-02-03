################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib
#set smalldesign 1  ; 
set enable_optimization 0  ; 

set rtl_dir   ../PurdNyUart/rtl/UartRx; 
# for small designs or for development no need to optimize..  
# also free simulation tools, modelsim for intel only supports non-optimized designs. 

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

################################################################################
# COMPILE RTL_DESIGN MODULES.
###############################################################################

##  for all libraries do the following: 
# create library, map to library, compile sources into library 
# tmpv stands for temporary variable 
set lib_folder uart ; #normally lib_folder
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $rtl_dir UartRx.sv]

# ################################################################################
# # SIMULATE
# ################################################################################

if [file exists work] {vdel -all}
vlib work
vlog ../uvm_1.2/src/uvm_pkg.sv +incdir+../uvm_1.2/src/ +define+UVM_NO_DPI
vlog -f compile_sv.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs="+acc" -L uart_lib top_tb +UVM_TESTNAME=tc_direct_urx -t 10ns
add wave -position end sim:/top_tb/uart_rx_inst/*
run -all