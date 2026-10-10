// Adapted from ChatGPT

class packet_monitor extends uvm_monitor;

    virtual packet_if vif;

    `uvm_component_utils(packet_monitor)

    uvm_analysis_port #(packet_transaction) actual_port;

    function new(string name = "packet_monitor",
                 uvm_component parent = null);

        super.new(name, parent);

    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual packet_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        actual_port = new("actual_port", this);

    endfunction

    task run_phase(uvm_phase phase);

        packet_transaction actual_txn;

        forever begin

            // Wait for DUT output
            @(posedge vif.clk);

            // Sample interface
            if (vif.valid_o) begin

                // Convert signal -> transaction
                actual_txn = packet_transaction::type_id::create("actual_txn");
                actual_txn.data = vif.data_o;
                actual_txn.dest = vif.dest_o;

                actual_port.write(actual_txn);

                // Error injection
                /*
                if (vif.data_o === 8'hFF) begin
                    actual_port.write(actual_txn);
                    actual_port.write(actual_txn);
                end
                */

                `uvm_info("MONITOR", $sformatf("data_o = %02h dest_o = %02b", actual_txn.data, actual_txn.dest), UVM_NONE)

            end

        end

    endtask

endclass