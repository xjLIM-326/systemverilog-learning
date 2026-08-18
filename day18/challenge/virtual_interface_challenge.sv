interface bus_if;

    logic       clk;
    logic       valid;
    logic       ready;
    logic [7:0] data;

    clocking cb @(posedge clk);

        output  valid;
        output  data;

        input   ready;

    endclocking

    modport DUT (
        input   clk,
        input   valid,
        input   data,
        output  ready
    );

    modport TB (
        clocking    cb,
        output      clk
    );

endinterface


module dut (
    bus_if.DUT bus
);

    always_ff @(posedge bus.clk) begin
        if (bus.valid) begin
            bus.ready <= 1'b1;

            if (bus.ready)
                $display("DUT received = %02h", bus.data);
        end
        else begin
            bus.ready <= 1'b0;
        end
    end

endmodule


class Transaction;

    rand bit [7:0] data;

endclass


class Driver;

    virtual bus_if.TB vif;

    function new(virtual bus_if.TB vif);
        this.vif = vif;
    endfunction

    task drive (input Transaction tx);

        @(vif.cb);

        vif.cb.valid  <= 1'b1;
        vif.cb.data <= tx.data;

        $display("TB sent = %02h", tx.data);

        do begin
            @(vif.cb);
        end while (!vif.cb.ready);

        vif.cb.valid <= 1'b0;

    endtask

endclass


module tb;

    bus_if bus();

    dut u_dut (
        .bus(bus)
    );

    Driver driver;
    Transaction tx;

    initial begin
        bus.clk = 0;

        forever #5 bus.clk = ~bus.clk;
    end

    initial begin

        driver = new(bus);

        repeat(4) begin

            tx = new();
            tx.randomize();

            driver.drive(tx);

        end

        #20;

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 18 10:05 2026
TB sent = 41
DUT received = 41
TB sent = 13
DUT received = 13
TB sent = a7
DUT received = a7
TB sent = 6d
DUT received = 6d
$finish called from file "testbench.sv", line 118.
$finish at simulation time                  135
           V C S   S i m u l a t i o n   R e p o r t 
Time: 135 ns
*/