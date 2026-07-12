module example4_reset_counter;

logic clk;
logic rst_n;
logic [2:0] count;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        count <= 3'd0;
    else
        count <= count + 1;
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;

    #8;
    rst_n = 1;

    #30;
    rst_n = 0;

    #7;
    rst_n = 1;

    #25;
    $finish;
end

initial begin
    $monitor("Time=%0t rst_n=%b count=%0d",
             $time, rst_n, count);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 12 08:39 2026
Time=0 rst_n=0 count=0
Time=8 rst_n=1 count=0
Time=15 rst_n=1 count=1
Time=25 rst_n=1 count=2
Time=35 rst_n=1 count=3
Time=38 rst_n=0 count=0
Time=45 rst_n=1 count=1
Time=55 rst_n=1 count=2
Time=65 rst_n=1 count=3
$finish called from file "design.sv", line 32.
$finish at simulation time                   70
           V C S   S i m u l a t i o n   R e p o r t 
Time: 70 ns
*/