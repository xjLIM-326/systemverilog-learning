module packet_coverage (
    input  logic       clk,
    input  logic [1:0] packet_type,
    input  logic [3:0] packet_size,
    input  logic       error
);

covergroup packet_cg @(posedge clk);

    cp_pkt_type : coverpoint packet_type {
        bins control = {0};
        bins data    = {1};
        bins ack     = {2};
        illegal_bins reserved = {3};
    }

    cp_pkt_size : coverpoint packet_size {
        bins small_pkt  = {[0:3]};
        bins medium_pkt = {[4:11]};
        bins large_pkt  = {[12:15]};
    }

    cp_error : coverpoint error;

    pkt_type_size_cross : cross cp_pkt_type, cp_pkt_size;

endgroup

packet_cg cov;

initial begin
    cov = new();
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  2 08:54 2026

Error-[FCIBH] Illegal bin hit
/home/runner/testbench.sv, 10
packet_coverage, "packet_coverage::packet_cg"
  VERIFICATION ERROR (FUNCTIONAL COVERAGE) : At time 15 ns, Illegal state bin 
  reserved of coverpoint cp_pkt_type in covergroup packet_coverage::packet_cg 
  got hit with value 0x3
  Covergroup Instance: cov 
  Design hierarchy: tb_packet_monitor.cov

           V C S   S i m u l a t i o n   R e p o r t 
Time: 15 ns
*/