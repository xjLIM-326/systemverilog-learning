# Day 07 - Reset in Sequential Logic

## Learning Objectives

* Understand why reset is required in sequential logic
* Learn synchronous reset and asynchronous reset
* Understand reset priority in `always_ff`
* Build registers and counters with reset
* Follow industry-standard RTL coding style

---

## Topics Covered

* Synchronous reset
* Asynchronous reset
* Active-low reset (`rst_n`)
* Reset priority
* Registers with reset
* Counters with reset

---

## Files

| File                             | Description                                      |
| -------------------------------- | ------------------------------------------------ |
| `example1_synchronous_reset.sv`  | Register with synchronous reset                  |
| `example2_asynchronous_reset.sv` | Register with asynchronous reset                 |
| `example3_reset_register.sv`     | 8-bit register with asynchronous reset           |
| `example4_reset_counter.sv`      | 3-bit counter with asynchronous reset            |
| `challenge.sv`                   | Design an 8-bit register with asynchronous reset |
| `bonus_challenge.sv`             | Design a 3-bit counter with asynchronous reset   |

---

## Key Takeaways

* Reset initializes sequential logic to a known state.
* Synchronous reset takes effect only on the active clock edge.
* Asynchronous reset takes effect immediately when asserted.
* Active-low resets are commonly named `rst_n` in ASIC RTL.
* The standard coding style for asynchronous reset is:

  * `always_ff @(posedge clk or negedge rst_n)`
  * `if (!rst_n)` has the highest priority.
* Driving DUT inputs away from the active sampling edge helps avoid race conditions in synchronous testbenches.

---

## Reflection

Today I learned how reset is implemented in sequential logic and why it is essential for deterministic hardware behavior. I compared synchronous and asynchronous reset, observed how asynchronous reset immediately forces registers to a known value, and implemented both a register and a counter using industry-standard RTL coding style. I also learned why active-low reset (`rst_n`) is widely adopted in ASIC designs and how proper reset logic forms the foundation for more complex designs such as finite state machines.
