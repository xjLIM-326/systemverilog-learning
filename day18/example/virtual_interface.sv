interface bus_if;

    logic       clk;
    logic       req;
    logic       ack;
    logic [7:0] data;

endinterface


class Driver;

    virtual bus_if vif;

    function new(virtual bus_if vif);
        this.vif = vif;
    endfunction

    task drive_transaction(
        input logic [7:0] data
    );

        @(posedge vif.clk);

        vif.req  <= 1'b1;
        vif.data <= data;

        @(posedge vif.clk);

        vif.req <= 1'b0;

    endtask

endclass


module dut (
    bus_if bus
);

    always_ff @(posedge bus.clk) begin

        if (bus.req)
            bus.ack <= 1'b1;
        else
            bus.ack <= 1'b0;

    end

endmodule


module tb;

    bus_if bus();

    dut u_dut (
        .bus(bus)
    );

    Driver driver;

    initial begin
        bus.clk = 0;

        forever #5 bus.clk = ~bus.clk;
    end

    initial begin

        driver = new(bus);

        driver.drive_transaction(8'hA5);

        #20;

        $finish;

    end

endmodule