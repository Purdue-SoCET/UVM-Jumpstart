class uart_driver extends uvm_driver #(uart_seqit);
   `uvm_component_utils(uart_driver)

    extern function new(string name = "test_top" , uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task void run_phase(uvm_phase phase)

endclass:uart_driver

function new(string name = "uart_driver", uvm_component parent);
    super.new(name, parent);
endfunction:new

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

virtual function void connect(uvm_phase phase);
endfunction:connect_phase

virtual task run_phase(uvm_phase phase);
endtask:run_phase