class Packet;

    rand bit [7:0] addr;
    rand bit [7:0] data;

endclass

module tb;

    Packet pkt;

    initial begin

        pkt = new();

        repeat (5) begin

            pkt.randomize() with {
                addr < 10;
                data > 100;
            };

            $display("addr=%0d data=%0d",
                     pkt.addr,
                     pkt.data);
        end

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:06 2026
addr=3 data=250
addr=8 data=139
addr=3 data=179
addr=7 data=203
addr=7 data=163
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/