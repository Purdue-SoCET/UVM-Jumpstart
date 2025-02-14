class uart_scoreboard extends uvm_scoreboard;
    // UVM macro Factory registration
    `uvm_component_utils(uart_scoreboard)

    // TLM analysis implicit declaration
    `uvm_analysis_imp_decl(_observed)
    `uvm_analysis_imp_decl(_expected)
    uvm_analysis_imp_observed #(uart_seqit, uart_scoreboard) observed;
    uvm_analysis_imp_observed #(uart_seqit, uart_scoreboard) expected;
    uart_seqit expected_data[$];
    int number_of_err = 0, number_of_passed = 0;
  
    // Virtual interface holds the pointer to the Interface.
    virtual uart_if vif;
  
    // Config class
    uart_config uart_config_h;
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       // Get uart_config_h, which is set by env_top, from config_db
    if (!uvm_config_db #(uart_config)::get(this,"","uart_config",uart_config_h)) begin
        FATAL_CONFIG_DB: `uvm_fatal("CONFIG", "cannot get() uart_config_h from uvm_config_db.")
     end
    endfunction : build_phase
  
    function void connect_phase(uvm_phase phase);
      // Just in case, if there is a need to use interface signals (could be enable, valid, etc for any other protocols)
      vif = uart_config_h.vif;
    endfunction : connect_phase
  
    function new(string name, uvm_component parent = null);
      super.new(name, parent);
      observed = new("observed", this);
    endfunction

    function void write_expected(uart_seqit tr);

      // Could be used to get data from driver
      expected_data.push_back(tr);

    endfunction:write_expected
  
    function void write_observed(uart_seqit tr);

      uart_seqit expected_seqit_h;
      expected_seqit_h = uart_seqit::type_id::create("expected_seqit_h");
      // Pop expected_seqit_h class which is injected from test
      expected_seqit_h = expected_data.pop_front(); 
      // Print monitored data
      tr.print();
      // Print expected data
      expected_seqit_h.print();

     if (tr.compare(expected_seqit_h)) begin
      `uvm_info(get_type_name(), "COMPARE : Monitored data matches with expected data", UVM_LOW);
      number_of_passed++;
    end else begin
      `uvm_error(get_type_name(), "MISMATCH : Monitored data NOT matched with expected data");
      number_of_err++;
    end
    endfunction:write_observed
  
    function void check_phase(input uvm_phase phase);
      super.check_phase(phase);

      if (number_of_err > 0) begin
        `uvm_error(get_type_name(), $sformatf("%0d data failed!", number_of_err));
      end else if (number_of_passed > 0) begin
        `uvm_info(get_type_name(), $sformatf("%0d data passed!", number_of_passed), UVM_LOW);
      end else begin
        `uvm_error(get_type_name(), $sformatf("Simulation could not be realized"));
      end
    endfunction:check_phase
  
  endclass:uart_scoreboard