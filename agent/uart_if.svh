interface uart_if
   (
   input resetn_i,
   input clock_i
);
   parameter c_CLOCK_PERIOD_NS     = 10     ; // 100MHZ
   parameter c_CLKS_PER_BIT        = 87     ; // (osc_freq_g / baud_rate_g)
   parameter c_BIT_PERIOD          = 8680   ; // (1 / baud_rate_g)
   
   // Bus Signals
   logic [11:0] baud_div                  ;
   logic rx_din_i                         ;
   logic tx_dout_o                        ;
   logic txen                             ;
   logic[7:0] tx_data_i                   ;
   logic rx_done                          ;
   logic[7:0] rx_data_o                   ;
   logic rx_ing                           ;
   logic tx_ing                           ;
   logic rx_err                           ;

endinterface