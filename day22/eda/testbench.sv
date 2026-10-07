`include "transaction.sv"
`include "monitor.sv"
`include "coverage.sv"
`include "scoreboard.sv"
`include "test.sv"
`include "top.sv"

/*Output
Contains Synopsys proprietary information.
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Oct  7 11:04 2026
[MONITOR] valid=1 type=1 dest=1 accept=0
[SCOREBOARD] PASS: type=1 dest=1 accept=1
[MONITOR] valid=1 type=0 dest=0 accept=1
[SCOREBOARD] PASS: type=0 dest=0 accept=1
[MONITOR] valid=1 type=2 dest=1 accept=0
[SCOREBOARD] PASS: type=2 dest=1 accept=1
[MONITOR] valid=1 type=1 dest=3 accept=0
[SCOREBOARD] PASS: type=1 dest=3 accept=0
[MONITOR] valid=1 type=1 dest=3 accept=0
[SCOREBOARD] PASS: type=1 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=2 accept=0
[SCOREBOARD] PASS: type=2 dest=2 accept=1
[MONITOR] valid=1 type=1 dest=3 accept=0
[SCOREBOARD] PASS: type=1 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=0 dest=0 accept=0
[SCOREBOARD] PASS: type=0 dest=0 accept=1
[MONITOR] valid=1 type=3 dest=2 accept=1
[SCOREBOARD] PASS: type=3 dest=2 accept=1
[MONITOR] valid=1 type=3 dest=3 accept=0
[SCOREBOARD] PASS: type=3 dest=3 accept=0
[MONITOR] valid=1 type=0 dest=1 accept=0
[SCOREBOARD] PASS: type=0 dest=1 accept=1
[MONITOR] valid=1 type=2 dest=2 accept=0
[SCOREBOARD] PASS: type=2 dest=2 accept=1
[MONITOR] valid=1 type=3 dest=0 accept=0
[SCOREBOARD] PASS: type=3 dest=0 accept=1
[MONITOR] valid=1 type=1 dest=0 accept=1
[SCOREBOARD] PASS: type=1 dest=0 accept=1
[MONITOR] valid=1 type=3 dest=1 accept=1
[SCOREBOARD] PASS: type=3 dest=1 accept=1
[MONITOR] valid=1 type=3 dest=1 accept=1
[SCOREBOARD] PASS: type=3 dest=1 accept=1
[MONITOR] valid=1 type=3 dest=3 accept=1
[SCOREBOARD] PASS: type=3 dest=3 accept=0
[MONITOR] valid=1 type=1 dest=3 accept=0
[SCOREBOARD] PASS: type=1 dest=3 accept=0
[MONITOR] valid=1 type=3 dest=0 accept=0
[SCOREBOARD] PASS: type=3 dest=0 accept=1
[MONITOR] valid=1 type=0 dest=2 accept=0
[SCOREBOARD] PASS: type=0 dest=2 accept=1
[MONITOR] valid=1 type=3 dest=3 accept=0
[SCOREBOARD] PASS: type=3 dest=3 accept=0
[MONITOR] valid=1 type=0 dest=3 accept=0
[SCOREBOARD] PASS: type=0 dest=3 accept=0
[MONITOR] valid=1 type=1 dest=0 accept=0
[SCOREBOARD] PASS: type=1 dest=0 accept=1
[MONITOR] valid=1 type=0 dest=3 accept=1
[SCOREBOARD] PASS: type=0 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=0 accept=0
[SCOREBOARD] PASS: type=2 dest=0 accept=1
[MONITOR] valid=1 type=2 dest=0 accept=0
[SCOREBOARD] PASS: type=2 dest=0 accept=1
[MONITOR] valid=1 type=0 dest=1 accept=0
[SCOREBOARD] PASS: type=0 dest=1 accept=1
[MONITOR] valid=1 type=3 dest=3 accept=1
[SCOREBOARD] PASS: type=3 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=2 accept=0
[SCOREBOARD] PASS: type=2 dest=2 accept=1
[MONITOR] valid=1 type=1 dest=2 accept=1
[SCOREBOARD] PASS: type=1 dest=2 accept=1
[MONITOR] valid=1 type=2 dest=1 accept=1
[SCOREBOARD] PASS: type=2 dest=1 accept=1
[MONITOR] valid=1 type=2 dest=2 accept=1
[SCOREBOARD] PASS: type=2 dest=2 accept=1
[MONITOR] valid=1 type=2 dest=3 accept=1
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=2 dest=0 accept=0
[SCOREBOARD] PASS: type=2 dest=0 accept=1
[MONITOR] valid=1 type=3 dest=1 accept=1
[SCOREBOARD] PASS: type=3 dest=1 accept=1
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=1 dest=0 accept=0
[SCOREBOARD] PASS: type=1 dest=0 accept=1
[MONITOR] valid=1 type=2 dest=0 accept=0
[SCOREBOARD] PASS: type=2 dest=0 accept=1
[MONITOR] valid=1 type=0 dest=0 accept=1
[SCOREBOARD] PASS: type=0 dest=0 accept=1
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=0 dest=1 accept=0
[SCOREBOARD] PASS: type=0 dest=1 accept=1
[MONITOR] valid=1 type=2 dest=3 accept=1
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=0 dest=1 accept=0
[SCOREBOARD] PASS: type=0 dest=1 accept=1
[MONITOR] valid=1 type=2 dest=3 accept=0
[SCOREBOARD] PASS: type=2 dest=3 accept=0
[MONITOR] valid=1 type=3 dest=0 accept=0
[SCOREBOARD] PASS: type=3 dest=0 accept=1
[MONITOR] valid=1 type=3 dest=0 accept=1
[SCOREBOARD] PASS: type=3 dest=0 accept=1
======================================
Packet Type Coverage = 100.00%
Destination Coverage = 100.00%
Cross Coverage       = 100.00%
======================================
$finish called from file "test.sv", line 69.
$finish at simulation time                 1040
           V C S   S i m u l a t i o n   R e p o r t 
Time: 1040 ns
*/