interface bus_if;

    logic       clk;
    logic       valid;
    logic       ready;
    logic [7:0] data;

    modport DUT (
        input   clk,
        input   valid,
        input   data,
        output  ready
    );

    modport TB (
        output  clk,
        output  valid,
        output  data,
        input   ready
    );

endinterface


module dut (
    bus_if.DUT bus
);

    always_ff @(posedge bus.clk) begin
        if (bus.valid) begin
            bus.ready <= 1'b1;
            $display("Data received = %02h", bus.data);
        end
        else begin
            bus.ready <= 1'b0;
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
        bus.valid  = 0;
        bus.data = 0;

        #10;

        bus.valid  = 1;
        bus.data = 8'hAA;

        #10;

        bus.valid  = 0;

        #20;

        $finish;
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 18 09:21 2026
Data received = aa
$finish called from file "testbench.sv", line 71.
$finish at simulation time                   40
           V C S   S i m u l a t i o n   R e p o r t 
Time: 40 ns
*/