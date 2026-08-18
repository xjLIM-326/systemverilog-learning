interface bus_if;

    logic       clk;
    logic       req;
    logic       ack;
    logic [7:0] data;

endinterface


module dut (
    bus_if bus
);

    always_ff @(posedge bus.clk) begin
        if (bus.req) begin
            bus.ack <= 1'b1;
        end
        else begin
            bus.ack <= 1'b0;
        end
    end

endmodule


module tb;

    bus_if bus();

    dut u_dut (
        .bus(bus)
    );

    initial begin
        bus.clk = 0;

        forever #5 bus.clk = ~bus.clk;
    end

    initial begin
        bus.req  = 0;
        bus.data = 0;

        #10;

        bus.req  = 1;
        bus.data = 8'hAA;

        #10;

        bus.req  = 0;

        #20;

        $finish;
    end

endmodule