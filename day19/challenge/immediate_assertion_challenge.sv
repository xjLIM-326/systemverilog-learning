module day19_challenge_immediate_assertion;

    int data;
    int expected;

    initial begin

        data = 100;
        expected = 100;

        assert (data == expected)
            $display("PASS");
        else
            $error("FAIL: data != expected");


        data = 200;
        expected = 100;

        assert (data == expected)
            $display("PASS");
        else
            $error("FAIL: data != expected");

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 24 11:54 2026
PASS
"testbench.sv", 20: day19_challenge_immediate_assertion.unnamed$$_1: started at 0ns failed at 0ns
	Offending '(data == expected)'
Error: "testbench.sv", 20: day19_challenge_immediate_assertion.unnamed$$_1: at time 0 ns
FAIL: data != expected
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/