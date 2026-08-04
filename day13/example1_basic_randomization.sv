class Packet;

    rand bit [7:0] addr;
    rand bit [7:0] data;

endclass

module tb;

    Packet pkt;

    initial begin
        pkt = new();

        repeat (5) begin
            pkt.randomize();

            $display("addr = %0d, data = %0d",
                     pkt.addr,
                     pkt.data);
        end
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:05 2026
addr = 185, data = 108
addr = 91, data = 128
addr = 58, data = 86
addr = 7, data = 82
addr = 224, data = 76
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/