module priority_encoder (
    input  logic [3:0] req,
    output logic [1:0] grant,
    output logic       valid
);

    always_comb begin
        valid = 1'b0;
        grant = 2'b00;

        if (req[3]) begin
            valid = 1'b1;
            grant = 2'd3;
        end
        else if (req[2]) begin
            valid = 1'b1;
            grant = 2'd2;
        end
        else if (req[1]) begin
            valid = 1'b1;
            grant = 2'd1;
        end
        else if (req[0]) begin
            valid = 1'b1;
            grant = 2'd0;
        end
    end

endmodule


module tb;

    logic [3:0] req;
    logic [1:0] grant;
    logic       valid;

    logic [1:0] expected_grant;
    logic       expected_valid;

    priority_encoder dut (
        .req   (req),
        .grant (grant),
        .valid (valid)
    );

    // Reference model
    function automatic void calculate_expected(
        input  logic [3:0] req,
        output logic [1:0] expected_grant,
        output logic       expected_valid
    );

        expected_valid = (req != 4'b0000);
        expected_grant = 2'b00;

        for (int i = 0; i < 4; i++) begin
            if (req[i]) begin
                expected_grant = i;
            end
        end

    endfunction


    initial begin

        req = 4'b0111;

        #1;

        calculate_expected(
            req,
            expected_grant,
            expected_valid
        );

        $display("req             = %b", req);
        $display("actual grant    = %0d", grant);
        $display("expected grant  = %0d", expected_grant);
        $display("actual valid    = %b", valid);
        $display("expected valid  = %b", expected_valid);

        if ((grant == expected_grant) &&
            (valid == expected_valid)) begin

            $display("PASS");

        end
        else begin

            $display("FAIL");

        end

        $finish;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 16 09:28 2026
req             = 0111
actual grant    = 2
expected grant  = 2
actual valid    = 1
expected valid  = 1
PASS
$finish called from file "design.sv", line 96.
$finish at simulation time                    1
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1 ns
*/