module tb_fifo #(
    parameter int DEPTH = 4,
    parameter int WIDTH = 8
);

    logic             clk;
    logic             rst_n;

    logic             wr_en;
    logic             rd_en;

    logic [WIDTH-1:0] wdata;
    logic [WIDTH-1:0] rdata;

    logic             full;
    logic             empty;


    fifo #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH)
    ) dut (
        .clk   (clk),
        .rst_n (rst_n),
        .wr_en (wr_en),
        .rd_en (rd_en),
        .wdata (wdata),
        .rdata (rdata),
        .full  (full),
        .empty (empty)
    );


    // Clock
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // Stimulus
    initial begin

        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        wdata = '0;


        // ============================================================
        // Test 1: Reset
        // ============================================================

        @(posedge clk);
        #1;

        if (!full && empty)
            $display("RESET SUCCESS: FIFO is empty after reset");
        else
            $error("RESET FAIL: FIFO cannot be non-empty after reset");


        // ============================================================
        // Test 2: Basic Write and Read
        // ============================================================

        // Write A
        @(negedge clk);
        rst_n = 1;
        wr_en = 1;
        wdata = 8'hA;

        @(posedge clk);
        #1;


        // Write B
        @(negedge clk);
        wdata = 8'hB;

        @(posedge clk);
        #1;


        // Read A
        @(negedge clk);
        wr_en = 0;
        rd_en = 1;

        @(posedge clk);
        #1;

        assert (rdata == 8'hA)
            else $error("BUG: Expected rdata=A, got %h", rdata);


        // Read B
        @(posedge clk);
        #1;

        assert (rdata == 8'hB)
            else $error("BUG: Expected rdata=B, got %h", rdata);


        // Stop reading
        @(negedge clk);
        rd_en = 0;


        // ============================================================
        // Test 3: Full Boundary
        // ============================================================

        // Reset
        rst_n = 0;

        @(posedge clk);
        #1;

        rst_n = 1;


        // Fill FIFO
        wr_en = 1;

        for (int i = 10; i < 10 + DEPTH; i++) begin

            @(negedge clk);
            wdata = i;

            @(posedge clk);
            #1;

        end


        // FIFO should now be full
        assert (full)
            else $error("BUG: Expected FIFO to be full");


        // Attempt write while full
        @(negedge clk);
        wdata = 8'hFF;

        @(posedge clk);
        #1;


        assert (full)
            else $error("BUG: FIFO should remain full after invalid write");


        // Stop writing
        @(negedge clk);
        wr_en = 0;


        // ============================================================
        // Test 4: Empty Boundary
        // ============================================================

        // Read all entries
        rd_en = 1;

        for (int i = 10; i < 10 + DEPTH; i++) begin

            @(posedge clk);
            #1;

            assert (rdata == i)
                else $error(
                    "BUG: Expected rdata=%h, got %h",
                    i,
                    rdata
                );

        end


        // FIFO should now be empty
        assert (empty)
            else $error("BUG: Expected empty FIFO");


        // Attempt read while empty
        @(posedge clk);
        #1;


        assert (empty)
            else $error("BUG: FIFO should remain empty after invalid read");


        // Stop reading
        @(negedge clk);
        rd_en = 0;


        // ============================================================
        // Test 5: Simultaneous Read and Write
        // ============================================================

        // Reset
        rst_n = 0;

        @(posedge clk);
        #1;

        rst_n = 1;


        // Write A
        @(negedge clk);
        wr_en = 1;
        wdata = 8'hA;

        @(posedge clk);
        #1;


        // Write B
        @(negedge clk);
        wdata = 8'hB;

        @(posedge clk);
        #1;


        // Simultaneous read A and write C
        @(negedge clk);
        wdata = 8'hC;
        rd_en = 1;

        @(posedge clk);
        #1;


        assert (rdata == 8'hA)
            else $error("BUG: Expected rdata=A, got %h", rdata);


        // Read B
        @(posedge clk);
        #1;

        assert (rdata == 8'hB)
            else $error("BUG: Expected rdata=B, got %h", rdata);


        // Read C
        @(posedge clk);
        #1;

        assert (rdata == 8'hC)
            else $error("BUG: Expected rdata=C, got %h", rdata);


        // Stop reading
        @(negedge clk);
        rd_en = 0;


        $finish;

    end


    // Immediate assertions
    always @(posedge clk) begin

        if (rst_n) begin

            assert (!(wr_en && full))
                else $error(
                    "WARNING: Attempted write while FIFO is full"
                );

            assert (!(rd_en && empty))
                else $error(
                    "WARNING: Attempted read while FIFO is empty"
                );

        end


        assert (!(full && empty))
            else $error(
                "BUG: FIFO cannot be full and empty concurrently"
            );

    end


    // Concurrent assertion
    assert property (
        @(posedge clk)
        disable iff (!rst_n)

        (wr_en && !rd_en && !full)
        |-> ##1 !empty
    )
    else $error(
        "BUG: FIFO cannot be empty after write-only operation"
    );

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 17 11:23 2026
RESET SUCCESS: FIFO is empty after reset
"testbench.sv", 275: tb_fifo.unnamed$$_12: started at 105ns failed at 105ns
	Offending '(!(wr_en && full))'
Error: "testbench.sv", 275: tb_fifo.unnamed$$_12: at time 105 ns
WARNING: Attempted write while FIFO is full
"testbench.sv", 280: tb_fifo.unnamed$$_13: started at 155ns failed at 155ns
	Offending '(!(rd_en && empty))'
Error: "testbench.sv", 280: tb_fifo.unnamed$$_13: at time 155 ns
WARNING: Attempted read while FIFO is empty
$finish called from file "testbench.sv", line 265.
$finish at simulation time                  220
           V C S   S i m u l a t i o n   R e p o r t 
Time: 220 ns
*/