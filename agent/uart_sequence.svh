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
        req.data_arr = 8'hBA;
        finish_item(req);
        start_item(req);
        req.data_arr = 8'h5E;
        finish_item(req);
        start_item(req);
        req.data_arr = 8'hBA;
        finish_item(req);
        start_item(req);
        req.data_arr = 8'h11;
        finish_item(req);
    endtask:body
endclass:uart_sequence
