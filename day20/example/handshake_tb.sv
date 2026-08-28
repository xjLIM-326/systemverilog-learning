module handshake_tb;

    logic clk;
    logic reset_n;

    logic req;
    logic ack;


    // ------------------------------------------------
    // Clock
    // ------------------------------------------------

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // ------------------------------------------------
    // DUT
    // ------------------------------------------------

    handshake dut (
        .clk    (clk),
        .reset_n(reset_n),
        .req    (req),
        .ack    (ack)
    );


    // ------------------------------------------------
    // Stimulus
    // ------------------------------------------------

    initial begin

        reset_n = 0;
        req     = 0;
        ack     = 0;


        // --------------------------------------------
        // Reset
        // --------------------------------------------

        @(negedge clk);
        reset_n = 1;


        // --------------------------------------------
        // TEST 1
        // req at cycle N
        // ack at cycle N+1
        //
        // Expected: PASS
        // --------------------------------------------

        @(negedge clk);
        req = 1;

        @(negedge clk);
        req = 0;
        ack = 1;

        @(negedge clk);
        ack = 0;


        // --------------------------------------------
        // TEST 2
        // No req
        //
        // Expected: No assertion activity
        // --------------------------------------------

        repeat (2)
            @(negedge clk);


        // --------------------------------------------
        // TEST 3
        // req without ack
        //
        // Expected: FAIL
        // --------------------------------------------

        @(negedge clk);
        req = 1;

        @(negedge clk);
        req = 0;
        ack = 0;


        #20;

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 28 10:38 2026
"design.sv", 45: handshake_tb.dut.assert_req_ack: started at 75ns failed at 85ns
	Offending 'ack'
Error: "design.sv", 45: handshake_tb.dut.assert_req_ack: at time 85 ns
REQ was not followed by ACK
$finish called from file "testbench.sv", line 99.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
*/