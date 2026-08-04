class Packet;

    rand bit [7:0] addr;
    rand bit [7:0] data;

    constraint addr_limit {
        addr inside {[16:63]};
    }

    constraint data_even {
        data % 2 == 0;
    }

endclass

module tb;

    Packet pkt;

    initial begin
        pkt = new();

        repeat (10) begin
            pkt.randomize();

            $display("addr=%0d data=%0d",
                     pkt.addr,
                     pkt.data);
        end
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:05 2026
addr=26 data=176
addr=27 data=138
addr=45 data=80
addr=52 data=12
addr=26 data=110
addr=22 data=118
addr=61 data=208
addr=27 data=238
addr=45 data=244
addr=29 data=120
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/