module example2_if_else;

logic sel;
logic a;
logic b;
logic y;

always_comb begin
    if (sel)
        y = a;
    else
        y = b;
end

initial begin
    a = 1;
    b = 0;

    sel = 0;
    #5;

    sel = 1;
    #5;
end

initial begin
    $monitor("sel=%b y=%b", sel, y);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 22:32 2026
sel=0 y=0
sel=1 y=1
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10 ns
*/