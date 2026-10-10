interface packet_if(input logic clk);

    logic       rst_n;

    logic       valid_i;
    logic [7:0] data_i;
    logic [1:0] dest_i;

    logic       valid_o;
    logic [7:0] data_o;
    logic [1:0] dest_o;

endinterface