module tb_mux3;

logic [1:0] sel;
logic a, b, c;
logic y;

mux3 dut (
    .sel(sel),
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin

    $display("===== MUX3 Test =====");

    a = 1;
    b = 0;
    c = 1;

    sel = 2'b00; 
    #10;
    $display("sel=%b a=%b b=%b c=%b -> y=%b", sel, a, b, c, y);
    
    sel = 2'b01; 
    #10;
    $display("sel=%b a=%b b=%b c=%b -> y=%b", sel, a, b, c, y);
    
    sel = 2'b10; 
    #10;
    $display("sel=%b a=%b b=%b c=%b -> y=%b", sel, a, b, c, y);

    sel = 2'b11; 
    #10;
    $display("sel=%b a=%b b=%b c=%b -> y=%b", sel, a, b, c, y);

    $finish;
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 14 08:55 2026
===== MUX3 Test =====
sel=00 a=1 b=0 c=1 -> y=1
sel=01 a=1 b=0 c=1 -> y=0
sel=10 a=1 b=0 c=1 -> y=1
sel=11 a=1 b=0 c=1 -> y=0
$finish called from file "testbench.sv", line 39.
$finish at simulation time                   40
           V C S   S i m u l a t i o n   R e p o r t 
Time: 40 ns
*/