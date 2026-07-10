module day03_challenge;

logic [7:0] a, b;

initial begin
    a = 8'h3C;
    b = 8'h0F;

    $display("a       = %08b (%02h)", a, a);
    $display("b       = %08b (%02h)", b, b);
    $display("a & b   = %08b (%02h)", a & b, a & b);
    $display("a | b   = %08b (%02h)", a | b, a | b);
    $display("a ^ b   = %08b (%02h)", a ^ b, a ^ b);
    $display("a << 2  = %08b (%02h)", a << 2, a << 2);
    $display("b >> 1  = %08b (%02h)", b >> 1, b >> 1);
end
  
endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 04:56 2026
a       = 00111100 (3c)
b       = 00001111 (0f)
a & b   = 00001100 (0c)
a | b   = 00111111 (3f)
a ^ b   = 00110011 (33)
a << 2  = 11110000 (f0)
b >> 1  = 00000111 (07)
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/