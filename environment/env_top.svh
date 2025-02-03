class env_top extends uvm_env;
   `uvm_component_utils(env_top)
   
   // Instantiate UART agent and settings
   uart_agent uart_agent_h;
   uart_config uart_agent_config_h;

   extern function new ( string name = "env_top", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern function void configuration();
endclass

function env_top::new(string name = "env_top", uvm_component parent);
   super.new(name, parent);
endfunction:new

function void env_top::build_phase(uvm_phase phase);
   super.build_phase(phase);

   // Construct config class
   uart_agent_config_h = uart_config::type_id::create("uart_agent_config_h", this);
   // Construct agent class
   uart_agent_h = uart_agent::type_id::create("uart_agent_h",this);

   // Get virtual interfaces from config_db
   if(!uvm_config_db #(virtual uart_if)::get(this,"", $sformatf("uart_vif"),uart_agent_config_h.vif)) begin
      VIF_FATAL: `uvm_fatal("VIF CONFIG","cannot get uart_vif from uvm_config_db")
   end
   // Set the config paramaeters (baud, parity, reset poloarity. etc) of the agent
   uvm_config_db #(uart_config)::set(this,"uart_agent_h", "uart_config", uart_agent_config_h);
   
   // Configure agent
   configuration();    
   
endfunction:build_phase

function void env_top::connect_phase (uvm_phase phase);
   
endfunction:connect_phase

function void env_top::configuration();
   
   uart_agent_config_h.baud_rate        = 9_600;
   uart_agent_config_h.number_data_bits = "EIGHT_WIDTH";
   uart_agent_config_h.reset_polarity   = "ACTIVE_LOW";
   uart_agent_config_h.parity_type      = "PARITY_NONE";
   uart_agent_config_h.number_stop_bits = "STOP_BIT_ONEBIT";
   
endfunction: configuration