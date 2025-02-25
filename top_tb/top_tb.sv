`include "uart_if.svh"
`include "verif_pkg.svh"
module top_tb;

   import uvm_pkg::*;
   import verif_pkg::*;

   //clock and reset signal declaration
   bit clock_i;
   bit resetn_i;

   //clock generation
   always #(uart_if_inst.c_CLOCK_PERIOD_NS/2) clock_i = ~clock_i;

   //reset Generation
   initial begin
      #(3*uart_if_inst.c_CLOCK_PERIOD_NS); resetn_i = 0;
      #(3*uart_if_inst.c_CLOCK_PERIOD_NS); resetn_i = 1;
   end
   // Interface declarations
   uart_if uart_if_inst(
      .resetn_i   (resetn_i),
      .clock_i    (clock_i)
   );
   
   // DUT instance -- RTL is loopbacked
  uart  uart_rx_CHIPKIT_inst(
      .clk        (uart_if_inst.clock_i)     ,
      .rstn       (uart_if_inst.resetn_i)    ,
      .baud_div   (12'd217)                  ,
      .rxd        (uart_if_inst.rx_din_i)    ,
      .txd        (uart_if_inst.tx_dout_o)   ,
      .txen       (uart_if_inst.rx_done)     ,
      .tx_byte    (uart_if_inst.rx_data_o)   ,
      .rx_done    (uart_if_inst.rx_done)     ,
      .rx_byte    (uart_if_inst.rx_data_o)   ,
      .rx_ing     ()                         ,
      .tx_ing     ()                         ,
      .rx_err     ()
);

   initial
   begin
      // Setting interfaces to uvm_config_db
      // config_db get is done in env_top class
      //ToDo do not globally set the vif to the config_db. Specify a location
      uvm_config_db #(virtual uart_if)::set(null,"*","uart_vif",uart_if_inst);
      // Execute UVM test class
      run_test();
   end

endmodule: top_tb