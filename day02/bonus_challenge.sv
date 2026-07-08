module day02_bonus;

bit   b;
logic l;

initial begin
    b = 0;
    l = 0;
    $display("Assign 0");
    $display("bit   = %b", b);
    $display("logic = %b", l);
    $display("");
  
    b = 1;
    l = 1;
    $display("Assign 1");
    $display("bit   = %b", b);
    $display("logic = %b", l);
    $display("");
  
    b = 'x;
    l = 'x;
    $display("Assign X");
    $display("bit   = %b", b);
    $display("logic = %b", l);
    $display("");
  
    b = 'z;
    l = 'z;
    $display("Assign Z");
    $display("bit   = %b", b);
    $display("logic = %b", l);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 09:05 2026
Assign 0
bit   = 0
logic = 0

Assign 1
bit   = 1
logic = 1

Assign X
bit   = 0
logic = x

Assign Z
bit   = 0
logic = z
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/