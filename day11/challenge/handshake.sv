module handshake_consumer (
    input logic       clk,
    input logic       rst_n,

    // Producer → Consumer
    input logic       valid,
    input logic [7:0] data,

    // Consumer → Producer
    output logic      ready,

    // Internal observation
    output logic      accepted
);

    logic [1:0] busy_count;

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin
            ready      <= 0;
            accepted   <= 0;
            busy_count <= 2'd0;
        end
        else begin
            accepted <= 0;
            if (busy_count != 0) begin
                busy_count <= busy_count - 1'b1;
                ready      <= 0;
            end
            else begin
                ready <= 1;
                if (valid && ready) begin
                    accepted   <= 1;
                    busy_count <= 2'd2;
                end
            end
        end
    end

endmodule