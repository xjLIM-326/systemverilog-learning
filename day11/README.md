# Day 11: Learn ready/valid handshakes and temporal assertions

## Topics

* Ready/valid handshake protocol
* `valid` and `ready` signal roles
* Handshake occurs when `valid && ready` is sampled at `posedge clk`
* Registered outputs and nonblocking assignment (`<=`)
* Understanding old values versus NBA-updated values
* SVA temporal implication:

  * `|->` — overlapped implication
  * `|=>` — non-overlapped implication
* `$past()` for checking previous-cycle conditions
* `$stable()` for checking data stability
* `disable iff` for reset handling
* Writing protocol assertions
* Cycle-by-cycle debugging of RTL and assertions
* Understanding assertion sampling versus RTL signal updates

## Directory Structure

```text
day11/
│
├── README.md
│
├── example/
│   │
│   ├── pipeline.sv
│   ├── tb_pipeline.sv
│   └── pipeline_assertions.sv
│
└── challenge/
    │
    ├── handshake.sv
    ├── tb_handshake.sv
    └── handshake_assertions.sv
```

## Example

The example implements a simple registered pipeline and demonstrates how assertions can verify:

* Reset behavior
* Pipeline latency
* Data propagation
* Sequential timing relationships

## Challenge

The challenge implements a consumer using a ready/valid-style interface.

The consumer:

* Receives `valid` and `data` from a producer
* Generates `ready` to indicate whether it can accept data
* Generates `accepted` as a registered observation of a successful acceptance
* Becomes temporarily busy after accepting a transaction

A transaction is accepted when:

```text
valid && ready
```

is true at the relevant clock sampling edge.

## Assertions

The challenge checker verifies protocol behavior such as:

### Acceptance must originate from a handshake

```systemverilog
accepted |-> $past(valid && ready)
```

Because `accepted` is a registered observation, the handshake that caused it occurred in the previous cycle.

### Valid must remain asserted while waiting

```systemverilog
valid && !ready |=> valid
```

A producer must not withdraw `valid` before the consumer accepts the transaction.

### Data must remain stable while waiting

```systemverilog
valid && !ready |=> $stable(data)
```

The producer must not change the data before the transaction is accepted.

## Key Takeaways

### Nonblocking assignments do not immediately update signals inside the same sequential block

For example:

```systemverilog
ready <= 1;

if (ready) begin
    ...
end
```

The `if` statement still sees the old value of `ready`.

The new value is updated later in the NBA region.

### `|->` and `|=>` describe different cycle relationships

```systemverilog
A |-> B
```

requires `B` in the same sampled cycle.

```systemverilog
A |=> B
```

requires `B` in the next sampled cycle.

### Assertions must match signal timing

Before writing an assertion, first determine what each signal means at each clock cycle.

For a registered signal:

```text
Cycle N:
    handshake occurs

After the clock event:
    accepted becomes 1

Cycle N+1:
    SVA samples accepted = 1
```

Therefore, assertions involving `accepted` must account for this timing relationship.

### Debugging must be cycle-based

When debugging sequential RTL and SVA, track:

```text
Cycle
    ↓
Input values
    ↓
Current state
    ↓
Condition evaluated at posedge
    ↓
Nonblocking assignments
    ↓
Updated state
    ↓
Next-cycle assertion sampling
```

This prevents confusion between:

* The value sampled at the clock edge
* The value updated after the edge
* The value observed in the next clock cycle

## Summary

Day 11 introduced temporal reasoning in SystemVerilog.

The key lesson is:

> **Assertions are only correct when their temporal relationship matches the actual cycle-level meaning of the RTL signals.**

Understanding the timing of `valid`, `ready`, `accepted`, nonblocking assignments, and SVA sampling is essential before writing reliable protocol checkers.
