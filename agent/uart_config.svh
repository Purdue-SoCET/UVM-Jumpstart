class uart_config extends uvm_object;

    // UVM Factory Registiration
    `uvm_object_utils(uart_config)
 
    // Virtual interface holds the pointer to the Interface.
    virtual uart_if vif;
 
    // UART Conifigurations
    int baud_rate                   = 9600;
    string num_data_bits            = "EIGHT_WIDTH";
    string reset_polarity           = "ACTIVE_LOW";
    string num_stop_bits            = "STOP_BIT_ONEBIT";
    string parity_type              = "PARITY_NONE";
 
    function new(string name = "uart_config");
       super.new(name);
    endfunction:new
 
 endclass