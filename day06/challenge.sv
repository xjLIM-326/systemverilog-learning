module day06_challenge;

logic clk;
logic [7:0] d;
logic [7:0] q;

always_ff @(posedge clk)
    q <= d;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    d = 8'h12;

    #7;

    d = 8'h34;

    #11;

    d = 8'h56;

    #13;

    $finish;
end

initial begin
    $monitor("Time=%0t d=%h q=%h",
             $time, d, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:34 2026
Time=0 d=12 q=xx
Time=5 d=12 q=12
Time=7 d=34 q=12
Time=15 d=34 q=34
Time=18 d=56 q=34
Time=25 d=56 q=56
$finish called from file "design.sv", line 28.
$finish at simulation time                   31
           V C S   S i m u l a t i o n   R e p o r t 
Time: 31 ns
*/