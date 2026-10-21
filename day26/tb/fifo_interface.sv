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
