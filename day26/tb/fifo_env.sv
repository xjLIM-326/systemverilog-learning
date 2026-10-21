class fifo_env #(parameter DATA_WIDTH = 8, parameter DEPTH = 8) extends uvm_env;

    `uvm_component_param_utils(fifo_env #(DATA_WIDTH))

    fifo_agent #(DATA_WIDTH) agent;
    fifo_reference_model #(DATA_WIDTH, DEPTH) ref_model;
    fifo_scoreboard #(DATA_WIDTH) scoreboard;

    function new(
        string name = "fifo_env",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent = fifo_agent#(DATA_WIDTH)::type_id::create("agent", this);
        ref_model = fifo_reference_model#(DATA_WIDTH, DEPTH)::type_id::create("ref_model", this);
        scoreboard = fifo_scoreboard#(DATA_WIDTH)::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect driver to reference model
        agent.driver.input_port.connect(ref_model.input_imp);

        // Connect reference model to scoreboard
        ref_model.expected_port.connect(scoreboard.expected_imp);

        // Connect monitor to scoreboard
        agent.monitor.actual_port.connect(scoreboard.actual_imp);
    endfunction

endclass
