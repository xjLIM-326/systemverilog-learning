module mux3(

input logic [1:0] sel,
input logic a,
input logic b,
input logic c,
output logic y

);

always_comb begin
    y = '0;

    case(sel)

        2'b00: y=a;

        2'b01: y=b;

        2'b10: y=c;

        default: ;

    endcase
end

endmodule