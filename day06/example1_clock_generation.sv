module example1_clock_generation;

logic clk;

initial begin
    clk = 0;

    forever #5 clk = ~clk;
end

initial begin
    #40;
    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b", $time, clk);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:15 2026
Time=0 clk=0
Time=5 clk=1
Time=10 clk=0
Time=15 clk=1
Time=20 clk=0
Time=25 clk=1
Time=30 clk=0
Time=35 clk=1
$finish called from file "design.sv", line 13.
$finish at simulation time                   40
           V C S   S i m u l a t i o n   R e p o r t 
Time: 40 ns
*/