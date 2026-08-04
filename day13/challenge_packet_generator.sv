class Packet;

    rand bit [1:0] pkt_type;
    rand bit [7:0] addr;
    rand bit [7:0] data;
    bit            parity;
    rand bit [6:0] length;
    rand bit       error;

    constraint c_pkt_type {
        pkt_type inside {0,1,2};
    }

    constraint c_addr {
        addr inside {[16:127]};
    }

    constraint c_data {
        data > 50;
    }

    constraint c_length {
        length inside {[1:64]};
    }

    constraint c_type_length{
        if (pkt_type == 2)
            length >= 32;
    }

    constraint c_error{
        error dist {
            0:=90,
            1:=10
        };
    }

    function void post_randomize();
        parity = ^data;
    endfunction


endclass

module tb;

    Packet pkt;

    initial begin

        pkt = new();

        repeat (10) begin

            assert(pkt.randomize() with { length > 48; });

            $display(
                "type=%0d addr=%0d data=%0d parity=%0b length=%0d error=%0b",
                pkt.pkt_type,
                pkt.addr,
                pkt.data,
                pkt.parity,
                pkt.length,
                pkt.error
            );

        end

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:33 2026
type=2 addr=121 data=64 parity=1 length=54 error=0
type=2 addr=19 data=249 parity=0 length=60 error=0
type=0 addr=97 data=113 parity=0 length=49 error=0
type=0 addr=71 data=103 parity=1 length=58 error=0
type=0 addr=63 data=194 parity=1 length=53 error=0
type=2 addr=83 data=243 parity=0 length=62 error=0
type=0 addr=122 data=97 parity=1 length=51 error=0
type=1 addr=31 data=85 parity=0 length=55 error=0
type=0 addr=94 data=84 parity=1 length=60 error=0
type=0 addr=71 data=189 parity=0 length=53 error=0
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/