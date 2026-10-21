class fifo_reset_sequence #(parameter DATA_WIDTH = 8) extends uvm_sequence #(fifo_transaction #(DATA_WIDTH));

    `uvm_object_param_utils(fifo_reset_sequence #(DATA_WIDTH))

    // Configurable number of transactions
    int unsigned txn_count = 1;

    function new(string name = "fifo_reset_sequence");
        super.new(name);
    endfunction

    task body();
        fifo_transaction #(DATA_WIDTH) fifo_txn;

        repeat(txn_count) begin
            fifo_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("fifo_txn");

            start_item(fifo_txn);

            fifo_txn.rst_n = 0;
            assert(fifo_txn.randomize())
                else `uvm_fatal("RANDFAIL", "Reset sequence randomization failed")

            finish_item(fifo_txn);
        end
    endtask

endclass
