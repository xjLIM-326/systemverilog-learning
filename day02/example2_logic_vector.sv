module example2_logic_vector;

logic [7:0] data;

initial begin
    data = 8'hA5;

    $display("Binary      : %b", data);
    $display("Decimal     : %0d", data);
    $display("Hexadecimal : %h", data);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 08:40 2026
Binary      : 10100101
Decimal     : 165
Hexadecimal : a5
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/