module day05_bonus;

logic [1:0] sel;

logic [7:0] d0;
logic [7:0] d1;
logic [7:0] d2;
logic [7:0] d3;

logic [7:0] y;

always_comb begin
    case (sel)
        2'b00: y = d0;
        2'b01: y = d1;
        2'b10: y = d2;
        2'b11: y = d3;
        default: y = 8'hFF;
    endcase
end

initial begin
    d0 = 8'h11;
    d1 = 8'h22;
    d2 = 8'h33;
    d3 = 8'h44;

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
    $monitor("Time=%0t sel=%h y=%h",
             $time, sel, y);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 22:54 2026
Time=0 sel=0 y=11
Time=5 sel=1 y=22
Time=10 sel=2 y=33
Time=15 sel=3 y=44
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/