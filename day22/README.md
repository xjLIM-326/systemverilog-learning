# Day 22: Functional Coverage & Coverage-Driven Verification

## Overview

This project focuses on **SystemVerilog Functional Coverage** and how coverage works together with a **scoreboard** to evaluate verification quality.

The testbench verifies a simple packet router DUT and collects functional coverage for:

* Packet type
* Destination
* Packet type × destination combinations

The exercise also demonstrates a practical verification debugging issue involving **simulation scheduling and nonblocking assignments (NBA)**.

---

## Folder Structure

```text
Day22_Functional_Coverage/
├── README.md
│
├── dut/
│   └── packet_router.sv
│
├── eda/
│   ├── design.sv
│   └── testbench.sv
│
└── tb/
    ├── coverage.sv
    ├── interface.sv
    ├── monitor.sv
    ├── scoreboard.sv
    ├── test.sv
    ├── top.sv
    └── transaction.sv
```

---

## DUT Specification

The DUT is a simple packet router.

### Inputs

| Signal         |  Width | Description              |
| -------------- | -----: | ------------------------ |
| `packet_valid` |  1 bit | Indicates a valid packet |
| `packet_type`  | 2 bits | Packet type              |
| `destination`  | 2 bits | Packet destination       |

### Output

| Signal          | Width | Description                              |
| --------------- | ----: | ---------------------------------------- |
| `packet_accept` | 1 bit | Indicates whether the packet is accepted |

### Packet Types

| Value   | Type     |
| ------- | -------- |
| `2'b00` | DATA     |
| `2'b01` | CONTROL  |
| `2'b10` | RESPONSE |
| `2'b11` | RESERVED |

### Destinations

| Value   | Destination |
| ------- | ----------- |
| `2'b00` | CPU         |
| `2'b01` | DMA         |
| `2'b10` | PERIPHERAL  |
| `2'b11` | INVALID     |

The DUT accepts packets when:

```systemverilog
packet_valid && destination != 2'b11
```

Therefore:

| Destination | Expected `packet_accept` |
| ----------- | -----------------------: |
| CPU         |                        1 |
| DMA         |                        1 |
| PERIPHERAL  |                        1 |
| INVALID     |                        0 |

---

## Concepts Learned

### 1. Functional Coverage

Functional coverage measures whether the testbench has exercised the scenarios defined by the verification plan.

This is different from code coverage.

* **Code coverage:** Did the RTL code execute?
* **Functional coverage:** Did the intended functional scenarios occur?

---

### 2. Covergroup

A `covergroup` defines a functional coverage model.

```systemverilog
covergroup packet_cg;

    ...

endgroup
```

The covergroup contains coverage points and crosses.

---

### 3. Coverpoint

A `coverpoint` tracks the values taken by a signal or expression.

Example:

```systemverilog
cp_destination:
    coverpoint vif.destination iff (vif.packet_valid) {
        bins cpu        = {2'b00};
        bins dma        = {2'b01};
        bins peripheral = {2'b10};

        ignore_bins invalid = {2'b11};
    }
```

This allows us to explicitly define which functional scenarios matter.

---

### 4. Bins

Bins divide possible values into functional scenarios.

For example:

```systemverilog
bins cpu = {2'b00};
bins dma = {2'b01};
bins peripheral = {2'b10};
```

Each bin represents a scenario that we want to observe.

---

### 5. `ignore_bins`

`ignore_bins` excludes values from coverage calculations.

For this design:

```systemverilog
ignore_bins invalid = {2'b11};
```

The INVALID destination is intentionally excluded from functional coverage because it is not a legal destination.

---

### 6. `iff`

The `iff` condition controls when a value is sampled.

```systemverilog
coverpoint vif.destination iff (vif.packet_valid)
```

This prevents cycles without a valid packet from contributing to functional coverage.

---

### 7. Cross Coverage

Cross coverage measures combinations between two coverpoints.

```systemverilog
cross cp_packet_type, cp_destination;
```

There are:

```text
3 packet types × 3 legal destinations = 9
```

legal combinations.

Achieving 100% cross coverage means that all nine combinations have occurred.

---

## Scoreboard

The scoreboard calculates the expected DUT behavior and compares it with the actual DUT output.

The expected behavior is:

```systemverilog
expected_accept = (vif.destination != 2'b11);
```

The scoreboard reports either:

```text
PASS
```

or:

```text
MISMATCH
```

---

## Debugging Exercise: Simulation Scheduling

Initially, the scoreboard produced many mismatches even though the DUT logic was correct.

Example:

```text
[MONITOR] valid=1 type=1 dest=1 accept=0
[SCOREBOARD] MISMATCH: type=1 dest=1 expected=1 actual=0
```

The problem was caused by simulation scheduling.

The DUT updates `packet_accept` using a nonblocking assignment:

```systemverilog
packet_accept <= ...;
```

The scoreboard was also checking the signal at the same clock edge:

```systemverilog
@(posedge vif.clk);
```

Therefore, the scoreboard could observe the **previous value** of `packet_accept` before the DUT's NBA update occurred.

A small delay was added:

```systemverilog
@(posedge vif.clk);
#1;
```

This allowed the DUT output to update before the scoreboard performed its comparison.

After the fix, the scoreboard reported PASS for all transactions.

This demonstrated an important DV concept:

> A scoreboard can produce false failures if its sampling point is not aligned with the DUT's timing and simulator scheduling regions.

---

## Deliberate Scoreboard Bug

A separate debugging exercise was performed by intentionally modifying the reference model.

For example, the correct logic:

```systemverilog
expected_accept = (vif.destination != 2'b11);
```

can be deliberately changed to an incorrect condition.

The resulting mismatches demonstrate how a broken reference model can produce verification failures even when the DUT itself is correct.

This is an important verification lesson:

> The scoreboard/reference model is part of the verification environment and can contain bugs too.

---

## Simulation Results

After fixing the scoreboard sampling issue:

```text
======================================
Packet Type Coverage = 100.00%
Destination Coverage = 100.00%
Cross Coverage       = 100.00%
======================================
```

The scoreboard also completed without verification errors.

Therefore, the testbench successfully exercised:

* All three legal packet types
* All three legal destinations
* All nine legal packet type × destination combinations
* Correct DUT acceptance behavior

---

## Important Verification Insight

100% functional coverage does **not** automatically mean that the design is fully verified.

For example, 100% coverage could still occur if:

* The scoreboard is incorrect
* The coverage model is incomplete
* Important corner cases were not defined
* Reset behavior was not covered
* Timing-related scenarios were not tested
* Back-to-back transactions were not tested
* The DUT has bugs outside the covered scenarios

Therefore, verification quality depends on both:

```text
Coverage
    +
Correct checking
    +
Good test scenarios
    +
A correct coverage model
```

---

## Key Takeaways

* Learned how to build functional coverage using `covergroup`
* Learned how to define `coverpoint` and bins
* Learned how to use `ignore_bins`
* Learned how `iff` controls coverage sampling
* Learned how cross coverage measures combinations
* Learned how to read coverage results
* Debugged a scoreboard failure caused by simulation scheduling
* Learned the relationship between NBA updates and testbench sampling
* Demonstrated that coverage and scoreboard checking are complementary
* Learned that 100% coverage does not necessarily mean complete verification

---

## Final Result

```text
Functional Coverage:
    Packet Type       100%
    Destination       100%
    Cross             100%

Scoreboard:
    PASS

Status:
    PASS
```
