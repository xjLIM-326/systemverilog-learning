class fifo_basic_sequence #(parameter DATA_WIDTH = 8) extends uvm_sequence #(fifo_transaction #(DATA_WIDTH));

    `uvm_object_param_utils(fifo_basic_sequence #(DATA_WIDTH))

    // Configurable number of transactions
    int unsigned txn_count = 8;

    function new(string name = "fifo_basic_sequence");
        super.new(name);
    endfunction

    task body();
        fifo_transaction #(DATA_WIDTH) fifo_txn;

        repeat(txn_count) begin
            fifo_txn = fifo_transaction#(DATA_WIDTH)::type_id::create("fifo_txn");

            start_item(fifo_txn);

            fifo_txn.rst_n = 1;
            assert(fifo_txn.randomize() with {
                (wr_en ^ rd_en) == 1;
            })
                else `uvm_fatal("RANDFAIL", "Basic write-only/read-only randomization failed")

            finish_item(fifo_txn);
        end
    endtask

endclass
