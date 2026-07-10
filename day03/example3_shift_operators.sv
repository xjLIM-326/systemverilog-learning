module example3_shift_operators;

logic [7:0] data;

initial begin
    data = 8'b00010110;

    $display("Original : %b", data);
    $display("<< 2     : %b", data << 2);
    $display(">> 2     : %b", data >> 2);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 04:38 2026
Original : 00010110
<< 2     : 01011000
>> 2     : 00000101
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/