module example4_bit_vs_logic;

bit   b;
logic l;

initial begin
    b = 'x;
    l = 'x;

    $display("bit   = %b", b);
    $display("logic = %b", l);

    b = 'z;
    l = 'z';

    $display("bit   = %b", b);
    $display("logic = %b", l);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 08:45 2026
bit   = 0
logic = x
bit   = 0
logic = z
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/