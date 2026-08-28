# Day 20 — SystemVerilog Assertions: Sequence & Property

## 1. Sequence

A `sequence` describes a temporal pattern across clock cycles.

```systemverilog
sequence ack_next_cycle;
    ##1 ack;
endsequence
```

This means:

```text
Current cycle
     │
     └────── +1 cycle ──────> ack
```

A sequence describes **what should happen over time**, but it does not determine when the checking starts.

---

## 2. Property

A `property` defines a condition that must hold over time.

```systemverilog
property req_ack_property;
    @(posedge clk)
    disable iff (!reset_n)
    req |-> ack_next_cycle;
endproperty
```

Conceptually:

```text
                 Property
                    │
          ┌─────────┴─────────┐
          │                   │
       Trigger            Requirement
          │                   │
         req             ack_next_cycle
```

The property connects a trigger to a temporal requirement.

---

## 3. Assertion

A property becomes an actual check when used with `assert property`.

```systemverilog
assert_req_ack:
    assert property (req_ack_property)
    else $error("REQ was not followed by ACK");
```

The basic structure is:

```text
Sequence
   ↓
Property
   ↓
Assertion
   ↓
PASS / FAIL
```

---

# 4. Implication Operator

SVA uses implication to describe:

> If the antecedent occurs, the consequent must satisfy the specified behavior.

There are two main implication operators:

```systemverilog
|->    // overlapped implication
|=>    // non-overlapped implication
```

---

## 4.1 Overlapped Implication `|->`

```systemverilog
req |-> ack
```

The RHS starts in the **same sampling cycle**.

```text
Cycle:   N
         │
req ─────┤ 1
ack ─────┤ 1
```

Therefore:

```systemverilog
req |-> ack
```

means:

> When `req` is true, `ack` must also be true in the same cycle.

---

## 4.2 Non-overlapped Implication `|=>`

```systemverilog
req |=> ack
```

The RHS starts in the **next sampling cycle**.

```text
Cycle:   N        N+1
         │          │
req ─────┤ 1        │
ack ─────┤          ├─ 1
```

Therefore:

> When `req` is true, `ack` must be true in the next cycle.

---

## 4.3 Comparing `|->` and `|=>`

```systemverilog
req |-> ack
```

means:

```text
REQ ──> ACK
same cycle
```

while:

```systemverilog
req |=> ack
```

means:

```text
REQ ──> ACK
          next cycle
```

A useful mental model:

```text
|->   → start checking RHS now

|=>   → start checking RHS next cycle
```

---

# 5. Temporal Delay `##`

`##` specifies a delay in clock cycles.

```systemverilog
##1 ack
```

means:

> `ack` must occur one cycle later.

```text
Current       Next
   │            │
   └────────────┴──> ack
```

Similarly:

```systemverilog
##2 ack
```

means:

> `ack` must occur two cycles later.

---

# 6. Temporal Range `##[min:max]`

A range allows an event to occur within a range of cycles.

```systemverilog
##[1:2] ack
```

means:

> `ack` must occur one or two cycles later.

Valid:

```text
REQ
 │
 ├──── +1 ────> ACK
 │
 └──── +2 ────> ACK
```

Invalid:

```text
REQ
 │
 └──── +3 ────> ACK
```

A range is useful when a protocol allows variable latency.

For example:

```systemverilog
property req_ack;
    @(posedge clk)
    req |-> ##[1:2] ack;
endproperty
```

This means:

> Every sampled `req` must be followed by an `ack` within 1–2 cycles.

---

# 7. Sequence with a Temporal Range

A sequence can be used to make a temporal requirement easier to read.

```systemverilog
sequence ack_after_one_to_two_cycles;
    ##[1:2] ack;
endsequence
```

Then:

```systemverilog
property req_ack_property;
    @(posedge clk)
    req |-> ack_after_one_to_two_cycles;
endproperty
```

This is equivalent in intent to:

```systemverilog
property req_ack_property;
    @(posedge clk)
    req |-> ##[1:2] ack;
endproperty
```

Using a named sequence becomes useful when the same temporal behavior is reused by multiple properties.

---

# 8. Multiple Assertion Attempts

Assertions are evaluated at every sampling clock.

Consider:

```systemverilog
req |-> ##1 ack;
```

If `req` remains high:

```text
Cycle:  0  1  2  3
REQ:    1  1  1  1
```

each sampled `req` can create an independent assertion attempt:

```text
Cycle 0 → Attempt A
Cycle 1 → Attempt B
Cycle 2 → Attempt C
Cycle 3 → Attempt D
```

Therefore, a continuously asserted signal can create multiple outstanding obligations.

This is important when interpreting assertion failures.

An assertion failure on a later cycle does not necessarily mean that only one request was being checked.

---

# 9. Checking Pulse Behavior

A one-cycle pulse can be described as:

```text
Cycle:  N   N+1
REQ:    1    0
```

The temporal requirement is:

```systemverilog
##1 !req
```

For example:

```systemverilog
sequence req_fall_next_cycle;
    ##1 !req;
endsequence

property req_pulse_property;
    @(posedge clk)
    req |-> req_fall_next_cycle;
endproperty
```

This means:

> Whenever `req` is sampled high, `req` must be low in the next cycle.

Therefore:

```text
0 1 0 0 1 0
```

satisfies the pulse requirement.

But:

```text
0 1 1 0
```

does not.

---

# 10. `$past()`

