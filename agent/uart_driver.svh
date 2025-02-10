class uart_driver extends uvm_driver #(uart_seqit);
   `uvm_component_utils(uart_driver)

    // Config class  
   uart_config uart_config_h;
   // Virtual interface    
   virtual uart_if vif;
   realtime bit_time;

    function new(string name = "uart_driver" , uvm_component parent);
        super.new(name, parent);
    endfunction:new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction:build_phase

    virtual function void start_of_simulation_phase(uvm_phase phase);
        // Rather getting uart_config_h from config_db, the assingnment to uart_config_h is done in agent class
        vif = uart_config_h.vif; 
    endfunction:start_of_simulation_phase

    virtual task run_phase(uvm_phase phase);
        // Reset bus
        reset_tx_bus();
        // Wait reset signal
        vif.wait_reset();
        // Calculating bit per second
        bit_time = (1 / real'(uart_config_h.baud_rate))*10**9;
        // Drive the interface
        forever  begin
           seq_item_port.get_next_item(req);
           drive_data(req);
           seq_item_port.item_done();
        end
    endtask:run_phase

    virtual task reset_tx_bus();
        vif.rx_din_i = 1;
    endtask:reset_tx_bus

    virtual task wait_reset();
        if(uart_config_h.reset_polarity == "ACTIVE_LOW") begin
            @(posedge vif.resetn_i);
         end else begin
            @(negedge vif.resetn_i);
         end
    endtask:wait_reset

    virtual task drive_data(uart_seqit seqit);
        for(int i = 0; i < seqit.data_arr.size; i++) begin
            // Start condition
            drive_if(1'b0);
            for(int j = 0; j < uart_config_h.number_data_bits; j++) begin
               drive_if(seqit.data_arr[i][j]);
            end
            // First stop Bits
            drive_if(1'b1);
            // SEcond stop Bits
            drive_if(1'b1);
        end
    endtask:drive_data

    virtual task drive_if(logic data);
        vif.rx_din_i <= data;
        #(bit_time);
    endtask:drive_if

endclass:uart_driver
