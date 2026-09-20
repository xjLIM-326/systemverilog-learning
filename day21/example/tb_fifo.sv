module tb_fifo;

    logic       clk;
    logic       reset_n;

    logic       wr_en;
    logic       rd_en;
    logic [7:0] wr_data;
    logic [7:0] rd_data;

    logic       full;
    logic       empty;


    // --------------------------------
    // DUT
    // --------------------------------

    fifo #(
        .DEPTH(4),
        .WIDTH(8)
    ) dut (
        .clk     (clk),
        .reset_n (reset_n),

        .wr_en   (wr_en),
        .rd_en   (rd_en),

        .wr_data (wr_data),
        .rd_data (rd_data),

        .full    (full),
        .empty   (empty)
    );


    // --------------------------------
    // Assertions
    // --------------------------------

    fifo_assertions assertions (
        .clk     (clk),
        .reset_n (reset_n),

        .wr_en   (wr_en),
        .rd_en   (rd_en),

        .full    (full),
        .empty   (empty)
    );


    // --------------------------------
    // Clock
    // --------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // --------------------------------
    // Stimulus
    // --------------------------------

    initial begin

        reset_n = 0;

        wr_en   = 0;
        rd_en   = 0;
        wr_data = 0;

        repeat (2) @(posedge clk);

        reset_n = 1;

        @(posedge clk);
        wr_en   = 1;
        wr_data = 8'hAA;

        @(posedge clk);
        wr_data = 8'hBB;

        @(posedge clk);
        wr_en = 0;

        @(posedge clk);
        rd_en = 1;

        @(posedge clk);
        rd_en = 0;

        #20;

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Sep 20 09:42 2026
$finish called from file "testbench.sv", line 97.
$finish at simulation time                   85
           V C S   S i m u l a t i o n   R e p o r t 
Time: 85 ns
*/