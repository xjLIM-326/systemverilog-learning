class fifo_test extends uvm_test;

    localparam int DATA_WIDTH = 8;
    localparam int DEPTH = 4;

    virtual fifo_if vif;

    `uvm_component_utils(fifo_test)

    fifo_sequencer #(DATA_WIDTH) sequencer;
    fifo_driver #(DATA_WIDTH) driver;
    fifo_monitor #(DATA_WIDTH) monitor;

    fifo_reference_model #(DATA_WIDTH, DEPTH) ref_model;
    fifo_scoreboard #(DATA_WIDTH) scoreboard;

    function new(
        string name = "fifo_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);

        if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "virtual interface not found")
        end

        // Create sequencer
        sequencer = fifo_sequencer#(DATA_WIDTH)::type_id::create("sequencer", this);

        // Create driver
        driver = fifo_driver#(DATA_WIDTH)::type_id::create("driver", this);

        // Create monitor
        monitor = fifo_monitor#(DATA_WIDTH)::type_id::create("monitor", this);

        // Create reference model
        ref_model = fifo_reference_model#(DATA_WIDTH, DEPTH)::type_id::create("ref_model", this);

        // Create scoreboard
        scoreboard = fifo_scoreboard#(DATA_WIDTH)::type_id::create("scoreboard", this);
    endfunction


    function void connect_phase(uvm_phase phase);

        // Connect sequencer to driver
        driver.seq_item_port.connect(sequencer.seq_item_export);

        // Connect driver to reference model
        driver.input_port.connect(ref_model.input_imp);

        // Connect reference model to scoreboard
        ref_model.expected_port.connect(scoreboard.expected_imp);

        // Connect monitor to scoreboard
        monitor.actual_port.connect(scoreboard.actual_imp);
    endfunction


    task run_phase(uvm_phase phase);

        fifo_basic_sequence #(DATA_WIDTH) fifo_basic_seq;
        fifo_concurrent_sequence #(DATA_WIDTH) fifo_concurrent_seq;
        fifo_empty_sequence #(DATA_WIDTH) fifo_empty_seq;
        fifo_full_sequence #(DATA_WIDTH) fifo_full_seq;
        fifo_idle_sequence #(DATA_WIDTH) fifo_idle_seq;
        fifo_random_sequence #(DATA_WIDTH) fifo_random_seq;
        fifo_reset_sequence #(DATA_WIDTH) fifo_reset_seq;

        phase.raise_objection(this);

        // Create sequence
        fifo_basic_seq = fifo_basic_sequence#(DATA_WIDTH)::type_id::create("fifo_basic_seq");
        fifo_concurrent_seq = fifo_concurrent_sequence#(DATA_WIDTH)::type_id::create("fifo_concurrent_seq");
        fifo_empty_seq = fifo_empty_sequence#(DATA_WIDTH)::type_id::create("fifo_empty_seq");
        fifo_full_seq = fifo_full_sequence#(DATA_WIDTH)::type_id::create("fifo_full_seq");
        fifo_idle_seq = fifo_idle_sequence#(DATA_WIDTH)::type_id::create("fifo_idle_seq");
        fifo_random_seq = fifo_random_sequence#(DATA_WIDTH)::type_id::create("fifo_random_seq");
        fifo_reset_seq = fifo_reset_sequence#(DATA_WIDTH)::type_id::create("fifo_reset_seq");

        // Start sequence
        fifo_reset_seq.start(sequencer);

        fifo_full_seq.start(sequencer);
        fifo_idle_seq.start(sequencer);
        fifo_concurrent_seq.start(sequencer);

        fifo_empty_seq.start(sequencer);
        fifo_idle_seq.start(sequencer);
        fifo_concurrent_seq.start(sequencer);

        fifo_full_seq.start(sequencer);
        fifo_empty_seq.start(sequencer);

        fifo_reset_seq.start(sequencer);
        fifo_random_seq.start(sequencer);

        phase.drop_objection(this);

    endtask

endclass
