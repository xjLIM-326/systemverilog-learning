module day19_challenge_concurrent_assertion;

    logic clk;
    logic reset_n;

    logic valid;
    logic ready;

    initial clk = 0;

    always #5 clk = ~clk;


    // ------------------------------------------------
    // DUT-like behavior
    // ------------------------------------------------

    initial begin

        reset_n = 0;
        valid = 0;
        ready = 0;

        #2;

        reset_n = 1;

        #2;
        valid = 1;

        #5;
        ready = 1;

        #2;
        valid = 0;

        #10;
        ready = 0;

        #10;
        valid = 1;

        #20;

        $finish;

    end


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    property valid_ready_check;

        @(posedge clk)
        disable iff (!reset_n)
        valid |-> ##1 ready;

    endproperty


    assert property (valid_ready_check)
        else $error("ASSERTION FAILED: ready not asserted one cycle after valid");


endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 26 05:44 2026
"testbench.sv", 63: day19_challenge_concurrent_assertion.unnamed$$_1: started at 35ns failed at 45ns
	Offending 'ready'
Error: "testbench.sv", 63: day19_challenge_concurrent_assertion.unnamed$$_1: at time 45 ns
ASSERTION FAILED: ready not asserted one cycle after valid
$finish called from file "testbench.sv", line 45.
$finish at simulation time                   51
           V C S   S i m u l a t i o n   R e p o r t 
Time: 51 ns
*/