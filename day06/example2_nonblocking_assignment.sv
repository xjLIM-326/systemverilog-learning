module example2_nonblocking_assignment;

logic clk;
logic d;
logic q;

always_ff @(posedge clk)
    q <= d;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    d = 0;

    #7  d = 1;
    #10 d = 0;
    #10 d = 1;

    #15 $finish;
end

initial begin
    $monitor("Time=%0t clk=%b d=%b q=%b",
             $time, clk, d, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:16 2026
Time=0 clk=0 d=0 q=x
Time=5 clk=1 d=0 q=0
Time=7 clk=1 d=1 q=0
Time=10 clk=0 d=1 q=0
Time=15 clk=1 d=1 q=1
Time=17 clk=1 d=0 q=1
Time=20 clk=0 d=0 q=1
Time=25 clk=1 d=0 q=0
Time=27 clk=1 d=1 q=0
Time=30 clk=0 d=1 q=0
Time=35 clk=1 d=1 q=1
Time=40 clk=0 d=1 q=1
$finish called from file "design.sv", line 22.
$finish at simulation time                   42
           V C S   S i m u l a t i o n   R e p o r t 
Time: 42 ns
*/