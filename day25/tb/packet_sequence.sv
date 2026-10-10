// My code

class packet_sequence extends uvm_sequence #(packet_transaction);

    `uvm_object_param_utils(packet_sequence)

    function new(string name = "packet_sequence");
        super.new(name);
    endfunction

    int seq_count = 0;

    task body();

        packet_transaction pkt_txn;

        repeat(50) begin

            pkt_txn = packet_transaction::type_id::create("pkt_txn");

            start_item(pkt_txn);

            if (seq_count == 0) begin
                assert(pkt_txn.randomize() with { data == 8'h00; });
            end
            else if (seq_count == 9) begin
                assert(pkt_txn.randomize() with { data == 8'hFF; });
            end
            else begin
                assert(pkt_txn.randomize());
            end

            seq_count++;
            finish_item(pkt_txn);

        end

    endtask

endclass