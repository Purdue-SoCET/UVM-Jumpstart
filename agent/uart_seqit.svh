class uart_seqit extends uvm_sequence_item;
    // UVM macro Factory registration
   `uvm_object_utils(uart_seqit)

    bit [7:0] data_arr[];
    bit [7:0] mon_data;

    extern function new(string name="uart_seqit");
    extern function void do_print(uvm_printer printer);
    extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
endclass:uart_seqit

function uart_seqit::new(string name="uart_seqit");
    super.new(name);
endfunction:new

function void uart_seqit::do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("mon_data", mon_data, $bits(mon_data), UVM_HEX);
endfunction:do_print

function bit uart_seqit::do_compare(uvm_object rhs, uvm_comparer comparer);
    uart_seqit rhs_;
  
    if (rhs == null) begin
      `uvm_fatal(get_type_name(), "null data in do_compare");
    end
    // Type casting
    if ($cast(rhs_, rhs)) begin
      do_compare = (this.mon_data == rhs_.mon_data);
    end else begin
      `uvm_error(get_type_name(), "Comparison failed, types are not matched");
    end
  endfunction : do_compare