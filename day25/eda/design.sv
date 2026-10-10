interface packet_if(input logic clk);

    logic       rst_n;

    logic       valid_i;
    logic [7:0] data_i;
    logic [1:0] dest_i;

    logic       valid_o;
    logic [7:0] data_o;
    logic [1:0] dest_o;

endinterface


module packet_router (
    packet_if vif
);

    always_ff @(posedge vif.clk or negedge vif.rst_n) begin
        if (!vif.rst_n) begin
            vif.valid_o <= 1'b0;
            vif.data_o  <= 8'h00;
            vif.dest_o  <= 2'b00;
        end
        else begin
            vif.valid_o <= vif.valid_i;
            vif.data_o  <= vif.data_i;
            vif.dest_o  <= vif.dest_i;
        end
    end

endmodule

/*Output when line 28: vif.data_o  <= vif.data_i + 1;
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Oct 10 09:36 2026
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

UVM_INFO @ 0: reporter [RNTST] Running test packet_test...
UVM_ERROR packet_scoreboard.sv(63) @ 35: uvm_test_top.scoreboard [SCOREBOARD] Expected data=00, actual data=01
UVM_INFO packet_monitor.sv(57) @ 35: uvm_test_top.monitor [MONITOR] data_o = 01 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 45: uvm_test_top.scoreboard [SCOREBOARD] Expected data=11, actual data=12
UVM_INFO packet_monitor.sv(57) @ 45: uvm_test_top.monitor [MONITOR] data_o = 12 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 55: uvm_test_top.scoreboard [SCOREBOARD] Expected data=9b, actual data=9c
UVM_INFO packet_monitor.sv(57) @ 55: uvm_test_top.monitor [MONITOR] data_o = 9c dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 65: uvm_test_top.scoreboard [SCOREBOARD] Expected data=25, actual data=26
UVM_INFO packet_monitor.sv(57) @ 65: uvm_test_top.monitor [MONITOR] data_o = 26 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 75: uvm_test_top.scoreboard [SCOREBOARD] Expected data=36, actual data=37
UVM_INFO packet_monitor.sv(57) @ 75: uvm_test_top.monitor [MONITOR] data_o = 37 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 85: uvm_test_top.scoreboard [SCOREBOARD] Expected data=4c, actual data=4d
UVM_INFO packet_monitor.sv(57) @ 85: uvm_test_top.monitor [MONITOR] data_o = 4d dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 95: uvm_test_top.scoreboard [SCOREBOARD] Expected data=f6, actual data=f7
UVM_INFO packet_monitor.sv(57) @ 95: uvm_test_top.monitor [MONITOR] data_o = f7 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 105: uvm_test_top.scoreboard [SCOREBOARD] Expected data=ad, actual data=ae
UVM_INFO packet_monitor.sv(57) @ 105: uvm_test_top.monitor [MONITOR] data_o = ae dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 115: uvm_test_top.scoreboard [SCOREBOARD] Expected data=d3, actual data=d4
UVM_INFO packet_monitor.sv(57) @ 115: uvm_test_top.monitor [MONITOR] data_o = d4 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 125: uvm_test_top.scoreboard [SCOREBOARD] Expected data=ff, actual data=00
UVM_INFO packet_monitor.sv(57) @ 125: uvm_test_top.monitor [MONITOR] data_o = 00 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 135: uvm_test_top.scoreboard [SCOREBOARD] Expected data=75, actual data=76
UVM_INFO packet_monitor.sv(57) @ 135: uvm_test_top.monitor [MONITOR] data_o = 76 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 145: uvm_test_top.scoreboard [SCOREBOARD] Expected data=87, actual data=88
UVM_INFO packet_monitor.sv(57) @ 145: uvm_test_top.monitor [MONITOR] data_o = 88 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 155: uvm_test_top.scoreboard [SCOREBOARD] Expected data=22, actual data=23
UVM_INFO packet_monitor.sv(57) @ 155: uvm_test_top.monitor [MONITOR] data_o = 23 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 165: uvm_test_top.scoreboard [SCOREBOARD] Expected data=d6, actual data=d7
UVM_INFO packet_monitor.sv(57) @ 165: uvm_test_top.monitor [MONITOR] data_o = d7 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 175: uvm_test_top.scoreboard [SCOREBOARD] Expected data=fe, actual data=ff
UVM_INFO packet_monitor.sv(57) @ 175: uvm_test_top.monitor [MONITOR] data_o = ff dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 185: uvm_test_top.scoreboard [SCOREBOARD] Expected data=44, actual data=45
UVM_INFO packet_monitor.sv(57) @ 185: uvm_test_top.monitor [MONITOR] data_o = 45 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 195: uvm_test_top.scoreboard [SCOREBOARD] Expected data=dd, actual data=de
UVM_INFO packet_monitor.sv(57) @ 195: uvm_test_top.monitor [MONITOR] data_o = de dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 205: uvm_test_top.scoreboard [SCOREBOARD] Expected data=64, actual data=65
UVM_INFO packet_monitor.sv(57) @ 205: uvm_test_top.monitor [MONITOR] data_o = 65 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 215: uvm_test_top.scoreboard [SCOREBOARD] Expected data=75, actual data=76
UVM_INFO packet_monitor.sv(57) @ 215: uvm_test_top.monitor [MONITOR] data_o = 76 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 225: uvm_test_top.scoreboard [SCOREBOARD] Expected data=44, actual data=45
UVM_INFO packet_monitor.sv(57) @ 225: uvm_test_top.monitor [MONITOR] data_o = 45 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 235: uvm_test_top.scoreboard [SCOREBOARD] Expected data=e8, actual data=e9
UVM_INFO packet_monitor.sv(57) @ 235: uvm_test_top.monitor [MONITOR] data_o = e9 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 245: uvm_test_top.scoreboard [SCOREBOARD] Expected data=4e, actual data=4f
UVM_INFO packet_monitor.sv(57) @ 245: uvm_test_top.monitor [MONITOR] data_o = 4f dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 255: uvm_test_top.scoreboard [SCOREBOARD] Expected data=65, actual data=66
UVM_INFO packet_monitor.sv(57) @ 255: uvm_test_top.monitor [MONITOR] data_o = 66 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 265: uvm_test_top.scoreboard [SCOREBOARD] Expected data=c4, actual data=c5
UVM_INFO packet_monitor.sv(57) @ 265: uvm_test_top.monitor [MONITOR] data_o = c5 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 275: uvm_test_top.scoreboard [SCOREBOARD] Expected data=41, actual data=42
UVM_INFO packet_monitor.sv(57) @ 275: uvm_test_top.monitor [MONITOR] data_o = 42 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 285: uvm_test_top.scoreboard [SCOREBOARD] Expected data=66, actual data=67
UVM_INFO packet_monitor.sv(57) @ 285: uvm_test_top.monitor [MONITOR] data_o = 67 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 295: uvm_test_top.scoreboard [SCOREBOARD] Expected data=b7, actual data=b8
UVM_INFO packet_monitor.sv(57) @ 295: uvm_test_top.monitor [MONITOR] data_o = b8 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 305: uvm_test_top.scoreboard [SCOREBOARD] Expected data=ba, actual data=bb
UVM_INFO packet_monitor.sv(57) @ 305: uvm_test_top.monitor [MONITOR] data_o = bb dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 315: uvm_test_top.scoreboard [SCOREBOARD] Expected data=b9, actual data=ba
UVM_INFO packet_monitor.sv(57) @ 315: uvm_test_top.monitor [MONITOR] data_o = ba dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 325: uvm_test_top.scoreboard [SCOREBOARD] Expected data=d9, actual data=da
UVM_INFO packet_monitor.sv(57) @ 325: uvm_test_top.monitor [MONITOR] data_o = da dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 335: uvm_test_top.scoreboard [SCOREBOARD] Expected data=43, actual data=44
UVM_INFO packet_monitor.sv(57) @ 335: uvm_test_top.monitor [MONITOR] data_o = 44 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 345: uvm_test_top.scoreboard [SCOREBOARD] Expected data=36, actual data=37
UVM_INFO packet_monitor.sv(57) @ 345: uvm_test_top.monitor [MONITOR] data_o = 37 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 355: uvm_test_top.scoreboard [SCOREBOARD] Expected data=95, actual data=96
UVM_INFO packet_monitor.sv(57) @ 355: uvm_test_top.monitor [MONITOR] data_o = 96 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 365: uvm_test_top.scoreboard [SCOREBOARD] Expected data=ae, actual data=af
UVM_INFO packet_monitor.sv(57) @ 365: uvm_test_top.monitor [MONITOR] data_o = af dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 375: uvm_test_top.scoreboard [SCOREBOARD] Expected data=0b, actual data=0c
UVM_INFO packet_monitor.sv(57) @ 375: uvm_test_top.monitor [MONITOR] data_o = 0c dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 385: uvm_test_top.scoreboard [SCOREBOARD] Expected data=15, actual data=16
UVM_INFO packet_monitor.sv(57) @ 385: uvm_test_top.monitor [MONITOR] data_o = 16 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 395: uvm_test_top.scoreboard [SCOREBOARD] Expected data=0d, actual data=0e
UVM_INFO packet_monitor.sv(57) @ 395: uvm_test_top.monitor [MONITOR] data_o = 0e dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 405: uvm_test_top.scoreboard [SCOREBOARD] Expected data=17, actual data=18
UVM_INFO packet_monitor.sv(57) @ 405: uvm_test_top.monitor [MONITOR] data_o = 18 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 415: uvm_test_top.scoreboard [SCOREBOARD] Expected data=96, actual data=97
UVM_INFO packet_monitor.sv(57) @ 415: uvm_test_top.monitor [MONITOR] data_o = 97 dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 425: uvm_test_top.scoreboard [SCOREBOARD] Expected data=87, actual data=88
UVM_INFO packet_monitor.sv(57) @ 425: uvm_test_top.monitor [MONITOR] data_o = 88 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 435: uvm_test_top.scoreboard [SCOREBOARD] Expected data=e5, actual data=e6
UVM_INFO packet_monitor.sv(57) @ 435: uvm_test_top.monitor [MONITOR] data_o = e6 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 445: uvm_test_top.scoreboard [SCOREBOARD] Expected data=32, actual data=33
UVM_INFO packet_monitor.sv(57) @ 445: uvm_test_top.monitor [MONITOR] data_o = 33 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 455: uvm_test_top.scoreboard [SCOREBOARD] Expected data=33, actual data=34
UVM_INFO packet_monitor.sv(57) @ 455: uvm_test_top.monitor [MONITOR] data_o = 34 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 465: uvm_test_top.scoreboard [SCOREBOARD] Expected data=16, actual data=17
UVM_INFO packet_monitor.sv(57) @ 465: uvm_test_top.monitor [MONITOR] data_o = 17 dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 475: uvm_test_top.scoreboard [SCOREBOARD] Expected data=bb, actual data=bc
UVM_INFO packet_monitor.sv(57) @ 475: uvm_test_top.monitor [MONITOR] data_o = bc dest_o = 01
UVM_ERROR packet_scoreboard.sv(63) @ 485: uvm_test_top.scoreboard [SCOREBOARD] Expected data=e3, actual data=e4
UVM_INFO packet_monitor.sv(57) @ 485: uvm_test_top.monitor [MONITOR] data_o = e4 dest_o = 10
UVM_ERROR packet_scoreboard.sv(63) @ 495: uvm_test_top.scoreboard [SCOREBOARD] Expected data=cc, actual data=cd
UVM_INFO packet_monitor.sv(57) @ 495: uvm_test_top.monitor [MONITOR] data_o = cd dest_o = 11
UVM_ERROR packet_scoreboard.sv(63) @ 505: uvm_test_top.scoreboard [SCOREBOARD] Expected data=09, actual data=0a
UVM_INFO packet_monitor.sv(57) @ 505: uvm_test_top.monitor [MONITOR] data_o = 0a dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 515: uvm_test_top.scoreboard [SCOREBOARD] Expected data=b0, actual data=b1
UVM_INFO packet_monitor.sv(57) @ 515: uvm_test_top.monitor [MONITOR] data_o = b1 dest_o = 00
UVM_ERROR packet_scoreboard.sv(63) @ 525: uvm_test_top.scoreboard [SCOREBOARD] Expected data=1d, actual data=1e
UVM_INFO packet_monitor.sv(57) @ 525: uvm_test_top.monitor [MONITOR] data_o = 1e dest_o = 00
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_objection.svh(1276) @ 525: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
Total checked: 50
Total passed : 0
Total failed : 50
Total unexpected : 0
Remaining DUT transactions : 0
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 525: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   53
UVM_WARNING :    0
UVM_ERROR :   50
UVM_FATAL :    0
** Report counts by id
[MONITOR]    50
[RNTST]     1
[SCOREBOARD]    50
[TEST_DONE]     1
[UVM/RELNOTES]     1

$finish called from file "/apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_root.svh", line 532.
$finish at simulation time                  525
           V C S   S i m u l a t i o n   R e p o r t 
Time: 525 ns
*/