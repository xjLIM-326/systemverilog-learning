# Day 19 — SystemVerilog Assertions (SVA)

## 1. Learning Objectives

- Understand Immediate Assertion and Concurrent Assertion
- Understand `property` and `sequence`
- Understand assertion attempts
- Learn temporal operators:
  - `|->`
  - `|=>`
  - `##N`
- Learn how to disable assertions during reset with `disable iff`
- Apply assertions to handshake and FIFO behavior

---

## 2. Immediate Assertion

Immediate Assertion checks a condition **at the moment the statement is executed**.

### Syntax

```systemverilog
assert (condition)
    pass_action;
else
    fail_action;
```

Example:

```systemverilog
assert (data == expected)
    $display("PASS");
else
    $error("FAIL: data != expected");
```

It is similar to an `if` statement, but explicitly expresses that a condition is expected to be true.

### Key Point

Immediate Assertion:

```text
assert(condition)
        ↓
Check immediately
```

It is mainly used for **procedural / instantaneous checks**.

---

## 3. Concurrent Assertion

Concurrent Assertion is used to check behavior **across clock cycles**.

### Syntax

```systemverilog
assert property (
    @(posedge clk)
    property_expression
);
```

Example:

```systemverilog
property valid_ready_check;

    @(posedge clk)
    valid |-> ##1 ready;

endproperty

assert property (valid_ready_check);
```

This means:

```text
Cycle N:
    valid = 1

Cycle N+1:
    ready must = 1
```

Unlike Immediate Assertion, Concurrent Assertion can describe **temporal relationships** between signals.

---

## 4. Assertion Attempt

For a Concurrent Assertion using:

```systemverilog
@(posedge clk)
```

each `posedge` can start a new assertion attempt.

For example:

```systemverilog
valid |-> ##1 ready
```

At every clock edge:

```text
        posedge
           ↓
      check valid
           ↓
   valid = 1 ?
      /       \
    yes       no
     ↓
start attempt
     ↓
check ready
next cycle
```

An assertion attempt may fail immediately or remain active while waiting for a future cycle.

A simulation message such as:

```text
started at 35ns failed at 45ns
```

means the assertion started at `35ns` and the temporal requirement was checked and failed at `45ns`.

---

## 5. Property

A `property` describes a behavior that should be true.

Example:

```systemverilog
property valid_ready_check;

    @(posedge clk)
    valid |-> ##1 ready;

endproperty
```

The property itself describes the expected behavior.

It can then be checked using:

```systemverilog
assert property (valid_ready_check);
```

Conceptually:

```text
Property
    ↓
Describe expected behavior

Assertion
    ↓
Check the property
```

---

## 6. Sequence

A `sequence` describes a **temporal pattern**.

Example:

```systemverilog
sequence req_then_grant;

    req ##1 grant;

endsequence
```

This means:

```text
Cycle N:
    req = 1

Cycle N+1:
    grant = 1
```

A sequence focuses on **what pattern happens over time**, while a property defines the behavior that should be checked.

Example:

```systemverilog
property req_grant_check;

    @(posedge clk)
    req_then_grant;

endproperty
```

---

# 7. Temporal Operators

## 7.1 `|->` — Overlapped Implication

`|->` means the consequent starts in the **same cycle**.

```systemverilog
req |-> ack;
```

Meaning:

```text
Cycle N:
    req = 1
    ack must = 1
```

So:

```text
req(N) → ack(N)
```

---

## 7.2 `|=>` — Non-overlapped Implication

`|=>` means the consequent starts in the **next cycle**.

```systemverilog
req |=> ack;
```

Meaning:

```text
Cycle N:
    req = 1

Cycle N+1:
    ack must = 1
```

So:

```text
req(N) → ack(N+1)
```

In this simple case:

```systemverilog
req |=> ack;
```

is equivalent to:

```systemverilog
req |-> ##1 ack;
```

---

## 7.3 `##N` — Temporal Delay

