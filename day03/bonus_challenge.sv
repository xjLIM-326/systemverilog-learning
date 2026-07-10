module day03_bonus;

logic [7:0] a;
logic [7:0] b;

initial begin
    a = 8'd20;
    b = 8'd12;

    $display("a   = %08b (%0d)", a, a);
    $display("b   = %08b (%0d)", b, b);

    $display("");

    $display("ADD = %08b (%0d)", a + b, a + b);
    $display("SUB = %08b (%0d)", a - b, a - b);
    $display("AND = %08b (%0d)", a & b, a & b);
    $display("OR  = %08b (%0d)", a | b, a | b);
    $display("XOR = %08b (%0d)", a ^ b, a ^ b);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:08 2026
a   = 00010100 (20)
b   = 00001100 (12)

ADD = 00100000 (32)
SUB = 00001000 (8)
AND = 00000100 (4)
OR  = 00011100 (28)
XOR = 00011000 (24)
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/