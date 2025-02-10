class uart_seqit extends uvm_sequence_item;
   `uvm_object_utils(uart_seqit)

    bit [7:0] data_arr[];
    bit [7:0] mon_data;

    extern function new(string name="uart_seqit");

endclass:uart_seqit

function uart_seqit::new(string name="uart_seqit");
    super.new(name);
endfunction:new