class packet_coverage;

    virtual packet_if vif;


    covergroup packet_cg;

        cp_packet_type:

            coverpoint vif.packet_type iff (vif.packet_valid) {

                bins data     = {2'b00};
                bins control  = {2'b01};
                bins response = {2'b10};

                ignore_bins reserved = {2'b11};

            }


        cp_destination:

            coverpoint vif.destination iff (vif.packet_valid) {

                bins cpu        = {2'b00};
                bins dma        = {2'b01};
                bins peripheral = {2'b10};

                ignore_bins invalid = {2'b11};

            }


        cross cp_packet_type, cp_destination;

    endgroup


    function new(virtual packet_if vif);

        this.vif = vif;

        packet_cg = new();

    endfunction


    task run();

        forever begin

            @(posedge vif.clk);

            if (vif.packet_valid) begin

                packet_cg.sample();

            end

        end

    endtask

endclass