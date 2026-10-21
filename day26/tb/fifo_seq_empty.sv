class fifo_empty_sequence #(parameter DATA_WIDTH = 8) extends uvm_sequence #(fifo_transaction #(DATA_WIDTH));

    `uvm_object_param_utils(fifo_empty_sequence #(DATA_WIDTH))

    // Configurable number of extra read transactions
    int unsigned extra_read = 1;

    function new(string name = "fifo_empty_sequence");
        super.new(name);
    endfunction

    task body();
        int unsigned txn_count = extra_read + 5;
        fifo_transaction #(DATA_WIDTH) fifo_txn;

        repeat(txn_count) begin
            fifo_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("fifo_txn");

            start_item(fifo_txn);

            fifo_txn.rst_n = 1;
            assert(fifo_txn.randomize() with {
                wr_en == 0;
                rd_en == 1;
            })
                else `uvm_fatal("RANDFAIL", "Read randomization failed")

            finish_item(fifo_txn);
        end
    endtask

endclass
