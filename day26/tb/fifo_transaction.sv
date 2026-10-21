class fifo_transaction #(parameter DATA_WIDTH = 8) extends uvm_sequence_item;

    rand bit                    wr_en;
    rand bit                    rd_en;
    rand bit [DATA_WIDTH-1:0]   din;

    bit                     rst_n;
    bit [DATA_WIDTH-1:0]    dout;
    bit                     full;
    bit                     empty;

    `uvm_object_param_utils(fifo_transaction #(DATA_WIDTH))

    function new(string name = "fifo_transaction");
        super.new(name);
    endfunction

    constraint c_data { din > 0; }

endclass
