module tb_pipeline;

    localparam int WIDTH = 8;

    logic clk;
    logic rst_n;

    logic             valid_in;
    logic [WIDTH-1:0] data_in;

    logic             valid_out;
    logic [WIDTH-1:0] data_out;


    pipeline #(
        .WIDTH(WIDTH)
    ) dut (
        .clk       (clk),
        .rst_n     (rst_n),

        .valid_in  (valid_in),
        .data_in   (data_in),

        .valid_out (valid_out),
        .data_out  (data_out)
    );


    pipeline_assertions #(
        .WIDTH(WIDTH)
    ) assertions (
        .clk       (clk),
        .rst_n     (rst_n),

        .valid_in  (valid_in),
        .data_in   (data_in),

        .valid_out (valid_out),
        .data_out  (data_out)
    );


    initial begin

        clk = 0;

        forever #5 clk = ~clk;

    end


    initial begin

        rst_n    = 0;
        valid_in = 0;
        data_in  = 0;

        #12;

        rst_n = 1;


        @(negedge clk);

        valid_in = 1;
        data_in  = 8'hAA;


        @(negedge clk);

        valid_in = 0;


        repeat (5)
            @(negedge clk);


        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 19 02:16 2026
$finish called from file "testbench.sv", line 145.
$finish at simulation time                   80
           V C S   S i m u l a t i o n   R e p o r t 
Time: 80 ns
*/