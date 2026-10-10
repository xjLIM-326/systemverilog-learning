// Adapted from ChatGPT

class packet_driver extends uvm_driver #(packet_transaction);

    virtual packet_if vif;

    `uvm_component_utils(packet_driver)

    uvm_analysis_port #(packet_transaction) input_port;

    function new(string name = "packet_driver",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual packet_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        input_port = new("input_port", this);

    endfunction

    task run_phase(uvm_phase phase);

        packet_transaction req;

        forever begin

            seq_item_port.get_next_item(req);

            // Drive req to DUT
            wait (vif.rst_n == 1'b1) begin
                vif.valid_i <= 1'b1;
                vif.data_i <= req.data;
                vif.dest_i <= req.dest;

                // Error injection
                /*
                if (req.data === 8'h00 ) begin
                    vif.data_i <= 8'hAA;
                end
                else if (req.data === 8'hFF ) begin
                    input_port.write(req);
                end
                else begin
                    vif.data_i <= req.data;
                end
                */

                input_port.write(req);
            end

            @(posedge vif.clk);

            vif.valid_i <= 1'b0;

            seq_item_port.item_done();

        end

    endtask

endclass