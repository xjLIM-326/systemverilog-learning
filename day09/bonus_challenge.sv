module tb;

    logic [3:0] req;
    logic [1:0] grant;
    logic       valid;

    logic [1:0] expected_grant;
    logic       expected_valid;
    logic [4:0] pass_count;
    logic [4:0] fail_count;

    priority_encoder dut (
        .req   (req),
        .grant (grant),
        .valid (valid)
    );

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

    task automatic check_result(
        input logic [3:0] req,
        input logic [1:0] grant,
        input logic       valid,
        input logic [1:0] expected_grant,
        input logic       expected_valid
    );

        if ((grant == expected_grant) && (valid == expected_valid)) begin
            pass_count++;
            $display("PASS: req=%04b grant=%d valid=%b", req, grant, valid);
        end
        else begin
            fail_count++;
            $error("FAIL-> req=%04b | expected: grant=%d valid=%b | actual: grant=%d valid=%b", req, expected_grant, expected_valid, grant, valid);
        end

    endtask

    initial begin

        pass_count = '0;
        fail_count = '0;

        repeat (20) begin
            req = $urandom_range(0, 15);
            #1;
            calculate_expected(req, expected_grant, expected_valid);
            check_result(req, grant, valid, expected_grant, expected_valid);
        end

        #1;
        $display("========================");
        $display("TEST SUMMARY\nPASS: %d\nFAIL: %d", pass_count, fail_count);
        $display("========================");

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 16 10:24 2026
PASS: req=0110 grant=2 valid=1
PASS: req=1100 grant=3 valid=1
PASS: req=1101 grant=3 valid=1
PASS: req=0010 grant=1 valid=1
PASS: req=1011 grant=3 valid=1
PASS: req=1111 grant=3 valid=1
PASS: req=0000 grant=0 valid=0
PASS: req=0111 grant=2 valid=1
PASS: req=0110 grant=2 valid=1
PASS: req=1011 grant=3 valid=1
PASS: req=0101 grant=2 valid=1
PASS: req=1010 grant=3 valid=1
PASS: req=1110 grant=3 valid=1
PASS: req=0101 grant=2 valid=1
PASS: req=1101 grant=3 valid=1
PASS: req=0010 grant=1 valid=1
PASS: req=0110 grant=2 valid=1
PASS: req=0001 grant=0 valid=1
PASS: req=0100 grant=2 valid=1
PASS: req=1010 grant=3 valid=1
========================
TEST SUMMARY
PASS:  20
FAIL:   0
========================
           V C S   S i m u l a t i o n   R e p o r t 
Time: 21 ns
*/