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
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Oct  8 09:01 2026
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
UVM_INFO packet_monitor.sv(43) @ 35: uvm_test_top.monitor [MONITOR] data_o = 00 dest_o = 11
UVM_INFO packet_monitor.sv(43) @ 45: uvm_test_top.monitor [MONITOR] data_o = ff dest_o = 01
UVM_INFO packet_monitor.sv(43) @ 55: uvm_test_top.monitor [MONITOR] data_o = 9b dest_o = 11
UVM_INFO packet_monitor.sv(43) @ 65: uvm_test_top.monitor [MONITOR] data_o = 25 dest_o = 01
UVM_INFO packet_monitor.sv(43) @ 75: uvm_test_top.monitor [MONITOR] data_o = 36 dest_o = 11
UVM_INFO packet_monitor.sv(43) @ 85: uvm_test_top.monitor [MONITOR] data_o = 4c dest_o = 10
UVM_INFO packet_monitor.sv(43) @ 95: uvm_test_top.monitor [MONITOR] data_o = f6 dest_o = 01
UVM_INFO packet_monitor.sv(43) @ 105: uvm_test_top.monitor [MONITOR] data_o = ad dest_o = 01
UVM_INFO packet_monitor.sv(43) @ 115: uvm_test_top.monitor [MONITOR] data_o = d3 dest_o = 10
UVM_INFO packet_monitor.sv(43) @ 125: uvm_test_top.monitor [MONITOR] data_o = 13 dest_o = 10
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_objection.svh(1276) @ 125: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
UVM_INFO /apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 125: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   13
UVM_WARNING :    0
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[MONITOR]    10
[RNTST]     1
[TEST_DONE]     1
[UVM/RELNOTES]     1

$finish called from file "/apps/vcsmx/vcs/X-2025.06-SP1//etc/uvm-1.2/src/base/uvm_root.svh", line 532.
$finish at simulation time                  125
           V C S   S i m u l a t i o n   R e p o r t 
Time: 125 ns
*/