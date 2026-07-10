module example2_part_select;

logic [15:0] instruction;

initial begin
    instruction = 16'hABCD;

    $display("Instruction = %h", instruction);

    $display("Upper Byte  = %h", instruction[15:8]);
    $display("Lower Byte  = %h", instruction[7:0]);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:22 2026
Instruction = abcd
Upper Byte  = ab
Lower Byte  = cd
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/