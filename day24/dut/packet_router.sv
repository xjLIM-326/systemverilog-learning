module packet_router (
    packet_if vif
);

    always_ff @(posedge vif.clk or negedge vif.rst_n) begin
        if (!vif.rst_n) begin
            vif.valid_o <= 1'b0;
            vif.data_o  <= 8'h00;
            vif.dest_o  <= 2'b00;
        end
        else begin
            vif.valid_o <= vif.valid_i;
            vif.data_o  <= vif.data_i;
            vif.dest_o  <= vif.dest_i;
        end
    end

endmodule