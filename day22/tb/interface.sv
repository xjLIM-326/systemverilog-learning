interface packet_if(input logic clk);

    logic       rst_n;

    logic       packet_valid;
    logic [1:0] packet_type;
    logic [1:0] destination;

    logic       packet_accept;

endinterface