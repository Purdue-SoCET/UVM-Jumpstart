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

    // Get uart_config_h, which is set by env_top, from config_db
    if (!uvm_config_db #(uart_config)::get(this,"","uart_config",uart_config_h)) begin
        FATAL_CONFIG_DB: `uvm_fatal("CONFIG", "cannot get() cfg from uvm_config_db.")
     end

    //  Create sequencer, driver, and monitor classes
    monitor_h = uart_monitor::type_id::create("h_monitor", this);
    driver_h = uart_driver::type_id::create("h_driver", this);
    sequencer_h = uart_sequencer::type_id::create("sequencer_h", this);

endfunction:build_phase

function void uart_agent::connect_phase(uvm_phase phase);
    // Connect driver and sequencer via TLM ports
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
    // Config class handles are assigned
    monitor_h.uart_config_h = uart_config_h;
    driver_h.uart_config_h = uart_config_h;

endfunction:connect_phase