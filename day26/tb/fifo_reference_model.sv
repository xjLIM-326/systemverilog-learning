`uvm_analysis_imp_decl(_input)

class fifo_reference_model #(parameter DATA_WIDTH = 8, parameter DEPTH = 4) extends uvm_component;

    `uvm_component_param_utils(fifo_reference_model #(DATA_WIDTH))

    uvm_analysis_imp_input #(fifo_transaction #(DATA_WIDTH), fifo_reference_model #(DATA_WIDTH, DEPTH)) input_imp;
    uvm_analysis_port #(fifo_transaction #(DATA_WIDTH)) expected_port;

    logic [DATA_WIDTH-1:0] expected_queue[$];
    bit [DATA_WIDTH-1:0] expected_dout;
    bit wr_accept;
    bit rd_accept;

    function new(string name = "fifo_reference_model",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        input_imp = new("input_imp", this);
        expected_port = new("expected_port", this);
    endfunction


    function void write_input(fifo_transaction #(DATA_WIDTH) tr);

        fifo_transaction #(DATA_WIDTH) expected_txn;

        // Create a new expected transaction using UVM factory
        expected_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("expected_txn");

        // Calculate expected output fields according to existing DUT specification
        if (!tr.rst_n) begin
            expected_queue.delete();
            expected_dout = 0;
        end
        else begin
            wr_accept = tr.wr_en && (expected_queue.size() < DEPTH);
            rd_accept = tr.rd_en && (expected_queue.size() > 0);

            if (wr_accept) begin
                expected_queue.push_back(tr.din);
            end

            if (rd_accept) begin
                expected_dout = expected_queue.pop_front();
            end
        end

        expected_txn.dout = expected_dout;
        expected_txn.full = (expected_queue.size() == DEPTH);
        expected_txn.empty = (expected_queue.size() == 0);

        // Publish expected_txn through expected_port
        expected_port.write(expected_txn);

    endfunction

endclass
