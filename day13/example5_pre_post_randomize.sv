class Packet;

    rand bit [7:0] addr;

    function void pre_randomize();
        $display("Before randomization");
    endfunction

    function void post_randomize();
        $display("After randomization: addr=%0d", addr);
    endfunction

endclass

module tb;

    Packet pkt;

    initial begin

        pkt = new();

        repeat (3)
            pkt.randomize();

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:07 2026
Before randomization
After randomization: addr=185
Before randomization
After randomization: addr=91
Before randomization
After randomization: addr=58
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/