`##N` specifies a delay of `N` clock cycles.

```systemverilog
req ##1 ack;
```

means:

```text
Cycle N:
    req

Cycle N+1:
    ack
```

```systemverilog
req ##2 ack;
```

means:

```text
Cycle N:
    req

Cycle N+2:
    ack
```

General rule:

```text
##1 → next cycle
##2 → two cycles later
##N → N cycles later
```

---

## 7.4 Combining Temporal Operators

```systemverilog
valid |-> ##1 ready;
```

means:

> If `valid` is high in the current cycle, `ready` must be high in the next cycle.

Another way to express the same timing relationship is:

```systemverilog
valid |=> ready;
```

Important comparison:

```text
valid |-> ready
    → same cycle

valid |=> ready
    → next cycle

valid |-> ##1 ready
    → next cycle

valid |-> ##2 ready
    → two cycles later
```

---

# 8. `disable iff`

Assertions usually should not run while the DUT is in reset.

For an active-low reset:

```systemverilog
disable iff (!reset_n)
```

Example:

```systemverilog
property valid_ready_check;

    @(posedge clk)
    disable iff (!reset_n)
    valid |=> ready;

endproperty
```

Meaning:

```text
reset_n = 0
    ↓
Assertion disabled

reset_n = 1
    ↓
Assertion active
```

This prevents assertions from reporting meaningless failures while the DUT is being initialized or reset.

---

# 9. Challenge 1 — Immediate Assertion

Check whether `data` matches `expected`.

```systemverilog
assert (data == expected)
    $display("PASS");
else
    $error("FAIL: data != expected");
```

The challenge demonstrated both:

- Assertion PASS
- Assertion FAIL

---

# 10. Challenge 2 — Concurrent Assertion

Requirement:

> If `valid` is asserted in the current cycle, `ready` must be asserted one cycle later.

Property:

```systemverilog
property valid_ready_check;

    @(posedge clk)
    valid |-> ##1 ready;

endproperty
```

The challenge intentionally included a failing case to verify that the assertion correctly detects incorrect timing.

---

# 11. Challenge 3 — FIFO Assertions

The FIFO challenge checks several basic FIFO rules.

### Full FIFO

A write should not be attempted when FIFO is full:

```systemverilog
property full_write_check;

    @(posedge clk)
    full |-> !wr_en;

endproperty
```

### Empty FIFO

A read should not be attempted when FIFO is empty:

```systemverilog
property empty_read_check;

    @(posedge clk)
    empty |-> !rd_en;

endproperty
```

### Full and Empty

FIFO should never be full and empty simultaneously:

```systemverilog
property full_empty_check;

    @(posedge clk)
    !(full && empty);

endproperty
```

---

## 12. FIFO Count Update — Important Note

When both a valid write and a valid read happen in the same cycle:

```text
write + read
    ↓
FIFO depth does not change
```

Therefore, the logic should explicitly handle the simultaneous case:

```systemverilog
if ((wr_en && !full) && (rd_en && !empty))
    count <= count;
else if (wr_en && !full)
    count <= count + 1;
else if (rd_en && !empty)
    count <= count - 1;
```

Using two independent `if` statements that both assign to `count` can cause multiple nonblocking assignments to the same variable in the same clock cycle.

---

# 13. Key Takeaways

### Immediate vs Concurrent Assertion

```text
Immediate Assertion
    ↓
Check now

Concurrent Assertion
    ↓
Check behavior over clock cycles
```

### Property vs Sequence

```text
Sequence
    ↓
Describe a temporal pattern

Property
    ↓
Describe expected behavior

Assertion
    ↓
Check the property
```

### Temporal Operators

```text
|->  → same cycle
|=>  → next cycle
##N  → N cycles later
```

### Reset

```text
disable iff (!reset_n)
    ↓
Disable assertion during active-low reset
```

The most important mindset from Day 19 is:

> SVA allows the verification engineer to turn a design specification into an executable check that continuously monitors DUT behavior.
