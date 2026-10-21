class fifo_full_sequence #(parameter DATA_WIDTH = 8) extends uvm_sequence #(fifo_transaction #(DATA_WIDTH));

    `uvm_object_param_utils(fifo_full_sequence #(DATA_WIDTH))

    // Configurable number of extra write transactions
    int unsigned extra_write = 1;

    function new(string name = "fifo_full_sequence");
        super.new(name);
    endfunction

    task body();
        int unsigned txn_count = extra_write + 5;
        fifo_transaction #(DATA_WIDTH) fifo_txn;

        repeat(txn_count) begin
            fifo_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("fifo_txn");

            start_item(fifo_txn);

            fifo_txn.rst_n = 1;
            assert(fifo_txn.randomize() with {
                wr_en == 1;
                rd_en == 0;
            })
                else `uvm_fatal("RANDFAIL", "Write randomization failed")

            finish_item(fifo_txn);
        end
    endtask

endclass
