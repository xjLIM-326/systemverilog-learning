class packet_test;

    virtual packet_if vif;

    packet_monitor    monitor;
    packet_scoreboard scoreboard;
    packet_coverage   coverage;


    function new(virtual packet_if vif);

        this.vif = vif;

        monitor    = new(vif);
        scoreboard = new(vif);
        coverage   = new(vif);

    endfunction


    task run();

        packet_transaction tr;

        fork

            monitor.run();

            scoreboard.run();

            coverage.run();

        join_none


        repeat (100) begin

            tr = new();

            assert(tr.randomize());

            @(negedge vif.clk);

            vif.packet_valid = tr.packet_valid;
            vif.packet_type  = tr.packet_type;
            vif.destination  = tr.destination;

        end


        @(negedge vif.clk);

        vif.packet_valid = 1'b0;

        #20;

        $display("======================================");
        $display("Packet Type Coverage = %0.2f%%",
                 coverage.packet_cg.cp_packet_type.get_coverage());

        $display("Destination Coverage = %0.2f%%",
                 coverage.packet_cg.cp_destination.get_coverage());

        $display("Cross Coverage       = %0.2f%%",
                 coverage.packet_cg.get_coverage());

        $display("======================================");

        $finish;

    endtask

endclass