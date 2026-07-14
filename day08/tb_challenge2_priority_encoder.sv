module tb_priority_encoder;

logic [3:0] req;
logic [1:0] grant;
logic valid;

priority_encoder dut (
    .req(req),
    .grant(grant),
    .valid(valid)
);

initial begin

    $display("===== Priority Encoder Test =====");

    req = 4'b0000; 
    #10;
    $display("req=%04b -> grant=%d, valid=%b", req, grant, valid);
    
    req = 4'b0001; 
    #10;
    $display("req=%04b -> grant=%d, valid=%b", req, grant, valid);

    req = 4'b0011; 
    #10;
    $display("req=%04b -> grant=%d, valid=%b", req, grant, valid);

    req = 4'b0111; 
    #10;
    $display("req=%04b -> grant=%d, valid=%b", req, grant, valid);

    req = 4'b1111; 
    #10;
    $display("req=%04b -> grant=%d, valid=%b", req, grant, valid);
    $finish;
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 14 09:09 2026
===== Priority Encoder Test =====
req=0000 -> grant=0, valid=0
req=0001 -> grant=0, valid=1
req=0011 -> grant=1, valid=1
req=0111 -> grant=2, valid=1
req=1111 -> grant=3, valid=1
$finish called from file "testbench.sv", line 36.
$finish at simulation time                   50
           V C S   S i m u l a t i o n   R e p o r t 
Time: 50 ns
*/