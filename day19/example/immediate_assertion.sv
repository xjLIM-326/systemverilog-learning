module immediate_assertion;

    int a;
    int b;

    initial begin

        a = 10;
        b = 10;

        assert (a == b)
            $display("PASS: a == b");
        else
            $error("FAIL: a != b");


        a = 20;
        b = 10;

        assert (a == b)
            $display("PASS: a == b");
        else
            $error("FAIL: a != b");

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 24 08:30 2026
PASS: a == b
"testbench.sv", 20: immediate_assertion.unnamed$$_1: started at 0ns failed at 0ns
	Offending '(a == b)'
Error: "testbench.sv", 20: immediate_assertion.unnamed$$_1: at time 0 ns
FAIL: a != b
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/