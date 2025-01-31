class uart_agent extends uvm_agent;
   `uvm_component_utils(uart_agent)

   // Handle Driver, Monitor, Sequencer, and Config classes
   uart_driver driver_h;
   uart_monitor monitor_h;
   uart_sequencer sequencer_h;
   uart_config uart_config_h;

   extern function new(string name = "uart_agent" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);

endclass

function uart_agent::new(string name = "uart_agent", uvm_component parent);
    super.new(name, parent);
endfunction:new

function void uart_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //  Create sequencer, driver, and monitor classes
endfunction:build_phase

function void uart_agent::connect_phase(uvm_phase phase);
    // Connect driver and sequencer via TLM ports
endfunction:connect_phase