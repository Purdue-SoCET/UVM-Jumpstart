class test_top extends uvm_test;
   // UVM macro Factory registration
   `uvm_component_utils(test_top)

   env_top env_h;

   extern function new(string name = "test_top" , uvm_component parent);
   extern function void build_phase(uvm_phase phase);

endclass:test_top

function test_top::new(string name = "test_top", uvm_component parent);
   super.new(name,parent);

endfunction:new

function void test_top::build_phase(uvm_phase phase);
   super.build_phase(phase);
   // Create env class
   env_h = env_top::type_id::create("env_h", this);
endfunction:build_phase