class fifo_sequencer #(parameter DATA_WIDTH = 8) extends uvm_sequencer #(fifo_transaction #(DATA_WIDTH));

    `uvm_component_param_utils(fifo_sequencer #(DATA_WIDTH))

    function new(string name = "fifo_sequencer",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass
