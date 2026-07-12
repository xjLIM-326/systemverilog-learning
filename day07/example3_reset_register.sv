module example3_reset_register;

logic clk;
logic rst_n;
logic [7:0] d;
logic [7:0] q;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 8'h00;
    else
        q <= d;
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    d = 8'h12;

    #8;
    rst_n = 1;

    #12;
    d = 8'h34;

    #12;
    rst_n = 0;

    #6;
    rst_n = 1;
    d = 8'h56;

    #20;
    $finish;
end

initial begin
    $monitor("Time=%0t rst_n=%b d=%h q=%h",
             $time, rst_n, d, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 12 08:36 2026
Time=0 rst_n=0 d=12 q=00
Time=8 rst_n=1 d=12 q=00
Time=15 rst_n=1 d=12 q=12
Time=20 rst_n=1 d=34 q=12
Time=25 rst_n=1 d=34 q=34
Time=32 rst_n=0 d=34 q=00
Time=38 rst_n=1 d=56 q=00
Time=45 rst_n=1 d=56 q=56
$finish called from file "design.sv", line 38.
$finish at simulation time                   58
           V C S   S i m u l a t i o n   R e p o r t 
Time: 58 ns
*/