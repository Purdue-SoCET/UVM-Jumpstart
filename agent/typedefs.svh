typedef enum bit {
   ACTIVE_LOW,
   ACTIVE_HIGH
} t_reset_polarity;

typedef enum int {
   FIVE_WIDTH   = 5,
   SIX_WIDTH    = 6,
   SEVEN_WIDTH  = 7,
   EIGHT_WIDTH  = 8
} t_data_width;

typedef enum int {
   STOP_BIT_ONEBIT  = 1,
   STOP_BIT_TWOBITS = 2
} t_stop_bit;

typedef enum bit[1:0] {
    PARITY_NONE   = 0,
    PARITY_ODD    = 1,
    PARITY_EVEN   = 2
 } t_parity;
 