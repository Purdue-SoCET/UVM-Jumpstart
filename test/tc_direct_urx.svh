class tc_direct_urx extends test_top;
   `uvm_component_utils(tc_direct_urx)

   extern function new(string name = "tc_direct_urx" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);

   virtual function void end_of_elaboration_phase(uvm_phase phase);
      uvm_top.print_topology();
   endfunction

endclass:tc_direct_urx

function tc_direct_urx::new(string name = "tc_direct_urx" , uvm_component parent);
   super.new(name,parent);
endfunction:new

function void tc_direct_urx::build_phase(uvm_phase phase);
   super.build_phase(phase);
    // Create sequences
endfunction:build_phase

task tc_direct_urx::run_phase(uvm_phase phase);
   phase.raise_objection(this);
   `uvm_info("tc_direct_urx", "Hello from run_phase", UVM_LOW)
   // Start seqeuncer
   `uvm_info("tc_direct_urx", "end run_phase", UVM_LOW)
   phase.drop_objection(this);
endtask