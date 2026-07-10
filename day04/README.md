# Day 04 - Indexing, Part-select, and Concatenation

## Learning Objectives

* Understand how to access individual bits using indexing
* Learn how to extract a range of bits using part-select
* Learn how to combine multiple signals using concatenation
* Understand how replication works in SystemVerilog

---

## Topics Covered

* Indexing
* Part-select
* Concatenation
* Replication
* Packet field extraction
* Packet reconstruction

---

## Files

| File                        | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| `example1_indexing.sv`      | Access individual bits from a vector using indexing   |
| `example2_part_select.sv`   | Extract specific bit ranges using part-select         |
| `example3_concatenation.sv` | Combine multiple vectors into a larger vector         |
| `example4_replication.sv`   | Generate repeated bit patterns using replication      |
| `challenge.sv`              | Extract packet fields and rebuild the original packet |
| `bonus_challenge.sv`        | Construct a packet header using concatenation         |

---

## Key Takeaways

* Individual bits can be accessed using indexing (e.g. `data[0]` or `data[7]`).
* Part-select extracts a range of bits from a vector (e.g. `data[15:8]`).
* Concatenation (`{}`) combines multiple signals into a larger vector.
* In concatenation, the leftmost element becomes the most significant bits (MSBs), while the rightmost element becomes the least significant bits (LSBs).
* Replication (`{N{...}}`) repeats a value or bit pattern multiple times.
* Indexing, part-select, and concatenation are widely used for packet parsing, instruction decoding, and protocol implementation.

---

## Reflection

Today I learned how to manipulate vectors by accessing individual bits, extracting bit fields, and combining multiple signals into a larger vector. I also learned that the order of signals in a concatenation is important because it determines the final bit arrangement. These operations are fundamental in digital design and are commonly used to build and decode packets, instructions, and communication protocols.
