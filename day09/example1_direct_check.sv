module adder (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [4:0] sum
);

    assign sum = a + b;

endmodule


module tb;

    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] sum;

    logic [4:0] expected;

    adder dut (
        .a   (a),
        .b   (b),
        .sum (sum)
    );

    initial begin

        a = 4'd3;
        b = 4'd5;

        #1;

        expected = a + b;

        if (sum == expected)
            $display("PASS");
        else
            $display("FAIL");

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 16 09:22 2026
PASS
$finish called from file "testbench.sv", line 31.
$finish at simulation time                    1
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1 ns
*/