# Day 09 — Self-Checking Testbench

## Overview

This exercise introduces the basic structure of a self-checking testbench.

Instead of manually inspecting waveform outputs, the testbench automatically compares the DUT output against an independently calculated expected result.

The verification flow is:

```text
Stimulus
   │
   ├──────────────► DUT ──────────────► Actual Result
   │
   └──────────────► Reference Model ──► Expected Result
                                             │
                                             ▼
                                          Checker
                                             │
                                        PASS / FAIL
```

---

## Concepts Covered

* Self-checking testbench
* Reference model
* Checker
* `task` with input arguments
* `function automatic` with input/output arguments
* Exhaustive testing
* Randomized testing
* PASS/FAIL statistics
* `$urandom_range()`

---

## Example 1 — Direct Checking

`example1_direct_check.sv`

The expected result is calculated directly inside the testbench and compared with the DUT output.

```text
DUT Output == Expected Output
```

This is the simplest form of a self-checking testbench.

---

## Example 2 — Separate Checker

`example2_checker_module.sv`

The checking logic is separated from the stimulus generation logic.

This introduces the idea that:

```text
Stimulus Generation ≠ Result Checking
```

A checker should focus on determining whether the actual result matches the expected result.

---

## Example 3 — Reference Model

`example3_reference_model.sv`

A reference model independently calculates the expected DUT behavior.

For the priority encoder:

```text
Input Request
      │
      ├──────────────► DUT ──────────────► Actual Grant
      │
      └──────────────► Reference Model ──► Expected Grant
```

The reference model should ideally use a different implementation approach from the DUT.

This reduces the risk of simply reproducing the same design bug in the testbench.

---

## Challenge — Exhaustive Testing

The challenge tests every possible 4-bit request:

```text
2^4 = 16 possible inputs
```

All values from:

```text
0000 → 1111
```

are tested automatically.

The testbench:

1. Generates a stimulus.
2. Calculates the expected result.
3. Waits for the DUT output to settle.
4. Compares the actual result with the expected result.
5. Records PASS or FAIL.

Example output:

```text
========================
TEST SUMMARY
PASS: 16
FAIL: 0
========================
```

---

## Bonus Challenge — Randomized Testing

The bonus challenge generates random requests using:

```systemverilog
$urandom_range(0, 15)
```

Example:

```systemverilog
repeat (20) begin
    req = $urandom_range(0, 15);

    #1;

    calculate_expected(
        req,
        expected_grant,
        expected_valid
    );

    check_result(
        req,
        grant,
        valid,
        expected_grant,
        expected_valid
    );
end
```

Unlike exhaustive testing, random testing:

* May generate duplicate inputs.
* Does not guarantee that every input is tested.
* Can scale better when the input space becomes large.

---

## Key Takeaways

A basic verification environment can be structured as:

```text
Stimulus
    ↓
    DUT
    ↓
Actual Result
    │
    ├──────────────┐
    │              │
    ▼              ▼
Compare ◄──── Expected Result
                 ▲
                 │
           Reference Model
```

The core principle is:

```text
Actual Result == Expected Result
```

A self-checking testbench is more scalable and reliable than manually inspecting waveforms.

The basic structure introduced here is the foundation for more advanced verification components such as:

```text
Generator
    ↓
Driver
    ↓
DUT
    ↓
Monitor
    ↓
Scoreboard
```

The checker and reference model developed in this exercise represent the earliest form of the concepts that later evolve into a scoreboard-based verification environment.
