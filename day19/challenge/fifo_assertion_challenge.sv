module day19_challenge_fifo_assertion;

    logic clk;
    logic reset_n;

    logic wr_en;
    logic rd_en;

    logic full;
    logic empty;

    int depth = 4;
    int count;
    int countNew;

    always_ff @(posedge clk or !reset_n) begin

        if (!reset_n)
            count <= 0;
        else begin
            if ((wr_en && !full) && (rd_en && !empty))
                count <= count;
            else if (wr_en && !full)
                count <= count + 1;
            else if (rd_en && !empty)
                count <= count - 1;
        end

        $display("Time = %0t: full = %b, empty = %b, count = %0d", $time, full, empty, count);

    end

    always_comb begin

        countNew = count;

        if (countNew == 0) begin
            full = 0;
            empty = 1;
        end
        else if (countNew == depth) begin
            full = 1;
            empty = 0;
        end
        else begin
            empty = 0;
            full = 0;
        end

    end

    initial clk = 0;

    always #5 clk = ~clk;


    initial begin

        reset_n = 0;
        wr_en = 0;
        rd_en = 0;

        #3;

        reset_n = 1;

        #5;
        wr_en = 1;

        #50;
        wr_en = 0;
        rd_en = 1;

        #50;

        $finish;

    end


    // ------------------------------------------------
    // Property
    // ------------------------------------------------

    property full_write_check;
        @(posedge clk)
        disable iff (!reset_n)
        full |-> !wr_en;
    endproperty

    property empty_read_check;
        @(posedge clk)
        disable iff (!reset_n)
        empty |-> !rd_en;
    endproperty

    property full_empty_check;
        @(posedge clk)
        disable iff (!reset_n)
        full |-> !empty;
    endproperty


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    assert property (full_write_check)
        else $error("Invalid wirte when FIFO is full!");

    assert property (empty_read_check)
        else $error("Invalid read when FIFO is empty!");

    assert property (full_empty_check)
        else $error("FIFO cannot be full and empty at the same time!");


endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 26 05:45 2026
Time = 0: full = x, empty = x, count = 0
Time = 3: full = 0, empty = 1, count = 0
Time = 5: full = 0, empty = 1, count = 0
Time = 15: full = 0, empty = 1, count = 0
Time = 25: full = 0, empty = 0, count = 1
Time = 35: full = 0, empty = 0, count = 2
Time = 45: full = 0, empty = 0, count = 3
Time = 55: full = 1, empty = 0, count = 4
"testbench.sv", 108: day19_challenge_fifo_assertion.unnamed$$_7: started at 55ns failed at 55ns
	Offending '(!wr_en)'
Error: "testbench.sv", 108: day19_challenge_fifo_assertion.unnamed$$_7: at time 55 ns
Invalid wirte when FIFO is full!
Time = 65: full = 1, empty = 0, count = 4
Time = 75: full = 0, empty = 0, count = 3
Time = 85: full = 0, empty = 0, count = 2
Time = 95: full = 0, empty = 0, count = 1
Time = 105: full = 0, empty = 1, count = 0
"testbench.sv", 111: day19_challenge_fifo_assertion.unnamed$$_8: started at 105ns failed at 105ns
	Offending '(!rd_en)'
Error: "testbench.sv", 111: day19_challenge_fifo_assertion.unnamed$$_8: at time 105 ns
Invalid read when FIFO is empty!
$finish called from file "testbench.sv", line 76.
$finish at simulation time                  108
           V C S   S i m u l a t i o n   R e p o r t 
Time: 108 ns
*/