# Day 02 - SystemVerilog Data Types

## Learning Objectives

* Understand the difference between `logic` and `bit`
* Learn how to declare and initialize common SystemVerilog data types
* Practice displaying values using different format specifiers
* Observe the behavior of 2-state and 4-state data types

---

## Topics Covered

* `logic`
* `bit`
* `logic [7:0]` (vector)
* `int`
* `string`
* Display format specifiers:

  * `%b` (Binary)
  * `%0d` (Decimal)
  * `%h` (Hexadecimal)
  * `%s` (String)

---

## Files

| File                        | Description                                                             |
| --------------------------- | ----------------------------------------------------------------------- |
| `example1_logic.sv`         | Basic usage of the `logic` data type                                    |
| `example2_logic_vector.sv`  | Logic vector declaration and hexadecimal assignment                     |
| `example3_number_format.sv` | Display values in binary, decimal, and hexadecimal                      |
| `example4_bit_vs_logic.sv`  | Compare `bit` (2-state) and `logic` (4-state)                           |
| `challenge.sv`              | Student information exercise                                            |
| `bonus_challenge.sv`        | Compare the behavior of `bit` and `logic` with `0`, `1`, `'x`, and `'z` |

---

## Key Takeaways

* `logic` is a 4-state data type and supports `0`, `1`, `x`, and `z`.
* `bit` is a 2-state data type and supports only `0` and `1`.
* Assigning `x` or `z` to a `bit` does not preserve the unknown/high-impedance value.
* `%b`, `%0d`, `%h`, and `%s` are commonly used to display variables in different formats.
* `logic` is generally preferred for RTL and verification signals because it can represent unknown and high-impedance states.

---

## Reflection

Today I learned why SystemVerilog introduces both `logic` and `bit` instead of using a single data type. Although they look similar, they behave differently when handling unknown (`x`) and high-impedance (`z`) values. This distinction is important in digital design and verification because unknown states often indicate initialization issues or design bugs.

I also became familiar with common display format specifiers, which will be useful for debugging in future verification projects.
