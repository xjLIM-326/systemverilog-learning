# Day 13 - Constrained Random Verification

Today you'll learn one of the most important features in SystemVerilog verification:
Constrained Random Verification.

Topics covered:

1. Class-based random objects
2. rand variables
3. randomize()
4. Constraint blocks
5. inline constraints (randomize() with {})
6. Randomization failure handling
7. pre_randomize() / post_randomize()

Examples:
- Basic randomization
- Applying constraints
- Using inline constraints
- Handling impossible constraints
- Callback functions before/after randomization

Challenge:
Build a constrained-random packet generator by extending the provided Packet class.

Requirements:
- Add a packet length field with valid range constraints.
- Apply conditional constraints based on packet type.
- Generate error packets with weighted randomization.
- Automatically calculate parity after randomization.
- Use an inline constraint to generate only large packets.