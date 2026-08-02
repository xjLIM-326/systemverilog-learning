module alu (
    input  logic       clk,
    input  logic [2:0] opcode,
    input  logic [1:0] mode,
    output logic       valid
);

always_ff @(posedge clk) begin
    valid <= (opcode != 3'b111);
end

endmodule