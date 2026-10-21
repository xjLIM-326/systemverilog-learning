package sfifo_tb_pkg;

    import uvm_pkg::*;

    `include "fifo_transaction.sv"
    `include "fifo_sequencer.sv"

    `include "fifo_seq_basic.sv"
    `include "fifo_seq_concurrent.sv"
    `include "fifo_seq_empty.sv"
    `include "fifo_seq_full.sv"
    `include "fifo_seq_idle.sv"
    `include "fifo_seq_random.sv"
    `include "fifo_seq_reset.sv"

    `include "fifo_driver.sv"
    `include "fifo_monitor.sv"
    `include "fifo_agent.sv"
    `include "fifo_reference_model.sv"
    `include "fifo_scoreboard.sv"
    `include "fifo_env.sv"
    `include "fifo_test.sv"

endpackage
