class Packet;

    rand bit [7:0] addr;
    rand bit [31:0] data;

endclass


module packet_mailbox;

    mailbox mbx;

    Packet tx;
    Packet rx;

    initial begin
        mbx = new();
    end

    initial begin

        tx = new();

        repeat (5) begin

            tx.randomize();

            mbx.put(tx);

            $display(
                "[%0t] Sent addr=%0h data=%0h",
                $time,
                tx.addr,
                tx.data
            );

            #10;
        end

    end

    initial begin

        forever begin

            mbx.get(rx);

            $display(
                "[%0t] Received addr=%0h data=%0h",
                $time,
                rx.addr,
                rx.data
            );

        end

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  5 09:25 2026
[0] Sent addr=41 data=cfd589e6
[0] Received addr=41 data=cfd589e6
[10] Sent addr=f0 data=6abe5dd4
[10] Received addr=f0 data=6abe5dd4
[20] Sent addr=7 data=fc28ab65
[20] Received addr=7 data=fc28ab65
[30] Sent addr=72 data=e412f3ff
[30] Received addr=72 data=e412f3ff
[40] Sent addr=cc data=2156ad2b
[40] Received addr=cc data=2156ad2b
           V C S   S i m u l a t i o n   R e p o r t 
Time: 50 ns
*/