class uart_sequence extends uvm_sequence #(uart_seqit);
   `uvm_object_utils(uart_sequence)

    uart_seqit req;

   extern function new(string name = "uart_sequence");
   extern task body();
endclass:uart_sequence

function uart_sequence::new(string name = "uart_sequence");
    super.new(name);
    // Create seqeunce item
    req = uart_seqit::type_id::create("req");
endfunction:new

task uart_sequence::body();
    `uvm_info("tc_direct_urx", "Hello from sequence", UVM_LOW)
    start_item(req);
    // assign transactions
    req.data_arr = new[4];
    req.data_arr[0] = 8'hBA;
    req.data_arr[1] = 8'h5E;
    req.data_arr[2] = 8'hBA;
    req.data_arr[3] = 8'h11;
    finish_item(req);
endtask:body