module tb_fifo_status;

    logic clk;
    logic rst_n;

    logic wr_en;
    logic rd_en;

    logic full;
    logic empty;


    fifo_status dut (
        .clk   (clk),
        .rst_n (rst_n),
        .wr_en (wr_en),
        .rd_en (rd_en),
        .full  (full),
        .empty (empty)
    );


    fifo_checker checker (
        .clk   (clk),
        .rst_n (rst_n),
        .wr_en (wr_en),
        .rd_en (rd_en),
        .full  (full),
        .empty (empty)
    );


    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    initial begin

        rst_n = 0;
        wr_en = 0;
        rd_en = 0;

        repeat (2) @(posedge clk);

        rst_n = 1;


        // Write several times
        repeat (10) begin
            @(negedge clk);
            wr_en = 1;
        end


        // Stop writing
        @(negedge clk);
        wr_en = 0;


        // Read several times
        repeat (10) begin
            @(negedge clk);
            rd_en = 1;
        end


        @(negedge clk);
        rd_en = 0;


        #20;

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 17 07:01 2026
"testbench.sv", 13: tb_fifo_status.checker.assert_no_write_when_full: started at 105ns failed at 105ns
	Offending '(!wr_en)'
Error: "testbench.sv", 13: tb_fifo_status.checker.assert_no_write_when_full: at time 105 ns
Write attempted while FIFO is full
"testbench.sv", 13: tb_fifo_status.checker.assert_no_write_when_full: started at 115ns failed at 115ns
	Offending '(!wr_en)'
Error: "testbench.sv", 13: tb_fifo_status.checker.assert_no_write_when_full: at time 115 ns
Write attempted while FIFO is full
"testbench.sv", 22: tb_fifo_status.checker.assert_no_read_when_empty: started at 215ns failed at 215ns
	Offending '(!rd_en)'
Error: "testbench.sv", 22: tb_fifo_status.checker.assert_no_read_when_empty: at time 215 ns
Read attempted while FIFO is empty
"testbench.sv", 22: tb_fifo_status.checker.assert_no_read_when_empty: started at 225ns failed at 225ns
	Offending '(!rd_en)'
Error: "testbench.sv", 22: tb_fifo_status.checker.assert_no_read_when_empty: at time 225 ns
Read attempted while FIFO is empty
$finish called from file "testbench.sv", line 107.
$finish at simulation time                  250
           V C S   S i m u l a t i o n   R e p o r t 
Time: 250 ns
*/