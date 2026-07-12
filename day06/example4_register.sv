module example4_register;

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

    #12;

    d = 8'hAB;

    #12;

    d = 8'h55;

    #15;

    $finish;
end

initial begin
    $monitor("Time=%0t d=%h q=%h",
             $time, d, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 11 23:27 2026
Time=0 d=12 q=xx
Time=5 d=12 q=12
Time=12 d=ab q=12
Time=15 d=ab q=ab
Time=24 d=55 q=ab
Time=25 d=55 q=55
$finish called from file "design.sv", line 28.
$finish at simulation time                   39
           V C S   S i m u l a t i o n   R e p o r t 
Time: 39 ns
*/