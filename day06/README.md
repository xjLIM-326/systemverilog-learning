# Day 06 - Sequential Logic and Registers

## Learning Objectives

* Understand clock generation in simulation
* Learn how `always_ff` models sequential logic
* Understand the difference between blocking (`=`) and non-blocking (`<=`) assignments
* Build a simple register using `always_ff`
* Learn how data is sampled on clock edges

---

## Topics Covered

* Clock generation
* `forever`
* `always_ff`
* Blocking assignment (`=`)
* Non-blocking assignment (`<=`)
* Registers
* Pipeline registers

---

## Files

| File                                  | Description                                   |
| ------------------------------------- | --------------------------------------------- |
| `example1_clock_generation.sv`        | Generate a clock using `forever`              |
| `example2_nonblocking_assignment.sv`  | Introduction to registers using `always_ff`   |
| `example3_blocking_vs_nonblocking.sv` | Compare blocking and non-blocking assignments |
| `example4_register.sv`                | Build an 8-bit register                       |
| `challenge.sv`                        | Implement an 8-bit register using `always_ff` |
| `bonus_challenge.sv`                  | Implement a two-stage pipeline register       |

---

## Key Takeaways

* Sequential logic updates only on clock edges.
* `always_ff` is used to model flip-flops and registers.
* Non-blocking assignments (`<=`) update all destination registers simultaneously after evaluating the right-hand side.
* Blocking assignments (`=`) execute immediately and are mainly used in combinational logic.
* Pipeline registers introduce a one-cycle delay between stages.
* In synchronous testbenches, inputs are commonly driven on the opposite clock edge (e.g. `negedge`) to avoid races with DUT sampling.

---

## Reflection

Today I learned the fundamentals of sequential logic. Unlike combinational logic, registers update their outputs only on clock edges. I also learned why non-blocking assignments are required in sequential logic and observed how data propagates through a pipeline one clock cycle at a time. Finally, I understood why professional testbenches often drive inputs on the opposite clock edge to ensure stable timing and avoid race conditions.
