class Packet;

    rand bit [3:0] id;
    rand bit [7:0] data;

endclass

module challenge;

    mailbox mbx;

    Packet tx;
    Packet rx;

    initial begin
        mbx = new();
    end

    // Lines appended
    initial begin
        repeat (5) begin
            #5;
            tx = new();
            tx.randomize();
            mbx.put(tx);
        end
    end

    initial begin
        forever begin
            mbx.get(rx);
            $display("[%02t] Received id=%0h data=%02h", $time, rx.id, rx.data);
        end
    end
    // End of append

endmodule

/*Output
ompiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  5 09:33 2026
[ 5] Received id=1 data=e6
[10] Received id=3 data=13
[15] Received id=7 data=c4
[20] Received id=d data=16
[25] Received id=c data=75
           V C S   S i m u l a t i o n   R e p o r t 
Time: 25 ns
*/