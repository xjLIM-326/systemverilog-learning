module example4_replication;

logic [7:0] data;

initial begin
    data = {4{2'b10}};

    $display("data = %b", data);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:24 2026
data = 10101010
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/