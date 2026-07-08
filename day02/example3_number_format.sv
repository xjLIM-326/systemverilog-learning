module example3_number_format;

logic [3:0] data;

initial begin
    data = 4'b1010;

    $display("Binary      : %b", data);
    $display("Decimal     : %0d", data);
    $display("Hexadecimal : %h", data);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 08:42 2026
Binary      : 1010
Decimal     : 10
Hexadecimal : a
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/