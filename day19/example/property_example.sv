module property_example;

    logic clk;
    logic reset_n;

    logic valid;
    logic ready;

    initial clk = 0;

    always #5 clk = ~clk;


    initial begin

        reset_n = 0;
        valid   = 0;
        ready   = 0;

        #12;

        reset_n = 1;

        #10;
        valid = 1;

        #10;
        ready = 1;

        #10;
        valid = 0;
        ready = 0;

        #20;

        $finish;

    end


    // ------------------------------------------------
    // Property
    // ------------------------------------------------

    property valid_ready_check;

        @(posedge clk)
        valid |-> ##1 ready;

    endproperty


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    assert property (valid_ready_check)
        else $error("valid was not followed by ready");

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 24 08:32 2026
"testbench.sv", 57: property_example.unnamed$$_1: started at 35ns failed at 45ns
	Offending 'ready'
Error: "testbench.sv", 57: property_example.unnamed$$_1: at time 45 ns
valid was not followed by ready
$finish called from file "testbench.sv", line 36.
$finish at simulation time                   62
           V C S   S i m u l a t i o n   R e p o r t 
Time: 62 ns
*/