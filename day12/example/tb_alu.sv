module tb_alu;

logic clk;
logic [2:0] opcode;
logic [1:0] mode;
logic valid;

alu dut (
    .clk(clk),
    .opcode(opcode),
    .mode(mode),
    .valid(valid)
);

alu_coverage cov (
    .clk(clk),
    .opcode(opcode),
    .mode(mode)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    opcode = 0;
    mode = 0;

    repeat (100) begin
        @(posedge clk);
        opcode = $urandom_range(0,6);
        mode   = $urandom_range(0,3);
    end

    #20;

    $display("--------------------------------");
    $display("Functional Coverage = %.2f%%", cov.cov.get_coverage());
    $display("--------------------------------");

    $finish;
end

endmodule

/*Output when opcode = $urandom_range(0,6);
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  2 08:35 2026
--------------------------------
Functional Coverage = 100.00%
--------------------------------
$finish called from file "testbench.sv", line 68.
$finish at simulation time                 1015
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1015 ns
*/