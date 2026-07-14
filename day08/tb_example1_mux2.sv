module tb_example1_mux2;

logic sel;
logic a;
logic b;
logic y;

mux2 dut(
    .sel(sel),
    .a(a),
    .b(b),
    .y(y)
);

initial begin

    $display("===== MUX2 Test =====");

    a = 0;
    b = 1;

    sel = 0;
    #10;
    $display("sel=%b a=%b b=%b -> y=%b", sel, a, b, y);

    sel = 1;
    #10;
    $display("sel=%b a=%b b=%b -> y=%b", sel, a, b, y);

    $finish;

end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 14 08:46 2026
===== MUX2 Test =====
sel=0 a=0 b=1 -> y=1
sel=1 a=0 b=1 -> y=0
$finish called from file "testbench.sv", line 30.
$finish at simulation time                   20
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/