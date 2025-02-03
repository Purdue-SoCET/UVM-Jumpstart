class uart_driver extends uvm_driver #(uart_seqit);
   `uvm_component_utils(uart_driver)

    // Config class  
   uart_config uart_config_h;
   // Virtual interface holds the pointer to the Interface.    
   virtual uart_if vif;
   realtime bit_time;
   bit parity = 0;

    function new(string name = "uart_driver" , uvm_component parent);
        super.new(name, parent);
    endfunction:new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction:build_phase

    virtual function void start_of_simulation_phase(uvm_phase phase);
        vif = uart_config_h.vif; 
    endfunction:start_of_simulation_phase

    virtual task run_phase(uvm_phase phase);
        // // Reset bus
        vif.reset_tx_bus();
        // // Wait reset signal
        vif.wait_reset();

        // TODO move another place
        // TODO This calculation might be affected by timeunit, to be found a solution
        // Calculating bit_time and converting to nanosec
        bit_time = vif.c_BIT_PERIOD;

        //Drive the interface
        forever  begin
           seq_item_port.get_next_item(req);
           drive_data(req);
           seq_item_port.item_done();
        end
    endtask:run_phase

    virtual task drive_data(uart_seqit seqit);
        for(int i = 0; i < 4; i++) begin
         
            // Start condition
            drive_if(1'b0);
            
    
            for(int j = 0; j < 8; j++) begin
               drive_if(seqit.data_arr[i][j]);
            end
    
            // Stop Bits
               drive_if(1'b1);
    
    
        end
    endtask:drive_data
    virtual task drive_if(logic data);
        vif.rx_din_i <= data;
        #(bit_time);
    endtask:drive_if
endclass:uart_driver
