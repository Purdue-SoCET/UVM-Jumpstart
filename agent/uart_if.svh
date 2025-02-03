interface uart_if
   (
   input resetn_i,
   input clock_i
);

   import uart_pkg::*;

   parameter baud_rate_g    = 115_200  ;
   parameter c_CLOCK_PERIOD_NS = 10    ; // 100MHZ
   parameter c_CLKS_PER_BIT    = 87    ; // (osc_freq_g / baud_rate_g)
   parameter c_BIT_PERIOD      = 8680  ; // (1 / baud_rate_g)
   string reset_polarity;

   // Bus Signals
   logic [11:0] baud_div               ;
   logic rx_din_i                      ;
   logic txd                           ;
   logic txen                          ;
   logic[7:0] tx_data_i                ;
   logic rx_done                       ;
   logic[7:0] rx_data_o                ;
   logic rx_ing                        ;
   logic tx_ing                        ;
   logic rx_err                        ;

      // Tasks and functions
   function set_reset_polarity(string rp);
      reset_polarity = rp;
   endfunction
   task reset_tx_bus();
      rx_din_i = 1;
   endtask
   task wait_reset();
      if(reset_polarity == "ACTIVE_LOW") begin
         @(posedge resetn_i);
      end else begin
         @(negedge resetn_i);
      end
   endtask

endinterface