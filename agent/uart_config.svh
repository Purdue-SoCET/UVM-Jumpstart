class uart_config extends uvm_object;
    // UVM Factory Registiration
    `uvm_object_utils(uart_config)
 
    // Virtual interface holds the pointer to the Interface.
    virtual uart_if vif;
 
    // UART Conifigurations
    t_data_width number_data_bits   = EIGHT_WIDTH     ;
    t_reset_polarity reset_polarity = ACTIVE_LOW      ;
    t_stop_bit stop_bit             = STOP_BIT_ONEBIT ;
    t_parity parity_bit             = PARITY_ODD      ;
    int baud_rate                   = 115_200         ;

    function new(string name = "uart_config");
       super.new(name);
    endfunction:new
 
 endclass