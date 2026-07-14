module priority_encoder(

input logic [3:0] req,
output logic [1:0] grant,
output logic valid

);

always_comb begin
    grant = 2'b00;
    valid = 0;

    if (req[3]) begin
        grant = 2'b11;
        valid = 1;
    end
    else if (req[2]) begin
        grant = 2'b10;
        valid = 1;
    end
    else if (req[1]) begin
        grant = 2'b01;
        valid = 1;
    end
    else if (req[0]) begin
        grant = 2'b00;
        valid = 1;
    end
end

endmodule