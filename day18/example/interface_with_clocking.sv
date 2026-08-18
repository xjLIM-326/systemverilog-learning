interface bus_if;

    logic       clk;
    logic       req;
    logic       ack;
    logic [7:0] data;

    clocking cb @(posedge clk);

        output req;
        output data;

        input ack;

    endclocking

endinterface


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

    initial begin
        bus.clk = 0;

        forever #5 bus.clk = ~bus.clk;
    end


    initial begin

        bus.req  = 0;
        bus.data = 0;

        @(bus.cb);

        bus.cb.req  <= 1'b1;
        bus.cb.data <= 8'hAA;

        @(bus.cb);

        bus.cb.req <= 1'b0;

        @(bus.cb);

        $display("ack = %0b", bus.cb.ack);

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 18 08:20 2026
ack = 1
$finish called from file "testbench.sv", line 69.
$finish at simulation time                   25
           V C S   S i m u l a t i o n   R e p o r t 
Time: 25 ns
*/