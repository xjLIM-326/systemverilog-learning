module fifo #(
    parameter int DEPTH = 4,
    parameter int WIDTH = 8
)(
    input  logic             clk,
    input  logic             rst_n,

    input  logic             wr_en,
    input  logic             rd_en,

    input  logic [WIDTH-1:0] wdata,
    output logic [WIDTH-1:0] rdata,

    output logic             full,
    output logic             empty
);

    localparam int PTR_WIDTH = (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_WIDTH-1:0] wr_ptr;
    logic [PTR_WIDTH-1:0] rd_ptr;
    logic [$clog2(DEPTH+1)-1:0] count;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count  <= '0;
            wr_ptr <= '0;
            rd_ptr <= '0;
            rdata  <= '0;
        end
        else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= wdata;
                if (wr_ptr == DEPTH - 1)
                    wr_ptr <= '0;
                else
                    wr_ptr <= wr_ptr + 1'b1;
            end
            if (rd_en && !empty) begin
                rdata <= mem[rd_ptr];
                if (rd_ptr == DEPTH - 1)
                    rd_ptr <= '0;
                else
                    rd_ptr <= rd_ptr + 1'b1;
            end

            case ({wr_en && !full, rd_en && !empty})
                2'b10:
                    count <= count + 1'b1;
                2'b01:
                    count <= count - 1'b1;
                default:
                    count <= count;
            endcase
        end
    end

endmodule