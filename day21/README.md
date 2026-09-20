# Day 21: Advanced SVA — `until`, `until_with`, and `throughout`

## 1. Advanced Temporal Operators

SystemVerilog Assertions provide temporal operators for describing how signals behave across multiple clock cycles.

The main operators covered today are:

- `until`
- `until_with`
- `throughout`

These are useful when a condition must remain true for a period of time rather than at only one specific cycle.

---

## 2. `until`

Basic syntax:

```systemverilog
A until B
```

Meaning:

> `A` must remain true until `B` becomes true.

The cycle where `B` becomes true is not required to satisfy `A`.

Example:

```systemverilog
busy until done
```

Conceptually:

```text
cycle:  1  2  3  4
busy:   1  1  0  0
done:   0  0  1  0
```

At cycle 3, `done` becomes true, so `busy` does not need to remain true at that endpoint.

---

## 3. `until_with`

Basic syntax:

```systemverilog
A until_with B
```

Meaning:

> `A` must remain true until `B` becomes true, and the endpoint where `B` is true is included.

Example:

```systemverilog
busy until_with done
```

Conceptually, this expresses that `busy` must remain asserted through the completion point.

This makes `until_with` useful for protocols such as:

```text
busy
  |
  |--------------------|
                       done
```

The distinction between `until` and `until_with` is mainly about whether the terminating cycle is included in the requirement.

---

## 4. `throughout`

Basic syntax:

```systemverilog
A throughout B
```

Meaning:

> `A` must remain true throughout the entire duration of sequence `B`.

For example:

```systemverilog
busy throughout transaction
```

This is useful when a condition must continuously hold while another temporal sequence is occurring.

`throughout` is especially useful for expressing "this condition must never drop during this entire operation" type requirements.

---

## 5. `|->` vs `|=>`

These operators determine when the consequent starts.

### Overlapped implication

```systemverilog
A |-> B
```

The consequent starts in the same clock cycle.

Example:

```systemverilog
grant |-> busy
```

Means:

> Whenever `grant` is asserted, `busy` must also be asserted in the same sampled cycle.

### Non-overlapped implication

```systemverilog
A |=> B
```

The consequent starts in the next clock cycle.

Example:

```systemverilog
done |=> !busy
```

Means:

> If `done` is asserted, `busy` must be deasserted in the next sampled cycle.

---

## 6. Default Clocking

A clock can be specified once using `default clocking`:

```systemverilog
default clocking cb @(posedge clk);
endclocking
```

Properties without an explicit clocking event then use this clock.

For example:

```systemverilog
property req_then_grant;
    req |-> ##[1:2] grant;
endproperty
```

is equivalent to explicitly writing the clocking event:

```systemverilog
property req_then_grant;
    @(posedge clk)
    req |-> ##[1:2] grant;
endproperty
```

Using `default clocking` avoids repeatedly specifying the same clock.

---

## 7. Assertion Threads

A concurrent assertion can create multiple active evaluation threads.

For example:

```systemverilog
property busy_until_done;
    busy |-> busy until_with done;
endproperty
```

If `busy` is true for several consecutive cycles, a new evaluation can start on each sampled cycle.

For example:

```text
cycle:  1  2  3
busy:   1  1  0
```

There can be multiple active attempts:

```text
Thread 1: 1 → 2 → 3 → FAIL
Thread 2:    2 → 3 → FAIL
```

Therefore, a single protocol violation can produce multiple assertion failures.

This is expected SVA behavior and does not necessarily mean the same assertion was evaluated twice incorrectly.

---

## 8. Protocol Verification Example

The Day 21 example uses a simple Request/Grant/Busy/Done protocol.

Signals:

- `req` — requester asks for a transaction
- `grant` — request is accepted
- `busy` — transaction is active
- `done` — transaction has completed

The main protocol requirements are:

1. Every `req` must be followed by `grant` within 1–2 cycles.
2. `grant` must imply `busy` in the same cycle.
3. `busy` must remain asserted until `done`.
4. `req` must not be asserted while `busy`.
5. After `done`, `busy` must be deasserted in the next cycle.

Example assertions:

```systemverilog
req |-> ##[1:2] grant;

grant |-> busy;

busy |-> busy until_with done;

busy |-> !req;

done |=> !busy;
```

These assertions demonstrate different types of temporal relationships:

```text
A1 → delayed response
A2 → same-cycle relationship
A3 → condition maintained until termination
A4 → same-cycle protocol restriction
A5 → next-cycle relationship
```

---

## 9. Testbench Stimulus and Assertion Sampling

Concurrent assertions sample signals according to their clocking event.

For example, with:

```systemverilog
default clocking cb @(posedge clk);
endclocking
```

the assertion observes signals at every `posedge clk`.

Therefore, the duration of a stimulus matters.

If:

```text
req:   0 ─── 1 ───────── 0
             ↑
          posedge
```

the assertion sees one request.

If `req` remains high across two sampling edges:

```text
req:   0 ─── 1 ───────────── 0
             ↑       ↑
          posedge posedge
```

the assertion can interpret this as `req` being true on two consecutive sampled cycles.

This is important when intentionally generating illegal stimulus for assertion testing.

---

## 10. Key Takeaways

- `until` describes a condition that remains true until a terminating condition.
- `until_with` includes the terminating endpoint in the temporal relationship.
- `throughout` requires a condition to remain true throughout a sequence.
- `|->` starts the consequent in the same cycle.
- `|=>` starts the consequent in the next cycle.
- `default clocking` can provide the clock for concurrent assertions.
- Concurrent assertions can have multiple active evaluation threads.
- Assertion failures should be interpreted together with the stimulus and sampling clock.
- A good verification environment should intentionally generate both legal and illegal scenarios to confirm that assertions detect protocol violations.