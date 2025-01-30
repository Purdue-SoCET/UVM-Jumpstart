################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib
#set smalldesign 1  ; 
set enable_optimization 0  ; 
# for small designs or for development no need to optimize..  
# also free simulation tools, modelsim for intel only supports non-optimized designs. 

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

# ################################################################################
# # SIMULATE
# ################################################################################

if [file exists work] {vdel -all}
vlib work
vlog ../uvm_1.2/src/uvm_pkg.sv +incdir+../uvm_1.2/src/ +define+UVM_NO_DPI
vlog -f compile_sv.f