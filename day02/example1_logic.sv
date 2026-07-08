module example1_logic;

logic a;

initial begin
    a = 0;
    $display("a = %0d", a);

    a = 1;
    $display("a = %0d", a);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 08:38 2026
a = 0
a = 1
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/