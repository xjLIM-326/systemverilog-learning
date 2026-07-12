module example3_blocking_vs_nonblocking;

logic clk;
logic a;
logic b;

always @(posedge clk) begin
    a <= b;
    b <= a;
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    a = 0;
    b = 1;

    #20;
    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b a=%b b=%b",
             $time, clk, a, b);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:26 2026
Time=0 clk=0 a=0 b=1
Time=5 clk=1 a=1 b=0
Time=10 clk=0 a=1 b=0
Time=15 clk=1 a=0 b=1
$finish called from file "design.sv", line 22.
$finish at simulation time                   20
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/