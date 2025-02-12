class uart_seqit extends uvm_sequence_item;
    // UVM macro Factory registration
   `uvm_object_utils(uart_seqit)

    bit [7:0] data_arr;
    bit [7:0] mon_data;

    extern function new(string name="uart_seqit");
    extern function void do_print(uvm_printer printer);

endclass:uart_seqit

function uart_seqit::new(string name="uart_seqit");
    super.new(name);
endfunction:new

function void uart_seqit::do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("mon_data", mon_data, $bits(mon_data), UVM_HEX);
    // printer.print_field_int("data_arr", data_arr, $bits(data_arr), UVM_HEX);
endfunction:do_print