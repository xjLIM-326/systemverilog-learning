module day04_bonus;

logic [3:0] version;
logic [3:0] msg_type;
logic [7:0] length;

logic [15:0] header;

initial begin
    version  = 4'h2;
    msg_type = 4'hA;
    length   = 8'h3F;

    header = {version, msg_type, length};

    $display("Version = %h", version);
    $display("Type    = %h", msg_type);
    $display("Length  = %h", length);
    $display("Header  = %h", header);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:36 2026
Version = 2
Type    = a
Length  = 3f
Header  = 2a3f
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/