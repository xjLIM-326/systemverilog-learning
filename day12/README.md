# Day 12 - Functional Coverage

## Objective

In this lesson, we learned the fundamentals of **SystemVerilog Functional Coverage**, which is used to measure how thoroughly a design has been exercised during simulation.

Unlike Assertions, which verify whether the design behaves correctly, Functional Coverage tells us whether our testbench has explored all intended scenarios.

---

## Topics Covered

### 1. Functional Coverage

* Purpose of Functional Coverage
* Difference between Code Coverage and Functional Coverage
* Coverage-Driven Verification concept

### 2. Covergroup

* Creating a covergroup
* Event-based sampling
* Instantiating a covergroup using `new()`

### 3. Coverpoint

* Monitoring signal values
* Automatic bin creation
* Custom coverpoints

### 4. Bins

* Individual bins
* Range bins
* Grouping values into meaningful categories

### 5. Illegal Bins

* Detecting values that should never occur
* Understanding simulator error messages when illegal bins are hit

### 6. Cross Coverage

* Measuring combinations of multiple coverpoints
* Understanding why cross coverage provides better verification confidence

### 7. Coverage Report

* Using `get_coverage()` to check Functional Coverage percentage
* Understanding why simulation passing does not necessarily mean sufficient coverage

---

## Example

The example demonstrated how to:

* Create a covergroup
* Monitor `opcode`
* Group multiple values into bins
* Define illegal bins
* Create cross coverage between `opcode` and `mode`
* Display Functional Coverage at the end of simulation

---

## Challenge

Implemented a Functional Coverage module for a packet monitor.

Coverage requirements included:

* Packet type coverage
* Packet size coverage
* Error signal coverage
* Cross coverage between packet type and packet size
* Illegal packet type detection

---

## Key Takeaways

* Assertions verify **correctness**.
* Functional Coverage measures **completeness**.
* Passing simulation does **not** guarantee sufficient verification.
* Cross Coverage is often more valuable than observing individual signals alone.
* Illegal bins help detect unexpected scenarios defined by the specification.

---

## Files

```text
day12/
│
├── README.md
│
├── example/
│   ├── alu.sv
│   ├── tb_alu.sv
│   └── alu_coverage.sv
│
└── challenge/
    ├── packet_monitor.sv
    ├── tb_packet_monitor.sv
    └── packet_coverage.sv
```
