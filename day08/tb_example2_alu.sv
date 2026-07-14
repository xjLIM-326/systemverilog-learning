module tb_example2_alu;

logic [1:0] op;
logic [7:0] a;
logic [7:0] b;
logic [7:0] y;

alu dut(

    .op(op),
    .a(a),
    .b(b),
    .y(y)

);

initial begin

    $display("===== ALU Test =====");

    a = 8'd10;
    b = 8'd3;

    op = 2'b00;
    #10;
    $display("ADD : y=%0d", y);

    op = 2'b01;
    #10;
    $display("SUB : y=%0d", y);

    op = 2'b10;
    #10;
    $display("AND : y=%0d", y);

    op = 2'b11;
    #10;
    $display("DEFAULT : y=%0d", y);

    $finish;

end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 14 08:48 2026
===== ALU Test =====
ADD : y=13
SUB : y=7
AND : y=2
DEFAULT : y=0
$finish called from file "testbench.sv", line 40.
$finish at simulation time                   40
           V C S   S i m u l a t i o n   R e p o r t 
Time: 40 ns
*/