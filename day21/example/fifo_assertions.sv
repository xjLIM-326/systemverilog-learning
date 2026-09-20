module fifo_assertions #(
    parameter int DEPTH = 4
)(
    input logic clk,
    input logic reset_n,

    input logic wr_en,
    input logic rd_en,

    input logic full,
    input logic empty
);

    default clocking cb @(posedge clk);
    endclocking

    // ------------------------------------------------
    // Assertion 1
    // ------------------------------------------------
    //
    // If FIFO is full, it must remain full
    // until a read happens.
    //
    // ------------------------------------------------

    property full_until_read;

        full |-> full until (rd_en && !empty);

    endproperty

    assert property (disable iff (!reset_n)
                     full_until_read);


    // ------------------------------------------------
    // Assertion 2
    // ------------------------------------------------
    //
    // If FIFO is empty, it must remain empty
    // until a write happens.
    //
    // ------------------------------------------------

    property empty_until_write;

        empty |-> empty until (wr_en && !full);

    endproperty

    assert property (disable iff (!reset_n)
                     empty_until_write);


    // ------------------------------------------------
    // Assertion 3
    // ------------------------------------------------
    //
    // While FIFO is full, a write should not be accepted.
    //
    // ------------------------------------------------

    property no_write_when_full;

        full |-> !wr_en;

    endproperty

    assert property (disable iff (!reset_n)
                     no_write_when_full);

endmodule