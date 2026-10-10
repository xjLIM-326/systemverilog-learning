# Day 24: Analysis Ports, Scoreboard and Test Completion

## Objectives

- Learn how to use `uvm_analysis_port` to broadcast transactions.
- Connect Driver and Monitor to a Scoreboard using analysis ports.
- Implement a FIFO-based Scoreboard to compare expected and actual transactions.
- Track passed, failed, and unexpected transactions.
- Use `uvm_event` to signal test completion.
- Implement a watchdog timeout to detect incomplete transactions or stalled tests.
- Validate the verification environment using fault injection.

## 1. Analysis Ports

An analysis port broadcasts a transaction to its connected analysis implementations through the `write()` method.

In this exercise, two independent transaction streams are published:

- **Expected stream:** The Driver publishes the original transaction before it enters the DUT.
- **Actual stream:** The Monitor observes the DUT output and publishes the sampled transaction.

The Scoreboard receives both streams through separate analysis implementations.

```text
Sequence
   |
   v
Driver -----------------> Expected stream
   |                           |
   v                           v
  DUT                      Scoreboard
   |                           ^
   v                           |
Monitor ----------------> Actual stream
```

Key concepts:

- `uvm_analysis_port #(T)` publishes transactions of type `T`.
- `analysis_port.write(transaction)` broadcasts a transaction.
- `uvm_analysis_imp_decl(_expected)` and `uvm_analysis_imp_decl(_actual)` declare separate analysis implementation types.
- `write_expected()` and `write_actual()` handle the corresponding transaction streams.

## 2. FIFO-Based Scoreboard

The Scoreboard stores expected transactions in a queue:

```systemverilog
packet_transaction expected_q[$];
```

When an expected transaction arrives, it is appended to the queue.

When an actual transaction arrives:

1. Check whether the expected queue is empty.
2. If empty, report an unexpected transaction.
3. Otherwise, remove the oldest expected transaction using `pop_front()`.
4. Compare the expected and actual `data` and `dest` fields.
5. Update the verification statistics.

The queue preserves transaction order and is suitable for this exercise because the DUT is expected to produce packets in the same order they are accepted.

### Statistics

| Counter | Meaning |
|---|---|
| `total_checked` | Number of matched expected/actual transaction pairs |
| `total_passed` | Number of matched transactions with all compared fields correct |
| `total_failed` | Number of matched transactions with at least one field mismatch |
| `total_unexpected` | Number of actual transactions received when the expected queue is empty |

A transaction with both `data` and `dest` mismatches is counted as one failed transaction, not two.

An extra transaction arriving while the expected queue is still non-empty may instead be compared against the next expected transaction. A FIFO Scoreboard cannot always distinguish an extra packet from a corrupted packet without additional identifying information.

## 3. Test Completion and Watchdog

Receiving all stimulus does not necessarily mean that all expected DUT outputs have been observed.

The test therefore uses two mechanisms:

- **`stimulus_done`:** Indicates that the Sequence has finished sending transactions.
- **`drain_done`:** Signals that stimulus is complete and the expected queue is empty.

The Test waits for `drain_done`, while a watchdog triggers a fatal error if completion takes too long.

```systemverilog
fork
    begin
        scoreboard.drain_done.wait_on();
    end

    begin
        #1us;
        `uvm_fatal("TIMEOUT", "Test did not complete in time")
    end
join_any

disable fork;
```

`wait_on()` is appropriate here because it also returns when the event has already been triggered before the wait begins.

The watchdog helps detect incomplete transaction processing and prevents the test from waiting indefinitely.

## 4. Fault Injection Experiments

### Experiment A: Driver Data Corruption

Modify the Driver to corrupt a selected input payload while continuing to publish the original transaction as expected data.

**Expected result:** The Monitor observes the corrupted output, and the Scoreboard reports a data mismatch.

This verifies that the Scoreboard can detect payload corruption.

### Experiment B: Monitor Drops a Transaction

Suppress publication of a selected actual transaction in the Monitor.

**Expected result:** The corresponding expected transaction remains unmatched. The completion condition is not satisfied, and the watchdog eventually times out.

This tests the handling of missing observations and incomplete transaction draining. It simulates a Monitor reporting failure, not necessarily a packet being dropped by the DUT.

### Experiment C: Monitor Duplicates a Transaction

Publish an actual transaction multiple times when a selected payload is observed.

**Expected result:** Duplicate transactions can cause FIFO mismatches if expected transactions remain, or be classified as unexpected if the expected queue is empty.

This demonstrates why transaction order and queue state affect error classification.

## 5. Normal Test Results

The clean normal run produced:

| Metric | Result |
|---|---:|
| Total checked | 10 |
| Total passed | 10 |
| Total failed | 0 |
| Total unexpected | 0 |
| Remaining DUT transactions | 0 |
| UVM errors | 0 |
| UVM fatal errors | 0 |

The simulation completed successfully at 125 ns.

## 6. Key Takeaways

- Analysis ports provide a clean way to publish transactions without tightly coupling the publisher to the receiver.
- The Driver's expected stream and Monitor's actual stream serve different purposes.
- A FIFO Scoreboard is effective when transactions are expected to emerge in order.
- Error counters should distinguish matched failures from unexpected actual transactions.
- Test completion must account for both stimulus completion and outstanding expected transactions.
- Watchdogs expose incomplete verification flows that would otherwise hang.
- Fault injection validates the verification environment itself, not just the DUT.

## Next Step

Day 25: Extend the verification environment with additional checking capabilities and more robust transaction-level verification.