// Adapted from ChatGPT

class packet_test extends uvm_test;

    virtual packet_if vif;

    packet_sequencer sequencer;
    packet_driver    driver;
    packet_monitor   monitor;

    `uvm_component_utils(packet_test)

    function new(
        string name = "packet_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);

        if (!uvm_config_db#(virtual packet_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        // Create sequencer
        sequencer = packet_sequencer::type_id::create("sequencer", this);

        // Create driver
        driver = packet_driver::type_id::create("driver", this);

        // Create monitor
        monitor = packet_monitor::type_id::create("monitor", this);

    endfunction


    function void connect_phase(uvm_phase phase);

        // Connect sequencer to driver
        driver.seq_item_port.connect(sequencer.seq_item_export);

    endfunction


    task run_phase(uvm_phase phase);

        packet_sequence pkt_seq;

        phase.raise_objection(this);

        // Create sequence
        pkt_seq = packet_sequence::type_id::create("pkt_seq");

        // Start sequence
        pkt_seq.start(sequencer);

        @(posedge vif.clk);

        phase.drop_objection(this);

    endtask

endclass