module day07_challenge;

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

    #7;
    rst_n = 1;

    #11;
    d = 8'h34;

    #13;
    rst_n = 0;

    #17;
    $finish;
end

initial begin
    $monitor("Time=%0t rst_n=%b d=%h q=%h",
             $time, rst_n, d, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 12 08:47 2026
Time=0 rst_n=0 d=12 q=00
Time=7 rst_n=1 d=12 q=00
Time=15 rst_n=1 d=12 q=12
Time=18 rst_n=1 d=34 q=12
Time=25 rst_n=1 d=34 q=34
Time=31 rst_n=0 d=34 q=00
$finish called from file "design.sv", line 34.
$finish at simulation time                   48
           V C S   S i m u l a t i o n   R e p o r t 
Time: 48 ns
*/  