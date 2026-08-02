module alu_coverage (
    input logic       clk,
    input logic [2:0] opcode,
    input logic [1:0] mode
);

covergroup alu_cg @(posedge clk);

    cp_opcode : coverpoint opcode {
        bins arithmetic = {[0:3]};
        bins logic_ops  = {[4:6]};
        illegal_bins reserved = {7};
    }

    cp_mode : coverpoint mode;

    opcode_mode_cross : cross cp_opcode, cp_mode;

endgroup

alu_cg cov;

initial begin
    cov = new();
end

endmodule

/*Output when opcode = $urandom_range(0,7);
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  2 08:32 2026

Error-[FCIBH] Illegal bin hit
/home/runner/testbench.sv, 9
alu_coverage, "alu_coverage::alu_cg"
  VERIFICATION ERROR (FUNCTIONAL COVERAGE) : At time 35 ns, Illegal state bin 
  reserved of coverpoint cp_opcode in covergroup alu_coverage::alu_cg got hit 
  with value 0x7
  Covergroup Instance: cov 
  Design hierarchy: tb_alu.cov

           V C S   S i m u l a t i o n   R e p o r t 
Time: 35 ns
*/