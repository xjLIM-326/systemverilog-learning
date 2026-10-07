class packet_monitor;

    virtual packet_if vif;

    function new(virtual packet_if vif);
        this.vif = vif;
    endfunction


    task run();

        forever begin

            @(posedge vif.clk);

            if (vif.packet_valid) begin

                $display(
                    "[MONITOR] valid=%0d type=%0d dest=%0d accept=%0d",
                    vif.packet_valid,
                    vif.packet_type,
                    vif.destination,
                    vif.packet_accept
                );

            end

        end

    endtask

endclass