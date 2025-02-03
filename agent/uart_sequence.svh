class uart_sequence extends uvm_sequence #(uart_seqit);
   `uvm_object_utils(uart_sequence)

    uart_seqit req;
    function new(string name = "uart_sequence");
        super.new(name);
        // Create seqeunce item
        req = uart_seqit::type_id::create("req");
    endfunction:new

    virtual task body();
        start_item(req);
        req.data_arr = new[4];
        req.data_arr[0] = 8'hBA;
        req.data_arr[1] = 8'h5E;
        req.data_arr[2] = 8'hBA;
        req.data_arr[3] = 8'h11;
        finish_item(req);
    endtask:body
endclass:uart_sequence