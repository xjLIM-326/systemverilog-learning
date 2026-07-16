module checker (
    input logic [4:0] actual,
    input logic [4:0] expected
);

    always_comb begin

        if (actual == expected) begin

            $display("PASS: expected=%0d actual=%0d",
                     expected,
                     actual);

        end
        else begin

            $error("FAIL: expected=%0d actual=%0d",
                   expected,
                   actual);

        end

    end

endmodule