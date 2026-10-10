// Adapted from ChatGPT

// Declare distinct analysis implementation types for the expected stream and actual stream
`uvm_analysis_imp_decl(_expected)
`uvm_analysis_imp_decl(_actual)

class packet_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(packet_scoreboard)

    uvm_event drain_done;

    // Declare two analysis implementation handles
    uvm_analysis_imp_expected #(packet_transaction, packet_scoreboard) expected_imp;
    uvm_analysis_imp_actual #(packet_transaction, packet_scoreboard) actual_imp;

    // Add storage for expected transactions
    packet_transaction expected_q[$];

    int total_checked = 0;
    int total_passed = 0;
    int total_failed = 0;
    int total_unexpected = 0;

    bit stimulus_done = 0;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Construct both analysis implementations
        expected_imp = new("expected_imp", this);
        actual_imp = new("actual_imp", this);

        // Create drain_done event
        drain_done = new("drain_done");
    endfunction

    // Implement write_expected(...) to store each expected transaction
    function void write_expected(packet_transaction expected);
        expected_q.push_back(expected);
    endfunction

    // Implement write_actual(...), update counters and report mismatches
    function void write_actual(packet_transaction actual);
        bit fail = 0;
        packet_transaction expected;

        if (expected_q.size() == 0) begin
            total_unexpected++;
            `uvm_error("SCOREBOARD", "Unexpected packet!")
            return;
        end

        expected = expected_q.pop_front();

        if (expected.data !== actual.data) begin
            fail = 1;
            total_failed++; 
            `uvm_error("SCOREBOARD", $sformatf("Expected data=%02h, actual data=%02h", expected.data, actual.data))
        end

        if (expected.dest !== actual.dest) begin
            if (!fail) begin
                fail = 1;
                total_failed++;
            end
            `uvm_error("SCOREBOARD", $sformatf("Expected dest=%02b, actual dest=%02b", expected.dest, actual.dest))
        end

        if (!fail) begin
            total_passed++;
        end

        total_checked++;
        check_completion();
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        // Print final statistics
        $display("Total checked: %0d", total_checked);
        $display("Total passed : %0d", total_passed);
        $display("Total failed : %0d", total_failed);
        $display("Total unexpected : %0d", total_unexpected);
        $display("Remaining DUT transactions : %0d", expected_q.size());
    endfunction

    function void mark_stimulus_done();
        stimulus_done = 1;
        check_completion();
    endfunction

    function void check_completion();
        // Check stimulus_done and expected_q, trigger drain_done if complete
        if (stimulus_done && (expected_q.size() == 0)) begin
            drain_done.trigger();
        end
    endfunction

endclass