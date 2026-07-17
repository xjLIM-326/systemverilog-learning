module fifo_checker (
    input logic clk,
    input logic rst_n,

    input logic wr_en,
    input logic rd_en,

    input logic full,
    input logic empty
);

    assert_no_write_when_full:
    assert property (
        @(posedge clk)
        disable iff (!rst_n)
        full |-> !wr_en
    )
    else $error("Write attempted while FIFO is full");


    assert_no_read_when_empty:
    assert property (
        @(posedge clk)
        disable iff (!rst_n)
        empty |-> !rd_en
    )
    else $error("Read attempted while FIFO is empty");

endmodule