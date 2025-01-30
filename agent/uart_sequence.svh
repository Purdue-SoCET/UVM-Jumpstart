class uart_sequence extends uvm_sequence #(uart_seqit);
   `uvm_object_utils(uart_sequence)

   extern function new(string name = "uart_sequence");
   extern task body();
endclass:uart_sequence

function uart_sequence::new(string name = "uart_sequence");
    super.new(name);
    // Create seqeunce item
endfunction:new

task uart_sequence::body();
    start_item(req);
    // assign transactions
    finish_item(req);
endtask:body