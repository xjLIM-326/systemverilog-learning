module top;

    logic clk;

    always #5 clk = ~clk;


    packet_if pif(clk);


    packet_router dut (

        .clk           (clk),
        .rst_n         (pif.rst_n),

        .packet_valid  (pif.packet_valid),
        .packet_type   (pif.packet_type),
        .destination   (pif.destination),

        .packet_accept (pif.packet_accept)

    );


    initial begin

        clk = 1'b0;

        pif.rst_n         = 1'b0;
        pif.packet_valid = 1'b0;
        pif.packet_type  = 2'b00;
        pif.destination  = 2'b00;

        repeat (2)
            @(posedge clk);

        pif.rst_n = 1'b1;

    end


    initial begin

        packet_test test;

        wait(pif.rst_n);

        test = new(pif);

        test.run();

    end

endmodule