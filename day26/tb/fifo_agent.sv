class fifo_agent #(parameter DATA_WIDTH = 8) extends uvm_agent;

    `uvm_component_param_utils(fifo_agent #(DATA_WIDTH))

    fifo_monitor #(DATA_WIDTH) monitor;

    fifo_sequencer #(DATA_WIDTH) sequencer;
    fifo_driver #(DATA_WIDTH) driver;

    virtual fifo_if vif;

    function new(
        string name = "fifo_agent",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        // Create monitor
        monitor = fifo_monitor#(DATA_WIDTH)::type_id::create("monitor", this);

        // Create sequencer
        sequencer = fifo_sequencer#(DATA_WIDTH)::type_id::create("sequencer", this);

        // Create driver
        driver = fifo_driver#(DATA_WIDTH)::type_id::create("driver", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        // Connect sequencer to driver
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass
