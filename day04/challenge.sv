module day04_challenge;

logic [15:0] packet;
logic [7:0]  header;
logic [7:0]  payload;

initial begin
    packet = 16'hCAFE;
    header = packet[15:8];
    payload = packet[7:0];

    $display("Packet  = %h", packet);
    $display("Header  = %h", header);
    $display("Payload = %h", payload);
    $display("Rebuild = %h", {header, payload});
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 10 05:30 2026
Packet  = cafe
Header  = ca
Payload = fe
Rebuild = cafe
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/