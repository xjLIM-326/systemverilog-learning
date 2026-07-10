# Day 03 - Vectors and Bitwise Operators

## Learning Objectives

* Understand how vectors are declared and represented in SystemVerilog
* Learn how to perform bitwise operations
* Understand the behavior of shift operators
* Recognize the difference between signed and unsigned vectors

---

## Topics Covered

* Vector declaration
* Binary, decimal, and hexadecimal representation
* Bitwise operators

  * `&` (AND)
  * `|` (OR)
  * `^` (XOR)
  * `~` (NOT)
* Shift operators

  * `<<` (Left Shift)
  * `>>` (Right Shift)
* Introduction to signed and unsigned vectors

---

## Files

| File                             | Description                                                              |
| -------------------------------- | ------------------------------------------------------------------------ |
| `example1_vector_declaration.sv` | Basic vector declaration and value assignment                            |
| `example2_bitwise_operators.sv`  | Demonstrate common bitwise operations                                    |
| `example3_shift_operators.sv`    | Explore left and right shift operators                                   |
| `example4_signed_vs_unsigned.sv` | Introduction to signed and unsigned vectors                              |
| `challenge.sv`                   | Practice vector operations and display results in binary and hexadecimal |
| `bonus_challenge.sv`             | Implement a simple ALU using arithmetic and bitwise operators            |

---

## Key Takeaways

* A vector represents multiple bits as a single signal.
* Bitwise operators perform operations on each individual bit.
* Left shift (`<<`) moves bits to the left and fills the least significant bits with zeros.
* Right shift (`>>`) moves bits to the right and fills the most significant bits with zeros for unsigned vectors.
* Shift operations do not automatically increase the width of an expression. Overflow bits may be discarded if the destination width is not explicitly extended.
* Signed and unsigned vectors can produce different results during arithmetic operations.

---

## Reflection

Today I learned how vectors are manipulated using bitwise and shift operators. I also discovered that vector width is an important concept in digital design because overflow bits can be truncated during shift operations. Understanding fixed-width data is essential when writing RTL or verification code, as incorrect assumptions about expression width may lead to subtle bugs.

Bitwise operations are fundamental building blocks in digital circuits, and they are commonly used in ALUs, address calculations, masking operations, and protocol implementations.
