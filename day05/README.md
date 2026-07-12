# Day 05 - Procedural Blocks and Combinational Logic

## Learning Objectives

* Understand the difference between `initial` and `always` blocks
* Learn how to use `always_comb`
* Implement combinational logic using `if-else`
* Implement combinational logic using `case`
* Get introduced to `always_ff` for sequential logic

---

## Topics Covered

* `initial` block
* `always_comb`
* `always_ff`
* `if-else`
* `case` statement
* Multiplexer (MUX)
* `$monitor`

---

## Files

| File                         | Description                                            |
| ---------------------------- | ------------------------------------------------------ |
| `example1_always_comb.sv`    | Introduction to `always_comb` and `$monitor`           |
| `example2_if_else.sv`        | Implement a 2-to-1 multiplexer using `if-else`         |
| `example3_case_statement.sv` | Implement combinational logic using a `case` statement |
| `example4_always_ff.sv`      | Introduction to `always_ff` and sequential logic       |
| `challenge.sv`               | Build a 2-to-1 multiplexer using `always_comb`         |
| `bonus_challenge.sv`         | Build a 4-to-1 multiplexer using a `case` statement    |

---

## Key Takeaways

* `initial` blocks execute only once at the beginning of simulation.
* `always_comb` automatically reevaluates whenever an input changes, making it suitable for combinational logic.
* `always_ff` is used to model sequential logic such as flip-flops.
* `if-else` statements are commonly synthesized into multiplexers.
* `case` statements provide a clean way to describe multi-way combinational logic.
* `$monitor` automatically prints values whenever one of its arguments changes, making it useful for observing signal transitions during simulation.
* Every output in an `always_comb` block should be assigned on every execution path to avoid unintended latch inference.

---

## Reflection

Today I learned how procedural blocks are used to describe hardware behavior. Unlike `initial`, which executes only once, `always_comb` continuously updates outputs whenever inputs change. I also implemented 2-to-1 and 4-to-1 multiplexers using `if-else` and `case` statements, and learned that these coding styles are commonly synthesized into multiplexers in digital hardware. This marks the transition from learning SystemVerilog syntax to writing RTL-style code.
