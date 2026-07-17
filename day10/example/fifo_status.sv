module fifo_status (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       wr_en,
    input  logic       rd_en,

    output logic       full,
    output logic       empty
);

    logic [3:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end
        else begin
            case ({wr_en && !full, rd_en && !empty})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                default: count <= count;
            endcase
        end
    end

    assign full  = (count == 8);
    assign empty = (count == 0);

endmodule