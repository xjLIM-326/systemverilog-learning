// Adapted from ChatGPT

`uvm_analysis_imp_decl(_input)

class packet_reference_model extends uvm_component;

    `uvm_component_utils(packet_reference_model)

    // Declare analysis_imp that receives packet_transaction from driver
    uvm_analysis_imp_input #(packet_transaction, packet_reference_model) input_imp;

    // Declare analysis_port that publishes expected packet_transaction to scoreboard
    uvm_analysis_port #(packet_transaction) expected_port;

    function new(string name = "packet_reference_model",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Construct input_imp and expected_port
        input_imp = new("input_imp", this);
        expected_port = new("expected_port", this);
    endfunction


    function void write_input(packet_transaction tr);

        packet_transaction expected_txn;

        // Create a new expected transaction using UVM factory
        expected_txn = packet_transaction::type_id::create("expected_txn");

        // Calculate expected output fields according to existing DUT specification
        expected_txn.data = tr.data;
        expected_txn.dest = tr.dest;

        // Publish expected_txn through expected_port
        expected_port.write(expected_txn);

    endfunction

endclass
