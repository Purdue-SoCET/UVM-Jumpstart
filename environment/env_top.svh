class env_top extends uvm_env;
   `uvm_component_utils(env_top)
   
   // Instantiate UART agent and settings
   uart_agent uart_agent_h;
   uart_config uart_agent_config_h;

   extern function new ( string name = "env_top", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
endclass

function env_top::new(string name = "env_top", uvm_component parent);
   super.new(name, parent);
endfunction:new

function void env_top::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // Get virtual interfaces from config_db
   if(!uvm_config_db #(virtual uart_if)::get(this,"", $sformatf("uart_vif"),uart_agent_config_h.vif)) begin
      VIF_FATAL: `uvm_fatal("VIF CONFIG","cannot get uart_vif from uvm_config_db")
   end
endfunction:build_phase

function void env_top::connect_phase (uvm_phase phase);
   
endfunction:connect_phase