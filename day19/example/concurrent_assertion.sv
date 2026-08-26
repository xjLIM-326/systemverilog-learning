module concurrent_assertion;

    logic clk;
    logic reset_n;

    logic req;
    logic ack;

    initial clk = 0;

    always #5 clk = ~clk;


    // ------------------------------------------------
    // DUT-like behavior
    // ------------------------------------------------

    initial begin

        reset_n = 0;
        req     = 0;
        ack     = 0;

        #12;

        reset_n = 1;

        #10;
        req = 1;

        #10;
        ack = 1;

        #10;
        req = 0;
        ack = 0;

        #20;

        $finish;

    end


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    property req_ack_check;

        @(posedge clk)
        req |-> ##1 ack;

    endproperty


    assert property (req_ack_check)
        else $error("ASSERTION FAILED: ack not asserted one cycle after req");


endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 24 08:31 2026
"testbench.sv", 57: concurrent_assertion.unnamed$$_1: started at 35ns failed at 45ns
	Offending 'ack'
Error: "testbench.sv", 57: concurrent_assertion.unnamed$$_1: at time 45 ns
ASSERTION FAILED: ack not asserted one cycle after req
$finish called from file "testbench.sv", line 40.
$finish at simulation time                   62
           V C S   S i m u l a t i o n   R e p o r t 
Time: 62 ns
*/