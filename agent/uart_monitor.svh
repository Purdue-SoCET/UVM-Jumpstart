class uart_monitor extends uvm_monitor;
   // UVM macro Factory registration
   `uvm_component_utils(uart_monitor)

   // Config class  
   uart_config uart_config_h;
   // Virtual interface    
   virtual uart_if vif;
   real bit_time;

   // The monitored data written to monitor_port
  uvm_analysis_port #(uart_seqit) monitor_port;

   extern function new(string name = "uart_monitor", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task collect_data();
endclass:uart_monitor

function uart_monitor::new(string name ="uart_monitor",uvm_component parent);
   super.new(name, parent);
   monitor_port = new("monitor_port", this);
endfunction:new

function void uart_monitor::build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction:build_phase

function void uart_monitor::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   vif = uart_config_h.vif;
endfunction:start_of_simulation_phase

task uart_monitor::run_phase(uvm_phase phase);

   // Calculating bit per second
   bit_time = (1s / real'(uart_config_h.baud_rate));
   // Wait reset
   @(posedge vif.resetn_i);
   forever begin
         collect_data();
   end
endtask:run_phase

task uart_monitor::collect_data();
   forever begin
      uart_seqit mon_seqit;
      mon_seqit = uart_seqit::type_id::create("mon_seqit");

      // Detect start bit
      wait(!vif.tx_dout_o);
      // Wait until middle of start bit
      #(bit_time/2);

      if(vif.tx_dout_o == 0) begin
         START_BIT_PASSED: `uvm_info(get_type_name(), "Start bit is detected ", UVM_LOW)
      end else begin
         START_BIT_FAILED: `uvm_error(get_type_name(), "Start Bit is not detected")
      end

      // Calculate parity with data from bus
      for(int i = 0; i < uart_config_h.number_data_bits; i++) begin
         #(bit_time);
         mon_seqit.mon_data[i] <= vif.tx_dout_o;
      end

      // Go to the middle of first stop bit
      #(bit_time);
      if(vif.tx_dout_o == 1'b1) begin
         STOP_BIT_PASSED_FIRST: `uvm_info(get_type_name(), "First stop bit is detected", UVM_LOW)
      end else begin
         STOP_BIT_FAILED_FIRST: `uvm_error(get_type_name(), "First Stop bit is not detected")
      end
      // Go to the middle of second stop bit
      #(bit_time);
      if(vif.tx_dout_o == 1'b1) begin
         STOP_BIT_PASSED_SECOND: `uvm_info(get_type_name(), "Second stop bit is detected", UVM_LOW)
      end else begin
         STOP_BIT_FAILED_SECOND: `uvm_error(get_type_name(), "Second stop bit is not detected")
      end
      monitor_port.write(mon_seqit);
   end

endtask: collect_data

