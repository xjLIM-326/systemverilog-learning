module example1_indexing;

logic [7:0] data;

initial begin
    data = 8'b10110110;

    $display("data    = %b", data);
    $display("data[0] = %b", data[0]);
    $display("data[3] = %b", data[3]);
    $display("data[7] = %b", data[7]);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:21 2026
data    = 10110110
data[0] = 0
data[3] = 0
data[7] = 1
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/