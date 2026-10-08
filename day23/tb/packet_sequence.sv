// My code

class packet_sequence extends uvm_sequence #(packet_transaction);

    `uvm_object_param_utils(packet_sequence)

    function new(string name = "packet_sequence");
        super.new(name);
    endfunction

    int rand_count = 0;

    task body();

        packet_transaction pkt_txn;

        repeat(10) begin

            pkt_txn = packet_transaction::type_id::create("pkt_txn");

            start_item(pkt_txn);

            if (rand_count == 0) begin
                assert(pkt_txn.randomize() with { data == 8'h00; });
                rand_count++;
            end
            else if (rand_count == 1) begin
                assert(pkt_txn.randomize() with { data == 8'hFF; });
                rand_count++;
            end
            else begin
                assert(pkt_txn.randomize());
            end

            finish_item(pkt_txn);

        end

    endtask

endclass