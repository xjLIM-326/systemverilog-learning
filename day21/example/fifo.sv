module fifo #(
    parameter int DEPTH = 4,
    parameter int WIDTH = 8
)(
    input  logic             clk,
    input  logic             reset_n,

    input  logic             wr_en,
    input  logic             rd_en,

    input  logic [WIDTH-1:0] wr_data,
    output logic [WIDTH-1:0] rd_data,

    output logic             full,
    output logic             empty
);

    logic [WIDTH-1:0] mem [DEPTH];

    int count;
    int wr_ptr;
    int rd_ptr;

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            count  <= 0;
            wr_ptr <= 0;
            rd_ptr <= 0;
        end
        else begin

            if (wr_en && !full) begin
                mem[wr_ptr] <= wr_data;

                if (wr_ptr == DEPTH-1)
                    wr_ptr <= 0;
                else
                    wr_ptr <= wr_ptr + 1;
            end

            if (rd_en && !empty) begin
                rd_data <= mem[rd_ptr];

                if (rd_ptr == DEPTH-1)
                    rd_ptr <= 0;
                else
                    rd_ptr <= rd_ptr + 1;
            end

            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                default: count <= count;
            endcase
        end
    end

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

endmodule