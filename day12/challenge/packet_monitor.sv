module packet_monitor (
    input  logic       clk,
    input  logic [1:0] packet_type,
    input  logic [3:0] packet_size,
    input  logic       error,

    output logic       packet_valid
);

always_ff @(posedge clk) begin
    packet_valid <= !error;
end

endmodule