`$past()` is used to access a signal's value from a previous sampled clock.

```systemverilog
$past(req)
```

means:

> `req` from one sampled clock cycle ago.

```systemverilog
$past(req, 2)
```

means:

> `req` from two sampled clock cycles ago.

Conceptually:

```text
Cycle:      N-2     N-1      N
             │       │        │
             │       │       ACK
             │       │
             └───────┘
                 ↑
             $past(req,2)
```

---

# 11. `$past()` vs `##`

These operators describe temporal relationships in opposite directions.

### `##`

Describes something in the future:

```systemverilog
req |-> ##1 ack;
```

```text
REQ ───────────> ACK
       future
```

### `$past()`

Looks into the past:

```systemverilog
ack |-> $past(req);
```

```text
REQ ───────────> ACK
       past
```

Mental model:

```text
##        → look forward in time

$past()   → look backward in time
```

---

# 12. Checking ACK Has a Recent REQ

Suppose the protocol allows:

```text
REQ → ACK
     +1 or +2 cycles
```

The reverse-side condition can be checked with:

```systemverilog
property valid_ack_property;
    @(posedge clk)
    disable iff (!reset_n)
    ack |-> ($past(req) || $past(req, 2));
endproperty
```

This means:

> If `ack` occurs, `req` must have been high one or two sampled cycles earlier.

Example:

```text
Cycle:   N    N+1    N+2
REQ:      1    0      0
ACK:      0    0      1
```

At cycle `N+2`:

```systemverilog
$past(req, 2)
```

is true.

Therefore the property passes.

---

# 13. `disable iff`

Assertions are often disabled during reset.

```systemverilog
disable iff (!reset_n)
```

For example:

```systemverilog
property req_ack_property;
    @(posedge clk)
    disable iff (!reset_n)
    req |-> ##[1:2] ack;
endproperty
```

When:

```systemverilog
reset_n == 0
```

the assertion is disabled.

This prevents normal reset activity from being interpreted as protocol violations.

A common structure is:

```systemverilog
@(posedge clk)
disable iff (!reset_n)
    <property>
```

---

# 14. Forward and Reverse Protocol Checking

A request/acknowledge protocol can be checked from both directions.

### Forward direction

```systemverilog
req |-> ##[1:2] ack
```

Meaning:

> Every REQ must eventually receive an ACK within 1–2 cycles.

```text
REQ ───────────────> ACK
       1~2 cycles
```

### Reverse direction

```systemverilog
ack |-> ($past(req) || $past(req, 2))
```

Meaning:

> Every ACK must have a recent REQ.

```text
REQ ───────────────> ACK
       1~2 cycles
```

Using both directions provides stronger protocol checking than checking only one direction.

---

# 15. Important Distinction: Recent REQ vs One-to-One Matching

A property such as:

```systemverilog
ack |-> ($past(req) || $past(req, 2))
```

checks that an ACK has a recent REQ.

It does **not necessarily guarantee exact one-to-one transaction matching**.

For example:

```text
Cycle:  0  1  2  3
REQ:    1  0  0  0
ACK:    0  1  1  0
```

The second ACK may still see the earlier REQ within the lookback window.

Therefore:

```text
"ACK has a recent REQ"
```

and:

```text
"Every ACK corresponds to exactly one unique REQ"
```

are different verification requirements.

Strict one-to-one matching may require additional temporal constraints or stateful checking.

---

# 16. Overall SVA Structure

A useful mental model for writing SVA is:

```text
                   SVA
                    │
          ┌─────────┴─────────┐
          │                   │
       Sequence            Property
          │                   │
   temporal behavior      trigger + rule
                              │
                              ▼
                         Assertion
                              │
                              ▼
                         PASS / FAIL
```

For temporal direction:

```text
                  Time →
    
$past()       ←─── Current ───→       ##


Past                                  Future
```

---

# 17. Key Syntax Summary

| Syntax                     | Meaning                                  |                            |
| -------------------------- | ---------------------------------------- | -------------------------- |
| `sequence ... endsequence` | Defines a temporal sequence              |                            |
| `property ... endproperty` | Defines a temporal property              |                            |
| `assert property (...)`    | Checks a property                        |                            |
| `                          | ->`                                      | Overlapped implication     |
| `                          | =>`                                      | Non-overlapped implication |
| `##1`                      | One-cycle delay                          |                            |
| `##2`                      | Two-cycle delay                          |                            |
| `##[1:2]`                  | One-to-two-cycle temporal range          |                            |
| `$past(sig)`               | Previous sampled value                   |                            |
| `$past(sig, 2)`            | Value two sampled cycles ago             |                            |
| `disable iff (...)`        | Disable assertion when condition is true |                            |

---

# 18. Key Takeaways

The most important concepts from Day 20 are:

1. **Sequence describes temporal behavior.**
2. **Property connects a trigger to a temporal requirement.**
3. **`|->` starts the RHS in the current cycle.**
4. **`|=>` starts the RHS in the next cycle.**
5. **`##` describes future temporal delays.**
6. **`##[1:2]` describes a variable temporal window.**
7. **Every sampled antecedent can create an independent assertion attempt.**
8. **`$past()` allows checking previous sampled values.**
9. **`disable iff` is commonly used to disable assertions during reset.**
10. **Forward and reverse assertions can be combined to verify protocol behavior more completely.**

The key mental model is:

```text
##       → future
$past()  → past

|->      → RHS starts now
|=>      → RHS starts next cycle
```
