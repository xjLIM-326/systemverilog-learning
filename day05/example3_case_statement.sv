module example3_case_statement;

logic [1:0] sel;
logic [7:0] out;

always_comb begin
    case (sel)
        2'b00: out = 8'h11;
        2'b01: out = 8'h22;
        2'b10: out = 8'h33;
        default: out = 8'hFF;
    endcase
end

initial begin
    sel = 2'b00;
    #5;

    sel = 2'b01;
    #5;

    sel = 2'b10;
    #5;

    sel = 2'b11;
    #5;
end

initial begin
    $monitor("sel=%b out=%h", sel, out);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 22:34 2026
sel=00 out=11
sel=01 out=22
sel=10 out=33
sel=11 out=ff
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/