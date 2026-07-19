module tb_handshake;

    logic       clk;
    logic       rst_n;

    logic       valid;
    logic [7:0] data;

    logic       ready;
    logic       accepted;


    handshake_consumer dut (
        .clk      (clk),
        .rst_n    (rst_n),

        .valid    (valid),
        .data     (data),

        .ready    (ready),
        .accepted (accepted)
    );


    handshake_assertions assertions (
        .clk      (clk),
        .rst_n    (rst_n),

        .valid    (valid),
        .data     (data),

        .ready    (ready),
        .accepted (accepted)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin

    $monitor("Time=%0t rst_n=%b valid=%b data=%02h ready=%b, accepted=%b", $time, rst_n, valid, data, ready, accepted);

        rst_n = 0;
        valid = 0;
        data  = 0;

        #12;
        rst_n = 1;

        @(negedge clk);
        valid = 1;
        data  = 8'hAA;

        @(negedge clk);
        valid = 0;
        
        @(negedge clk);
        valid = 1;
        data  = 8'hBB;

        repeat (2)
            @(negedge clk);
        data  = 8'hCC;

        @(negedge clk);
        data  = 8'hDD;

        repeat (2)
            @(negedge clk);
        rst_n  = 0;

        #7;
        rst_n = 1;

        @(negedge clk);
        valid  = 1;

        @(negedge clk);
        valid  = 0;

        @(negedge clk);
        $finish;
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul 19 05:39 2026
Time=0 rst_n=0 valid=0 data=00 ready=0, accepted=0
Time=12 rst_n=1 valid=0 data=00 ready=0, accepted=0
Time=15 rst_n=1 valid=0 data=00 ready=1, accepted=0
Time=20 rst_n=1 valid=1 data=aa ready=1, accepted=0
Time=25 rst_n=1 valid=1 data=aa ready=1, accepted=1
Time=30 rst_n=1 valid=0 data=aa ready=1, accepted=1
Time=35 rst_n=1 valid=0 data=aa ready=0, accepted=0
Time=40 rst_n=1 valid=1 data=bb ready=0, accepted=0
Time=55 rst_n=1 valid=1 data=bb ready=1, accepted=0
Time=60 rst_n=1 valid=1 data=cc ready=1, accepted=0
"testbench.sv", 58: tb_handshake.assertions.unnamed$$_4: started at 55ns failed at 65ns
	Offending '$stable(data)'
Error: "testbench.sv", 58: tb_handshake.assertions.unnamed$$_4: at time 65 ns
ILLEGAL: Data changed before accepted
Time=65 rst_n=1 valid=1 data=cc ready=1, accepted=1
Time=70 rst_n=1 valid=1 data=dd ready=1, accepted=1
Time=75 rst_n=1 valid=1 data=dd ready=0, accepted=0
Time=90 rst_n=0 valid=1 data=dd ready=0, accepted=0
Time=97 rst_n=1 valid=1 data=dd ready=0, accepted=0
Time=105 rst_n=1 valid=1 data=dd ready=1, accepted=0
Time=110 rst_n=1 valid=0 data=dd ready=1, accepted=0
"testbench.sv", 48: tb_handshake.assertions.unnamed$$_3: started at 105ns failed at 115ns
	Offending 'valid'
Error: "testbench.sv", 48: tb_handshake.assertions.unnamed$$_3: at time 115 ns
ILLEGAL: Valid changed before accepted
$finish called from file "testbench.sv", line 148.
$finish at simulation time                  120
           V C S   S i m u l a t i o n   R e p o r t 
Time: 120 ns
*/