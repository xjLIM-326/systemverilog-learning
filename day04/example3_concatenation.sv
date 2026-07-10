module example3_concatenation;

logic [3:0] high;
logic [3:0] low;
logic [7:0] data;

initial begin
    high = 4'hA;
    low  = 4'h5;

    data = {high, low};

    $display("high = %h", high);
    $display("low  = %h", low);
    $display("data = %h", data);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:23 2026
high = a
low  = 5
data = a5
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/