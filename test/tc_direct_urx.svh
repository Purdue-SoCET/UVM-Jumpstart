class tc_direct_urx extends test_top;
   `uvm_component_utils(tc_direct_urx)

   uart_sequence uart_sequence_h;

   extern function new(string name = "tc_direct_urx" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void start_of_simulation_phase  (uvm_phase phase);
   extern task run_phase(uvm_phase phase);

endclass:tc_direct_urx

function tc_direct_urx::new(string name = "tc_direct_urx" , uvm_component parent);
   super.new(name,parent);
endfunction:new

function void tc_direct_urx::build_phase(uvm_phase phase);
   super.build_phase(phase);
    // Create sequences
   uart_sequence_h = uart_sequence::type_id::create("uart_sequence_h");
endfunction:build_phase

function void tc_direct_urx::start_of_simulation_phase(uvm_phase phase);
   env_h.uart_scoreboard_h.expected_data.push_back(uart_sequence_h.req);
endfunction:start_of_simulation_phase

task tc_direct_urx::run_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info(get_type_name(), $sformatf(" XOXOXOX -1 bit : %0d ",env_h.uart_scoreboard_h.expected_data[0].data_arr.size()), UVM_LOW)
   // #1ms;
   `uvm_info("tc_direct_urx", "Hello from run_phase", UVM_LOW)
   // Start seqeuncer
   uart_sequence_h.start(env_h.uart_agent_h.sequencer_h);
   `uvm_info(get_type_name(), $sformatf(" XOXOXOX -2 bit : %0d ",env_h.uart_scoreboard_h.expected_data.size()), UVM_LOW)
   `uvm_info(get_type_name(), $sformatf(" XOXOXOX -3 bit : %0d ",uart_sequence_h.req.data_arr.size()), UVM_LOW)
   #100us;
   `uvm_info("tc_direct_urx", "end run_phase", UVM_LOW)
   phase.drop_objection(this);
endtask