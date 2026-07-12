module example2_asynchronous_reset;

logic clk;
logic rst_n;
logic [7:0] q;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 8'h00;
    else
        q <= q + 1;
end

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Stimulus
initial begin
    rst_n = 0;

    #12;
    rst_n = 1;

    #30;
    rst_n = 0;

    #6;
    rst_n = 1;

    #20;
    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b rst_n=%b q=%0d",
             $time, clk, rst_n, q);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 12 08:33 2026
Time=0 clk=0 rst_n=0 q=0
Time=5 clk=1 rst_n=0 q=0
Time=10 clk=0 rst_n=0 q=0
Time=12 clk=0 rst_n=1 q=0
Time=15 clk=1 rst_n=1 q=1
Time=20 clk=0 rst_n=1 q=1
Time=25 clk=1 rst_n=1 q=2
Time=30 clk=0 rst_n=1 q=2
Time=35 clk=1 rst_n=1 q=3
Time=40 clk=0 rst_n=1 q=3
Time=42 clk=0 rst_n=0 q=0
Time=45 clk=1 rst_n=0 q=0
Time=48 clk=1 rst_n=1 q=0
Time=50 clk=0 rst_n=1 q=0
Time=55 clk=1 rst_n=1 q=1
Time=60 clk=0 rst_n=1 q=1
Time=65 clk=1 rst_n=1 q=2
$finish called from file "design.sv", line 34.
$finish at simulation time                   68
           V C S   S i m u l a t i o n   R e p o r t 
Time: 68 ns
*/