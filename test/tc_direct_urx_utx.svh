class tc_direct_urx_utx extends test_top;
   // UVM macro Factory registration
   `uvm_component_utils(tc_direct_urx_utx)

   uart_sequence uart_sequence_h;
   bit [7:0] exp_data[4] = {8'hBA, 8'h5E, 8'hBA, 8'h11};

   extern function new(string name = "tc_direct_urx_utx" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void start_of_simulation_phase  (uvm_phase phase);
   extern task run_phase(uvm_phase phase);

endclass:tc_direct_urx_utx

function tc_direct_urx_utx::new(string name = "tc_direct_urx_utx" , uvm_component parent);
   super.new(name,parent);
endfunction:new

function void tc_direct_urx_utx::build_phase(uvm_phase phase);
   super.build_phase(phase);
    // Create sequences
   uart_sequence_h = uart_sequence::type_id::create("uart_sequence_h");
endfunction:build_phase

function void tc_direct_urx_utx::start_of_simulation_phase(uvm_phase phase);

   foreach (exp_data[i]) begin
      uart_seqit exp_data_h;
      exp_data_h = uart_seqit::type_id::create("exp_data_h");
      exp_data_h.mon_data = exp_data[i];
      env_h.uart_scoreboard_h.expected_data.push_back(exp_data_h);
  end

endfunction:start_of_simulation_phase

task tc_direct_urx_utx::run_phase(uvm_phase phase);
   phase.raise_objection(this);
   // #1ms;
   `uvm_info("tc_direct_urx_utx", "Hello from run_phase", UVM_LOW)
   // Start seqeuncer
   uart_sequence_h.start(env_h.uart_agent_h.sequencer_h);
   #100us;
   `uvm_info("tc_direct_urx_utx", "end run_phase", UVM_LOW)
   phase.drop_objection(this);
endtask