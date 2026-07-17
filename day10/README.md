# Day 10: FIFO RTL Design and Assertions

## Objective

Design a parameterized synchronous FIFO and verify its boundary behavior using immediate and concurrent assertions.

## Design

The FIFO supports:

* Parameterized `DEPTH`
* Parameterized `WIDTH`
* Write pointer
* Read pointer
* Memory storage
* Occupancy counter
* `full` status
* `empty` status

The FIFO accepts a write only when:

```text
wr_en && !full
```

The FIFO accepts a read only when:

```text
rd_en && !empty
```

When a valid write and valid read occur in the same cycle:

```text
count remains unchanged
```

## Testbench

The testbench verifies:

### 1. Reset

After reset:

* FIFO is empty
* FIFO is not full

### 2. Basic Write and Read

The testbench writes data into the FIFO and verifies that data is returned in FIFO order.

### 3. Full Boundary

The testbench:

1. Fills the FIFO to capacity.
2. Verifies that `full` is asserted.
3. Attempts an additional write.
4. Verifies that the FIFO remains full.

### 4. Empty Boundary

The testbench:

1. Reads all entries from the FIFO.
2. Verifies that `empty` is asserted.
3. Attempts an additional read.
4. Verifies that the FIFO remains empty.

### 5. Simultaneous Read and Write

The testbench verifies that a read and write can occur in the same cycle while maintaining FIFO ordering.

For example:

```text
Before: A → B

Read:  A
Write: C

After: B → C
```

## Assertions

The testbench contains assertions for:

* Write attempts while the FIFO is full
* Read attempts while the FIFO is empty
* `full` and `empty` never being asserted simultaneously
* A write-only operation causing the FIFO to become non-empty

## Key Learning Points

### Sequential State

The FIFO occupancy counter is sequential state and must be updated inside a clocked process.

```text
count
  ↓
always_ff
```

A state variable should not be driven simultaneously by an `always_ff` block and an `always_comb` block.

### FIFO Status

The status signals are derived from the occupancy counter:

```text
count == 0     → empty
count == DEPTH → full
```

### Simulation Timing

Stimulus should be applied before the active clock edge:

```text
negedge
   ↓
apply stimulus
   ↓
posedge
   ↓
DUT samples inputs
   ↓
NBA update
   ↓
check outputs
```

This is especially important when the DUT uses nonblocking assignments such as:

```systemverilog
rdata <= mem[rd_ptr];
```

The testbench must not check `rdata` before the read operation has actually occurred.

### Verification Mindset

A testbench must not only generate legal transactions. It should also deliberately exercise illegal conditions and verify that the design handles them correctly.

Important questions include:

* Can an invalid write overflow the FIFO?
* Can an invalid read underflow the FIFO?
* Does simultaneous read/write preserve the correct count?
* Does the output data maintain FIFO ordering?
* Does the assertion actually observe the intended condition at the intended clock cycle?
