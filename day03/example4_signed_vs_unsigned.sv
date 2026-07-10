module example4_signed_vs_unsigned;

logic signed [7:0] a;
logic        [7:0] b;

initial begin
    a = -8'd10;
    b = 8'd10;

    $display("signed   = %0d", a);
    $display("unsigned = %0d", b);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 04:41 2026
signed   = -10
unsigned = 10
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/