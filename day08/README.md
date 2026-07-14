# Day 08 - if / case & Basic Testbench

## Learning Objectives

* Understand the difference between `if` and `case`
* Learn how combinational logic is described using `always_comb`
* Implement a 2-to-1 multiplexer using `if`
* Implement a simple ALU using `case`
* Write a basic SystemVerilog testbench
* Instantiate a DUT (Design Under Test)
* Apply stimulus and observe simulation outputs using `$display`

---

## New Syntax

### `if`

Used when making conditional decisions.

```systemverilog
if (condition)
    ...
else
    ...
```

Typical use cases:

* Multiplexers (MUX)
* Priority logic
* Enable signals

---

### `case`

Used when selecting one of multiple choices.

```systemverilog
case (expression)
    ...
    default: ...
endcase
```

Typical use cases:

* ALU operation selection
* Opcode decoding
* Finite State Machines (FSM)

---

## Files

```
Day08/
│
├── README.md
├── example1_mux2.sv
├── tb_example1_mux2.sv
│
├── example2_alu.sv
├── tb_example2_alu.sv
│
├── challenge1_mux3.sv
├── tb_challenge1_mux3.sv
│
└── challenge2_priority_encoder.sv
    tb_challenge2_priority_encoder.sv
```

---

## Examples

### Example 1

* 2-to-1 Multiplexer
* Introduces `if-else`

### Example 2

* Simple ALU
* Introduces `case`

---

## Challenges

### Challenge 1

Implemented a 3-to-1 multiplexer using `case`.

### Challenge 2

Implemented a priority encoder using `if-else if`.

---

## What I Learned

* `if` is commonly used for conditional and priority logic.
* `case` is commonly used when selecting between multiple predefined choices.
* `always_comb` should assign outputs under every possible condition.
* A testbench instantiates the DUT and provides input stimulus.
* `$display` can be used to observe simulation results.
* Simulation is used to verify RTL behavior before hardware implementation.

---

## Reflection

Today was my first time writing SystemVerilog testbenches from scratch. The testbenches are intentionally kept simple, focusing on understanding the basic verification flow:

1. Instantiate the DUT
2. Apply input stimulus
3. Observe outputs
4. Verify the design behaves as expected

More advanced verification techniques such as tasks, loops, assertions, and self-checking testbenches will be introduced in future lessons.
