module example1_always_comb;

logic a;
logic b;
logic y;

always_comb begin
    y = a & b;
end

initial begin
    a = 0; b = 0;
    #5;

    a = 1;
    #5;

    b = 1;
    #5;

    a = 0;
    #5;
end

initial begin
    $monitor("Time=%0t a=%b b=%b y=%b",
             $time, a, b, y);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 22:31 2026
Time=0 a=0 b=0 y=0
Time=5 a=1 b=0 y=0
Time=10 a=1 b=1 y=1
Time=15 a=0 b=1 y=0
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/