class env_top extends uvm_env;
   `uvm_component_utils(env_top)
   
   extern function new ( string name = "env_top", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
endclass

function env_top::new(string name = "env_top", uvm_component parent);
   super.new(name, parent);
endfunction:new

function void env_top::build_phase(uvm_phase phase);
   super.build_phase(phase);  
endfunction:build_phase

function void env_top::connect_phase (uvm_phase phase);
   
endfunction:connect_phase