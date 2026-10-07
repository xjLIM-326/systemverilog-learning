class packet_scoreboard;

    virtual packet_if vif;

    function new(virtual packet_if vif);
        this.vif = vif;
    endfunction


    task run();

        logic expected_accept;

        forever begin

            @(posedge vif.clk);

            #1;

            if (vif.packet_valid) begin

                expected_accept =
                    (vif.destination != 2'b11);

                if (vif.packet_accept !== expected_accept) begin

                    $error(
                        "[SCOREBOARD] MISMATCH: type=%0d dest=%0d expected=%0d actual=%0d",
                        vif.packet_type,
                        vif.destination,
                        expected_accept,
                        vif.packet_accept
                    );

                end
                else begin

                    $display(
                        "[SCOREBOARD] PASS: type=%0d dest=%0d accept=%0d",
                        vif.packet_type,
                        vif.destination,
                        vif.packet_accept
                    );

                end

            end

        end

    endtask

endclass