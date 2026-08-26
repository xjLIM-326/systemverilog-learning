module sequence_example;

    logic clk;

    logic req;
    logic grant;

    initial clk = 0;

    always #5 clk = ~clk;


    initial begin

        req   = 0;
        grant = 0;

        #12;

        req = 1;

        #10;

        grant = 1;

        #10;

        req   = 0;
        grant = 0;

        #30;

        $finish;

    end


    // ------------------------------------------------
    // Sequence
    // ------------------------------------------------

    sequence req_then_grant;

        req ##1 grant;

    endsequence


    // ------------------------------------------------
    // Property
    // ------------------------------------------------

    property req_grant_property;

        @(posedge clk)
        req_then_grant;

    endproperty


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    assert property (req_grant_property)
        else $error("req was not followed by grant");

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 24 08:33 2026
"testbench.sv", 65: sequence_example.unnamed$$_1: started at 5ns failed at 5ns
	Offending 'req'
Error: "testbench.sv", 65: sequence_example.unnamed$$_1: at time 5 ns
req was not followed by grant
"testbench.sv", 65: sequence_example.unnamed$$_1: started at 35ns failed at 35ns
	Offending 'req'
Error: "testbench.sv", 65: sequence_example.unnamed$$_1: at time 35 ns
req was not followed by grant
"testbench.sv", 65: sequence_example.unnamed$$_1: started at 25ns failed at 35ns
	Offending 'grant'
Error: "testbench.sv", 65: sequence_example.unnamed$$_1: at time 35 ns
req was not followed by grant
"testbench.sv", 65: sequence_example.unnamed$$_1: started at 45ns failed at 45ns
	Offending 'req'
Error: "testbench.sv", 65: sequence_example.unnamed$$_1: at time 45 ns
req was not followed by grant
"testbench.sv", 65: sequence_example.unnamed$$_1: started at 55ns failed at 55ns
	Offending 'req'
Error: "testbench.sv", 65: sequence_example.unnamed$$_1: at time 55 ns
req was not followed by grant
$finish called from file "testbench.sv", line 33.
$finish at simulation time                   62
           V C S   S i m u l a t i o n   R e p o r t 
Time: 62 ns
*/