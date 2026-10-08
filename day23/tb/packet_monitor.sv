// Adapted from ChatGPT

class packet_monitor extends uvm_monitor;

    virtual packet_if vif;

    `uvm_component_utils(packet_monitor)

    function new(string name = "packet_monitor",
                 uvm_component parent = null);

        super.new(name, parent);

    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if (!uvm_config_db#(virtual packet_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

    endfunction

    task run_phase(uvm_phase phase);

        packet_transaction tr;

        forever begin

            // Wait for DUT output
            @(posedge vif.clk);

            // Sample interface
            if (vif.valid_o) begin

                // Convert signal -> transaction
                tr = packet_transaction::type_id::create("tr");
                tr.data = vif.data_o;
                tr.dest = vif.dest_o;

                `uvm_info("MONITOR", $sformatf("data_o = %02h dest_o = %02b", tr.data, tr.dest), UVM_NONE)

            end

        end

    endtask

endclass