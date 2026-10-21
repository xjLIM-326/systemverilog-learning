`uvm_analysis_imp_decl(_expected)
`uvm_analysis_imp_decl(_actual)

class fifo_scoreboard #(parameter DATA_WIDTH = 8) extends uvm_scoreboard;

    `uvm_component_param_utils(fifo_scoreboard #(DATA_WIDTH))

    uvm_analysis_imp_expected #(
        fifo_transaction #(DATA_WIDTH),
        fifo_scoreboard #(DATA_WIDTH)
    ) expected_imp;

    uvm_analysis_imp_actual #(
        fifo_transaction #(DATA_WIDTH),
        fifo_scoreboard #(DATA_WIDTH)
    ) actual_imp;

    fifo_transaction #(DATA_WIDTH) q_expected[$];
    fifo_transaction #(DATA_WIDTH) q_actual[$];

    fifo_transaction #(DATA_WIDTH) expected;
    fifo_transaction #(DATA_WIDTH) actual;

    int total_checked = 0;
    int total_passed = 0;
    int total_failed = 0;

    function new(string name = "fifo_scoreboard",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Construct expected_imp and actual_imp
        expected_imp = new("expected_imp", this);
        actual_imp = new("actual_imp", this);
    endfunction

    // Called when Reference Model publishes an expected transaction
    function void write_expected(fifo_transaction #(DATA_WIDTH) tr);

        fifo_transaction #(DATA_WIDTH) expected;
        fifo_transaction #(DATA_WIDTH) actual;

        // Store the expected transaction
        q_expected.push_back(tr);

        // Attempt comparison if a matching actual transaction is already available
        try_compare();

    endfunction

    // Called when Monitor publishes an actual transaction
    function void write_actual(fifo_transaction #(DATA_WIDTH) tr);

        // Store the actual transaction
        q_actual.push_back(tr);

        // Attempt comparison if a matching expected transaction is already available
        try_compare();

    endfunction

    // Helper functions to compare transactions
    function void try_compare();

        fifo_transaction #(DATA_WIDTH) expected;
        fifo_transaction #(DATA_WIDTH) actual;

        if ((q_expected.size() != 0) && (q_actual.size() != 0)) begin
            expected = q_expected.pop_front();
            actual = q_actual.pop_front();

            compare_expected_actual(expected, actual);
        end

    endfunction

    function void compare_expected_actual(fifo_transaction#(DATA_WIDTH) expected, fifo_transaction#(DATA_WIDTH) actual);
        bit fail = 0;

        if (expected.dout != actual.dout) begin
            fail = 1;
            total_failed++; 
            `uvm_error("SCOREBOARD", $sformatf("Expected dout=%02h, actual dout=%02h", expected.dout, actual.dout))
        end

        if (expected.full != actual.full) begin
            if (!fail) begin
                fail = 1;
                total_failed++; 
            end
            `uvm_error("SCOREBOARD", $sformatf("Expected full=%b, actual full=%b", expected.full, actual.full))
        end

        if (expected.empty != actual.empty) begin
            if (!fail) begin
                fail = 1;
                total_failed++; 
            end
            `uvm_error("SCOREBOARD", $sformatf("Expected empty=%b, actual empty=%b", expected.empty, actual.empty))
        end

        if (!fail) begin
            total_passed++;
        end

        total_checked++;
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);

        // Report checked, passed and failed counts.
        $display("Total checked: %0d", total_checked);
        $display("Total passed : %0d", total_passed);
        $display("Total failed : %0d", total_failed);
    endfunction

endclass
