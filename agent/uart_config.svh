class uart_config extends uvm_object;

    // UVM Factory Registiration
    `uvm_object_utils(uart_config)
 
    // Virtual interface holds the pointer to the Interface.
    virtual uart_if vif;
 
    // UART Conifigurations
    int number_data_bits            = 8;
    int baud_rate                   = 115_200;
    string reset_polarity           = "ACTIVE_LOW";
 
    function new(string name = "uart_config");
       super.new(name);
    endfunction:new
 
 endclass