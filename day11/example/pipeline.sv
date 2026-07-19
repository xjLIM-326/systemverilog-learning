module pipeline #(
    parameter int WIDTH = 8
) (
    input  logic             clk,
    input  logic             rst_n,

    input  logic             valid_in,
    input  logic [WIDTH-1:0] data_in,

    output logic             valid_out,
    output logic [WIDTH-1:0] data_out
);

    logic             valid_stage1;
    logic             valid_stage2;

    logic [WIDTH-1:0] data_stage1;
    logic [WIDTH-1:0] data_stage2;

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            valid_stage1 <= 0;
            valid_stage2 <= 0;
            valid_out    <= 0;

            data_stage1  <= 0;
            data_stage2  <= 0;
            data_out     <= 0;

        end
        else begin

            valid_stage1 <= valid_in;
            valid_stage2 <= valid_stage1;
            valid_out    <= valid_stage2;

            data_stage1 <= data_in;
            data_stage2 <= data_stage1;
            data_out    <= data_stage2;

        end

    end

endmodule