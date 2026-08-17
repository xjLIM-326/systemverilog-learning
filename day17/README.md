# Day 17 - Transaction-Level Concurrency

## Topics

- `fork...join_none`
- Transaction-level concurrency
- `automatic` tasks
- Mailbox
- Semaphore
- Event
- Multiple shared resources
- Process synchronization
- `#0` and SystemVerilog scheduling

---

## 1. Concept

In a simple dispatcher, transactions are processed sequentially:

```text
Mailbox
   |
   v
Dispatcher
   |
   v
Process TX A
   |
   v
Process TX B
   |
   v
Process TX C