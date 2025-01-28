class uart_agent extends uvm_agent;
   `uvm_component_utils(uart_agent)

   extern function new(string name = "test_top" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);

endclass

function new(string name = "uart_agent", uvm_component parent);
    super.new(name, parent);
endfunction:new

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //  Create sequencer, driver, and monitor classes
endfunction:build_phase

virtual function void connect_phase(uvm_phase phase);
    // Connect driver and sequencer via TLM ports
endfunction:connect_phase