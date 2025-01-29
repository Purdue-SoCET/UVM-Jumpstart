class uart_monitor extends uvm_monitor;
   `uvm_component_utils(uart_monitor)

   extern function new(string name = "uart_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
endclass:uart_monitor

function uart_monitor::new(string name ="uart_monitor",uvm_component parent);
   super.new(name, parent);
endfunction:new

function void uart_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction:build_phase

function void uart_monitor::connect_phase(uvm_phase phase);
endfunction

task uart_monitor::run_phase(uvm_phase phase);
endtask:run_phase
