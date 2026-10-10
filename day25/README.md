# Day 25: Learn UVM Reference Models

## Objectives

- Understand the role of a reference model in a UVM verification environment.
- Learn how to connect components using `uvm_analysis_port` and `uvm_analysis_imp`.
- Separate expected behavior prediction from actual DUT output monitoring.
- Connect the Driver, Reference Model, Monitor, and Scoreboard using TLM analysis connections.
- Validate the verification environment by injecting an intentional DUT bug.

## Verification Architecture

The verification environment contains the following components:

- **Driver**: Drives packet transactions into the DUT and forwards the input transactions to the Reference Model.
- **Reference Model**: Predicts the expected packet output based on the input transaction.
- **Monitor**: Observes valid DUT output transactions and publishes them through an analysis port.
- **Scoreboard**: Compares expected transactions from the Reference Model against actual transactions from the Monitor.

The Reference Model and Monitor operate independently. The Scoreboard receives their outputs and determines whether the DUT behaves as expected.

## Key Concepts

- `uvm_analysis_port`: Broadcasts transactions to connected components.
- `uvm_analysis_imp`: Receives transactions and invokes the corresponding `write_*()` callback.
- `` `uvm_analysis_imp_decl(_input) ``: Declares a customized analysis implementation suffix.
- `packet_transaction::type_id::create()`: Creates a transaction using the UVM factory.
- TLM connections: Connect the Driver, Reference Model, Monitor, and Scoreboard without tightly coupling their implementations.

## Verification Results

### 1. Normal DUT Behavior

The DUT implements a registered pass-through packet router. The Reference Model predicts the expected `data` and `dest` values.

- Transactions checked: 50
- Passed: 50
- Failed: 0
- Unexpected transactions: 0
- Remaining DUT transactions: 0

### 2. Intentional DUT Bug

Temporarily modified the DUT data path:

```systemverilog
vif.data_o <= vif.data_i + 1;
```

The Reference Model continued to predict the original input data, allowing the Scoreboard to detect the mismatch.

- Transactions checked: 50
- Passed: 0
- Failed: 50
- Unexpected transactions: 0
- Remaining DUT transactions: 0

### 3. Restored DUT Behavior

Restored the original pass-through data path and reran the test.

- Transactions checked: 50
- Passed: 50
- Failed: 0
- Unexpected transactions: 0
- Remaining DUT transactions: 0

## Key Takeaways

- A Reference Model predicts expected behavior independently of the DUT output.
- The Scoreboard compares predicted transactions against observed DUT transactions.
- A verification environment should detect incorrect DUT behavior, not merely pass when the DUT is correct.
- Intentionally injecting a bug is an effective way to validate the effectiveness of a checker.

## Next Steps

Day 26 will introduce a synchronous FIFO DUT, providing opportunities to build a stateful Reference Model and verify queue behavior, read/write operations, and boundary conditions.
