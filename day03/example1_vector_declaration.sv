module example1_vector_declaration;

logic [7:0] data;

initial begin
    data = 8'b10100101;

    $display("Binary : %b", data);
    $display("Hex    : %h", data);
    $display("Dec    : %0d", data);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 04:34 2026
Binary : 10100101
Hex    : a5
Dec    : 165
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/