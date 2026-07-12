module day06_bonus;

logic clk;
logic [7:0] d;
logic [7:0] q1;
logic [7:0] q2;

always_ff @(posedge clk) begin
    q1 <= d;
    q2 <= q1;
end

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

    #19;

    $finish;
end

initial begin
    $monitor("Time=%0t d=%h q1=%h q2=%h",
             $time, d, q1, q2);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:39 2026
Time=0 d=12 q1=xx q2=xx
Time=5 d=12 q1=12 q2=xx
Time=7 d=34 q1=12 q2=xx
Time=15 d=34 q1=34 q2=12
Time=18 d=56 q1=34 q2=12
Time=25 d=56 q1=56 q2=34
Time=35 d=56 q1=56 q2=56
$finish called from file "design.sv", line 31.
$finish at simulation time                   37
           V C S   S i m u l a t i o n   R e p o r t 
Time: 37 ns
*/