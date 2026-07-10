module example2_bitwise_operators;

logic [3:0] a, b;

initial begin
    a = 4'b1010;
    b = 4'b1100;

    $display("a      = %b", a);
    $display("b      = %b", b);
    $display("a & b  = %b", a & b);
    $display("a | b  = %b", a | b);
    $display("a ^ b  = %b", a ^ b);
    $display("~a     = %b", ~a);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 04:36 2026
a      = 1010
b      = 1100
a & b  = 1000
a | b  = 1110
a ^ b  = 0110
~a     = 0101
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/