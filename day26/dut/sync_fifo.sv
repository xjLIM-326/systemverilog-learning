
module sync_fifo #(
    parameter int DATA_WIDTH = 8,
    parameter int DEPTH      = 4
) (
    input  logic                  clk,
    input  logic                  rst_n,

    input  logic                  wr_en,
    input  logic                  rd_en,
    input  logic [DATA_WIDTH-1:0] din,

    output logic [DATA_WIDTH-1:0] dout,
    output logic                  full,
    output logic                  empty
);

    localparam int PTR_WIDTH = (DEPTH <= 1) ? 1 : $clog2(DEPTH);
    localparam int CNT_WIDTH = $clog2(DEPTH + 1);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_WIDTH-1:0] wr_ptr;
    logic [PTR_WIDTH-1:0] rd_ptr;
    logic [CNT_WIDTH-1:0] count;

    logic wr_accept;
    logic rd_accept;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    assign wr_accept = wr_en && !full;
    assign rd_accept = rd_en && !empty;

    function automatic logic [PTR_WIDTH-1:0]
        next_ptr(input logic [PTR_WIDTH-1:0] ptr);
        if (ptr == DEPTH - 1)
            next_ptr = '0;
        else
            next_ptr = ptr + 1'b1;
    endfunction

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            dout   <= '0;
        end else begin
            if (wr_accept) begin
                mem[wr_ptr] <= din;
                wr_ptr <= next_ptr(wr_ptr);
            end

            if (rd_accept) begin
                dout <= mem[rd_ptr];
                rd_ptr <= next_ptr(rd_ptr);
            end

            case ({wr_accept, rd_accept})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase
        end
    end

endmodule
