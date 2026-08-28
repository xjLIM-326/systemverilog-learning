module req_ack_checker_tb;

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

    req_ack_checker dut (
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

        $display("[%02t]: Expecting Test 1 to PASS...", $time);

        @(negedge clk);
        req = 1;

        @(negedge clk);
        req = 0;
        ack = 1;

        @(negedge clk);
        ack = 0;

        $display("[%02t]: Finished Test 1", $time);


        // --------------------------------------------
        // TEST 2
        // req at cycle N
        // ack at cycle N+2
        //
        // Expected: PASS
        // --------------------------------------------

        $display("[%02t]: Expecting Test 2 to PASS...", $time);

        @(negedge clk);
        req = 1;

        @(negedge clk);
        req = 0;

        @(negedge clk);
        ack = 1;

        @(negedge clk);
        ack = 0;

        $display("[%02t]: Finished Test 2", $time);


        // --------------------------------------------
        // TEST 3
        // req at cycle N
        // ack at cycle N+3
        //
        // Expected: FAIL
        // --------------------------------------------

        $display("[%02t]: Expecting Test 3 to FAIL...", $time);

        @(negedge clk);
        req = 1;

        @(negedge clk);
        req = 0;

        repeat(2) @(negedge clk);
        ack = 1;

        @(negedge clk);
        ack = 0;

        $display("[%02t]: Finished Test 3", $time);


        // --------------------------------------------
        // TEST 4
        // No ack after req
        //
        // Expected: FAIL
        // --------------------------------------------

        $display("[%02t]: Expecting Test 4 to FAIL...", $time);

        @(negedge clk);
        req = 1;

        repeat(3) begin
            @(negedge clk);
            req = 1;
            ack = 0;
        end

        repeat(3) begin
            @(negedge clk);
            req = 0;
        end

        $display("[%02t]: Finished Test 4", $time);


        // --------------------------------------------
        // TEST 5
        // ack without req
        //
        // Expected: FAIL
        // --------------------------------------------

        $display("[%02t]: Expecting Test 5 to FAIL...", $time);

        @(negedge clk);
        req = 0;
        ack = 0;

        repeat(2) @(negedge clk);
        ack = 1;

        @(negedge clk);
        ack = 0;

        $display("[%02t]: Finished Test 5", $time);


        // --------------------------------------------
        // TEST 6
        // Reset
        //
        // Expected: No assertion activity
        // --------------------------------------------

        $display("[%02t]: Expecting Test 6 to PASS...", $time);

        @(negedge clk);
        reset_n = 0;
        req = 0;
        ack = 0;

        repeat(3) begin
            @(negedge clk);
            req = 1;
        end

        repeat(3) begin
            @(negedge clk);
            req = 0;
        end

        $display("[%02t]: Finished Test 6", $time);


        #20;

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 28 12:00 2026
[10]: Expecting Test 1 to PASS...
[40]: Finished Test 1
[40]: Expecting Test 2 to PASS...
[80]: Finished Test 2
[80]: Expecting Test 3 to FAIL...
"design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: started at 95ns failed at 115ns
	Offending 'ack'
Error: "design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: at time 115 ns
REQ was not acknowledged within 2 cycles
"design.sv", 55: req_ack_checker_tb.dut.assert_ack_has_recent_req: started at 125ns failed at 125ns
	Offending '($past(req) || $past(req, 2))'
Error: "design.sv", 55: req_ack_checker_tb.dut.assert_ack_has_recent_req: at time 125 ns
ACK was not preceded by REQ within 2 cycles
[130]: Finished Test 3
[130]: Expecting Test 4 to FAIL...
"design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: started at 145ns failed at 155ns
	Offending '(!req)'
Error: "design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: at time 155 ns
REQ was not a pulse
"design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: started at 155ns failed at 165ns
	Offending '(!req)'
Error: "design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: at time 165 ns
REQ was not a pulse
"design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: started at 145ns failed at 165ns
	Offending 'ack'
Error: "design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: at time 165 ns
REQ was not acknowledged within 2 cycles
"design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: started at 165ns failed at 175ns
	Offending '(!req)'
Error: "design.sv", 51: req_ack_checker_tb.dut.assert_req_pulse: at time 175 ns
REQ was not a pulse
"design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: started at 155ns failed at 175ns
	Offending 'ack'
Error: "design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: at time 175 ns
REQ was not acknowledged within 2 cycles
"design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: started at 165ns failed at 185ns
	Offending 'ack'
Error: "design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: at time 185 ns
REQ was not acknowledged within 2 cycles
"design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: started at 175ns failed at 195ns
	Offending 'ack'
Error: "design.sv", 47: req_ack_checker_tb.dut.assert_req_ack: at time 195 ns
REQ was not acknowledged within 2 cycles
[200]: Finished Test 4
[200]: Expecting Test 5 to FAIL...
"design.sv", 55: req_ack_checker_tb.dut.assert_ack_has_recent_req: started at 235ns failed at 235ns
	Offending '($past(req) || $past(req, 2))'
Error: "design.sv", 55: req_ack_checker_tb.dut.assert_ack_has_recent_req: at time 235 ns
ACK was not preceded by REQ within 2 cycles
[240]: Finished Test 5
[240]: Expecting Test 6 to PASS...
[310]: Finished Test 6
$finish called from file "testbench.sv", line 202.
$finish at simulation time                  330
           V C S   S i m u l a t i o n   R e p o r t 
Time: 330 ns
*/