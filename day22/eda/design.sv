interface packet_if(input logic clk);

    logic       rst_n;

    logic       packet_valid;
    logic [1:0] packet_type;
    logic [1:0] destination;

    logic       packet_accept;

endinterface


module packet_router (
    input  logic       clk,
    input  logic       rst_n,

    input  logic       packet_valid,
    input  logic [1:0] packet_type,
    input  logic [1:0] destination,

    output logic       packet_accept
);

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin
            packet_accept <= 1'b0;
        end
        else begin

            if (packet_valid &&
                destination != 2'b11) begin

                packet_accept <= 1'b1;

            end
            else begin

                packet_accept <= 1'b0;
            end
        end
    end

endmodule