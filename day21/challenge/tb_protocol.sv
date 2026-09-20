module tb_protocol;

    logic clk;
    logic reset_n;

    logic req;

    logic grant;
    logic busy;
    logic done;


    // --------------------------------
    // DUT
    // --------------------------------

    protocol dut (
        .clk     (clk),
        .reset_n (reset_n),

        .req (req),

        .grant (grant),
        .busy  (busy),
        .done  (done)
    );


    // --------------------------------
    // Assertions
    // --------------------------------

    protocol_assertions assertions (
        .clk     (clk),
        .reset_n (reset_n),

        .req (req),

        .grant (grant),
        .busy  (busy),
        .done  (done)
    );


    // --------------------------------
    // Clock
    // --------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // --------------------------------
    // Stimulus
    // --------------------------------

    initial begin

        reset_n = 0;

        req = 0;

        repeat (2) @(negedge clk);

        reset_n = 1;

        @(negedge clk);
        req = 1;

        // @(negedge clk);
        repeat (2) @(negedge clk);
        req = 0;

        repeat (5) @(negedge clk);

        $finish;

    end


    // --------------------------------
    // Debug
    // --------------------------------

    always_ff @(posedge clk) begin
        $display("[%02t]: req=%b, grant=%b, busy=%b, done=%b", $time, req, grant, busy, done);
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Sep 20 10:37 2026
[ 5]: req=0, grant=0, busy=0, done=0
[15]: req=0, grant=0, busy=0, done=0
[25]: req=0, grant=0, busy=0, done=0
[35]: req=1, grant=0, busy=0, done=0
[45]: req=1, grant=1, busy=1, done=0
"testbench.sv", 175: tb_protocol.assertions.unnamed$$_3: started at 45ns failed at 45ns
	Offending '(!req)'
[55]: req=0, grant=0, busy=1, done=0
[65]: req=0, grant=0, busy=1, done=0
"testbench.sv", 121: tb_protocol.assertions.unnamed$$_0: started at 45ns failed at 65ns
	Offending 'grant'
[75]: req=0, grant=0, busy=1, done=1
[85]: req=0, grant=0, busy=0, done=0
[95]: req=0, grant=0, busy=0, done=0
$finish called from file "testbench.sv", line 78.
$finish at simulation time                  100
           V C S   S i m u l a t i o n   R e p o r t 
Time: 100 ns
*/