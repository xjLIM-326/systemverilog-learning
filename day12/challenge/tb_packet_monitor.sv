`timescale 1ns/1ps

module tb_packet_monitor;

logic clk;

logic [1:0] packet_type;
logic [3:0] packet_size;
logic       error;

logic packet_valid;

packet_monitor dut (
    .clk(clk),
    .packet_type(packet_type),
    .packet_size(packet_size),
    .error(error),
    .packet_valid(packet_valid)
);

packet_coverage cov (
    .clk(clk),
    .packet_type(packet_type),
    .packet_size(packet_size),
    .error(error)
);

always #5 clk = ~clk;

initial begin
    clk = 0;

    packet_type = 0;
    packet_size = 0;
    error = 0;

    repeat (200) begin
        @(posedge clk);

        packet_type = $urandom_range(0,2);
        packet_size = $urandom_range(0,15);
        error       = $urandom_range(0,1);
    end

    $display("--------------------------------");
    $display("Functional Coverage = %.2f%%", cov.cov.get_coverage());
    $display("--------------------------------");

    $finish;
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  2 08:54 2026
--------------------------------
Functional Coverage = 100.00%
--------------------------------
$finish called from file "testbench.sv", line 84.
$finish at simulation time                 1995
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1995 ns
*/