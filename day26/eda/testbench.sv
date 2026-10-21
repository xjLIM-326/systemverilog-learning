`include "fifo_assertions.sv"
`include "fifo_bind.sv"
`include "sfifo_tb_pkg.svh"

module fifo_tb;

    import uvm_pkg::*;
    import sfifo_tb_pkg::*;

    logic clk;

    fifo_if vif(clk);

    sync_fifo #(8, 4) dut (
        .vif(vif)
    );

    // Dump waveform for debugging
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, fifo_tb);
    end

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Reset
    initial begin
        vif.rst_n = 1'b0;

        repeat (2)
            @(posedge clk);

        vif.rst_n = 1'b1;
    end

    initial begin
        uvm_config_db#(virtual fifo_if)::set(null, "*", "vif", vif);
        run_test("fifo_test");
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Oct 21 11:32 2026
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_root.svh(407) @ 0: reporter [UVM/RELNOTES] 
----------------------------------------------------------------
UVM-1.2.Synopsys
(C) 2007-2014 Mentor Graphics Corporation
(C) 2007-2014 Cadence Design Systems, Inc.
(C) 2006-2014 Synopsys, Inc.
(C) 2011-2013 Cypress Semiconductor Corp.
(C) 2013-2014 NVIDIA Corporation
----------------------------------------------------------------

  ***********       IMPORTANT RELEASE NOTES         ************

  You are using a version of the UVM library that has been compiled
  with `UVM_NO_DEPRECATED undefined.
  See http://www.eda.org/svdb/view.php?id=3313 for more details.

  You are using a version of the UVM library that has been compiled
  with `UVM_OBJECT_DO_NOT_NEED_CONSTRUCTOR undefined.
  See http://www.eda.org/svdb/view.php?id=3770 for more details.

      (Specify +UVM_NO_RELNOTES to turn off this notice)

UVM_INFO @ 0: reporter [RNTST] Running test fifo_test...
UVM_INFO fifo_assertions.sv(7) @ 0: reporter [SVA] fifo_assertions instantiated at fifo_tb.dut.fifo_assertions_i
UVM_INFO fifo_monitor.sv(93) @ 6: uvm_test_top.monitor [MONITOR] rst_n=0 wr=1 rd=1 din=2d | dout=00 full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 16: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=c2 | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 26: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=35 | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 36: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=0f | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 46: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=c1 | dout=00 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 56: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=23 | dout=00 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 66: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=96 | dout=00 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 76: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=15 | dout=00 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 86: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=15 | dout=c2 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 96: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=ec | dout=35 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 106: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=0f | dout=0f full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 116: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=32 | dout=c1 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 126: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=f6 | dout=ec full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 136: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=d0 | dout=ec full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 146: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=30 | dout=ec full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 156: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=aa | dout=ec full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 166: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=e2 | dout=ec full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 176: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=94 | dout=ec full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 186: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=c3 | dout=94 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 196: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=8b | dout=94 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 206: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=5d | dout=94 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 216: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=7d | dout=94 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 226: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=5c | dout=94 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 236: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=25 | dout=94 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 246: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=e5 | dout=94 full=1 empty=0
UVM_INFO fifo_monitor.sv(93) @ 256: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=d5 | dout=c3 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 266: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=d9 | dout=8b full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 276: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=80 | dout=5d full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 286: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=7b | dout=7d full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 296: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=06 | dout=7d full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 306: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=81 | dout=7d full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 316: uvm_test_top.monitor [MONITOR] rst_n=0 wr=0 rd=0 din=32 | dout=00 full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 326: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=e7 | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 336: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=96 | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 346: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=d4 | dout=00 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 356: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=66 | dout=e7 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 366: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=e6 | dout=d4 full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 376: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=1 din=ed | dout=d4 full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 386: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=b6 | dout=d4 full=0 empty=1
UVM_INFO fifo_monitor.sv(93) @ 396: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=e5 | dout=d4 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 406: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=46 | dout=d4 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 416: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=b8 | dout=e5 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 426: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=55 | dout=e5 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 436: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=1 din=4d | dout=b8 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 446: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=28 | dout=b8 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 456: uvm_test_top.monitor [MONITOR] rst_n=1 wr=0 rd=0 din=87 | dout=b8 full=0 empty=0
UVM_INFO fifo_monitor.sv(93) @ 466: uvm_test_top.monitor [MONITOR] rst_n=1 wr=1 rd=0 din=e7 | dout=b8 full=0 empty=0
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_objection.svh(1276) @ 470: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
UVM_INFO fifo_monitor.sv(117) @ 470: uvm_test_top.monitor [COVERAGE] FIFO state = 100.00%
UVM_INFO fifo_monitor.sv(118) @ 470: uvm_test_top.monitor [COVERAGE] Operation = 100.00%
UVM_INFO fifo_monitor.sv(119) @ 470: uvm_test_top.monitor [COVERAGE] FIFO state x Operation = 100.00%
Total checked: 47
Total passed : 47
Total failed : 0
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 470: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   54
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[COVERAGE]     3
[MONITOR]    47
[RNTST]     1
[SVA]     1
[TEST_DONE]     1
[UVM/RELNOTES]     1

$finish called from file "/apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_root.svh", line 532.
$finish at simulation time                  470
           V C S   S i m u l a t i o n   R e p o r t 
Time: 470 ns
*/