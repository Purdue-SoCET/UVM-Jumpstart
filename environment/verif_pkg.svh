package verif_pkg;

    import uvm_pkg::*;
    import uart_pkg::*;

    `include "uvm_macros.svh"
    
    `include "../environment/uart_scoreboard.svh"
    `include "../environment/env_top.svh"
    `include "../test/test_top.svh"
    `include "../test/tc_direct_urx.svh"

endpackage