// My code

`include "packet_tb_pkg.svh"

module packet_tb;

    import uvm_pkg::*;
    import packet_tb_pkg::*;

    logic clk;

    packet_if vif(clk);

    packet_router dut (
        .vif(vif)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        vif.rst_n = 1'b0;
        vif.valid_i = 1'b0;

        repeat (2)
            @(posedge clk);

        vif.rst_n = 1'b1;
    end

    initial begin
        uvm_config_db#(virtual packet_if)::set(null, "*", "vif", vif);
        run_test("packet_test");
    end

endmodule

/*Output
UVM_INFO @ 0: reporter [RNTST] Running test packet_test...
UVM_INFO packet_monitor.sv(57) @ 35: uvm_test_top.monitor [MONITOR] data_o = 00 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 45: uvm_test_top.monitor [MONITOR] data_o = 11 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 55: uvm_test_top.monitor [MONITOR] data_o = 9b dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 65: uvm_test_top.monitor [MONITOR] data_o = 25 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 75: uvm_test_top.monitor [MONITOR] data_o = 36 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 85: uvm_test_top.monitor [MONITOR] data_o = 4c dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 95: uvm_test_top.monitor [MONITOR] data_o = f6 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 105: uvm_test_top.monitor [MONITOR] data_o = ad dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 115: uvm_test_top.monitor [MONITOR] data_o = d3 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 125: uvm_test_top.monitor [MONITOR] data_o = ff dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 135: uvm_test_top.monitor [MONITOR] data_o = 75 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 145: uvm_test_top.monitor [MONITOR] data_o = 87 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 155: uvm_test_top.monitor [MONITOR] data_o = 22 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 165: uvm_test_top.monitor [MONITOR] data_o = d6 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 175: uvm_test_top.monitor [MONITOR] data_o = fe dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 185: uvm_test_top.monitor [MONITOR] data_o = 44 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 195: uvm_test_top.monitor [MONITOR] data_o = dd dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 205: uvm_test_top.monitor [MONITOR] data_o = 64 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 215: uvm_test_top.monitor [MONITOR] data_o = 75 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 225: uvm_test_top.monitor [MONITOR] data_o = 44 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 235: uvm_test_top.monitor [MONITOR] data_o = e8 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 245: uvm_test_top.monitor [MONITOR] data_o = 4e dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 255: uvm_test_top.monitor [MONITOR] data_o = 65 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 265: uvm_test_top.monitor [MONITOR] data_o = c4 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 275: uvm_test_top.monitor [MONITOR] data_o = 41 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 285: uvm_test_top.monitor [MONITOR] data_o = 66 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 295: uvm_test_top.monitor [MONITOR] data_o = b7 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 305: uvm_test_top.monitor [MONITOR] data_o = ba dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 315: uvm_test_top.monitor [MONITOR] data_o = b9 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 325: uvm_test_top.monitor [MONITOR] data_o = d9 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 335: uvm_test_top.monitor [MONITOR] data_o = 43 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 345: uvm_test_top.monitor [MONITOR] data_o = 36 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 355: uvm_test_top.monitor [MONITOR] data_o = 95 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 365: uvm_test_top.monitor [MONITOR] data_o = ae dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 375: uvm_test_top.monitor [MONITOR] data_o = 0b dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 385: uvm_test_top.monitor [MONITOR] data_o = 15 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 395: uvm_test_top.monitor [MONITOR] data_o = 0d dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 405: uvm_test_top.monitor [MONITOR] data_o = 17 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 415: uvm_test_top.monitor [MONITOR] data_o = 96 dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 425: uvm_test_top.monitor [MONITOR] data_o = 87 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 435: uvm_test_top.monitor [MONITOR] data_o = e5 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 445: uvm_test_top.monitor [MONITOR] data_o = 32 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 455: uvm_test_top.monitor [MONITOR] data_o = 33 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 465: uvm_test_top.monitor [MONITOR] data_o = 16 dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 475: uvm_test_top.monitor [MONITOR] data_o = bb dest_o = 01
UVM_INFO packet_monitor.sv(57) @ 485: uvm_test_top.monitor [MONITOR] data_o = e3 dest_o = 10
UVM_INFO packet_monitor.sv(57) @ 495: uvm_test_top.monitor [MONITOR] data_o = cc dest_o = 11
UVM_INFO packet_monitor.sv(57) @ 505: uvm_test_top.monitor [MONITOR] data_o = 09 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 515: uvm_test_top.monitor [MONITOR] data_o = b0 dest_o = 00
UVM_INFO packet_monitor.sv(57) @ 525: uvm_test_top.monitor [MONITOR] data_o = 1d dest_o = 00
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_objection.svh(1276) @ 525: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
Total checked: 50
Total passed : 50
Total failed : 0
Total unexpected : 0
Remaining DUT transactions : 0
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 525: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   53
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[MONITOR]    50
[RNTST]     1
[TEST_DONE]     1
[UVM/RELNOTES]     1

$finish called from file "/apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_root.svh", line 532.
$finish at simulation time                  525
           V C S   S i m u l a t i o n   R e p o r t 
Time: 525 ns
*/