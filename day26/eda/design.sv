interface fifo_if(input logic clk);

    logic       rst_n;
    logic       wr_en;
    logic       rd_en;
    logic [7:0] din;
    logic [7:0] dout;
    logic       full;
    logic       empty;

    clocking drv_cb @(negedge clk);
        default input #1step output #1step;

        output rst_n;
        output wr_en;
        output rd_en;
        output din;
    endclocking

    clocking mon_cb @(posedge clk);
        input #1step rst_n;
        input #1step wr_en;
        input #1step rd_en;
        input #1step din;

        input #1step full;
        input #1step empty;
    endclocking

endinterface


module sync_fifo #(
    parameter int DATA_WIDTH = 8,
    parameter int DEPTH      = 4
) (
    fifo_if vif
);

    localparam int PTR_WIDTH = (DEPTH <= 1) ? 1 : $clog2(DEPTH);
    localparam int CNT_WIDTH = $clog2(DEPTH + 1);

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    logic [PTR_WIDTH-1:0] wr_ptr;
    logic [PTR_WIDTH-1:0] rd_ptr;
    logic [CNT_WIDTH-1:0] count;

    logic wr_accept;
    logic rd_accept;

    assign vif.full  = (count == DEPTH);
    assign vif.empty = (count == 0);

    assign wr_accept = vif.wr_en && !vif.full;
    assign rd_accept = vif.rd_en && !vif.empty;

    function automatic logic [PTR_WIDTH-1:0]
        next_ptr(input logic [PTR_WIDTH-1:0] ptr);
        if (ptr == DEPTH - 1)
            next_ptr = '0;
        else
            next_ptr = ptr + 1'b1;
    endfunction

    always_ff @(posedge vif.clk) begin
        if (!vif.rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            count  <= '0;
            vif.dout   <= '0;
        end else begin
            if (wr_accept) begin
                mem[wr_ptr] <= vif.din;
                wr_ptr <= next_ptr(wr_ptr);
            end

            if (rd_accept) begin
                vif.dout <= mem[rd_ptr];
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
