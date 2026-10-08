class packet_transaction extends uvm_sequence_item;

    rand bit [7:0] data;
    rand bit [1:0] dest;

    `uvm_object_utils(packet_transaction)

    function new(string name = "packet_transaction");
        super.new(name);
    endfunction

endclass