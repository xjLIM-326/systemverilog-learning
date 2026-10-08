# Day 23: UVM Driver & Monitor

## Objective

Learn how a UVM testbench transfers transactions between the sequence layer and the DUT, and how a monitor reconstructs transactions from DUT interface signals.

This day focuses on the basic UVM data flow:

```text
Sequence
   │
   ▼
Sequencer
   │
   ▼
Driver
   │
   ▼
DUT
   │
   ▼
Monitor
```

The main concepts covered are:

* `uvm_driver`
* `uvm_monitor`
* `uvm_sequencer`
* `seq_item_port`
* `seq_item_export`
* `virtual interface`
* `uvm_config_db`
* Reset handling
* Converting transactions to DUT signals
* Converting DUT signals back into transactions

---

## Folder Structure

```text
day23/
│
├── README.md
│
├── dut/
│   └── packet_router.sv
│
├── eda/
│   ├── design.sv
│   └── testbench.sv
│
└── tb/
    ├── packet_driver.sv
    ├── packet_interface.sv
    ├── packet_monitor.sv
    ├── packet_sequence.sv
    ├── packet_sequencer.sv
    ├── packet_tb_pkg.svh
    ├── packet_test.sv
    └── packet_transaction.sv
```

---

## DUT

The DUT is a simple registered packet router.

```text
valid_i
data_i
dest_i
   │
   ▼
┌─────────────────┐
│  packet_router  │
│                 │
│  1-cycle delay  │
└─────────────────┘
   │
   ▼
valid_o
data_o
dest_o
```

The DUT transfers the input packet information to the output on the following clock cycle.

Reset is active-low:

```text
rst_n = 0 → Reset
rst_n = 1 → Normal operation
```

---

## 1. Transaction

`packet_transaction` represents one packet:

```text
packet_transaction
├── data
└── dest
```

The transaction contains packet information rather than every signal on the DUT interface.

`valid` is treated as a protocol/control signal in this exercise. The Driver generates the valid cycle when driving a transaction, while the Monitor uses `valid_o` to determine whether a valid packet is present.

---

## 2. Sequence

The sequence generates 10 packet transactions.

The first two transactions are directed to specific boundary values:

```text
Transaction 1:
data = 8'h00

Transaction 2:
data = 8'hFF
```

The remaining transactions are randomized.

This provides a simple mixture of:

* Directed stimulus
* Boundary-value testing
* Randomized stimulus

---

## 3. Sequencer

The `packet_sequencer` provides the connection between the sequence and the Driver.

The basic transaction flow is:

```text
packet_sequence
       │
       │ start_item / finish_item
       ▼
packet_sequencer
       │
       │ seq_item_export
       ▼
packet_driver
```

The Driver obtains sequence items through its `seq_item_port`.

The connection is established in the test:

```systemverilog
driver.seq_item_port.connect(sequencer.seq_item_export);
```

---

## 4. Driver

The Driver converts a `packet_transaction` into DUT interface signals.

```text
packet_transaction
       │
       ▼
     Driver
       │
       ├── valid_i
       ├── data_i
       └── dest_i
```

For each transaction, the Driver:

1. Obtains the next transaction from the Sequencer.
2. Drives `data_i` and `dest_i`.
3. Assert `valid_i` for one clock cycle.
4. Completes the sequence item using `item_done()`.

One transaction therefore corresponds to one valid packet cycle.

### Reset Handling

The Driver does not start normal transaction processing while reset is active.

The interface is initialized to an idle state and the Driver waits for:

```text
rst_n = 1
```

before processing sequence items.

This prevents transactions from being driven into the DUT during reset.

---

## 5. Virtual Interface

The Driver and Monitor are UVM classes, while `packet_if` is instantiated in the top-level testbench.

Therefore, they use a virtual interface:

```systemverilog
virtual packet_if vif;
```

This allows class-based UVM components to access the actual interface instance created by the testbench.

The relationship is:

```text
packet_tb
   │
   └── packet_if vif
           │
           │ virtual interface handle
           ▼
      ┌───────────────┐
      │ Driver        │
      │ Monitor       │
      └───────────────┘
```

---

## 6. `uvm_config_db`

The top-level testbench provides the virtual interface through `uvm_config_db`.

Conceptually:

```text
Top-level module
      │
      │ set()
      ▼
uvm_config_db
      │
      ├──────────► Driver get()
      │
      └──────────► Monitor get()
```

The Driver and Monitor retrieve the interface during their `build_phase`.

If the virtual interface cannot be obtained, the component terminates the simulation with `uvm_fatal`.

This demonstrates a basic form of dependency injection in UVM: the testbench provides the interface dependency instead of the Driver or Monitor creating it themselves.

---

## 7. Monitor

The Monitor performs the reverse operation of the Driver.

```text
DUT interface
      │
      ▼
   Monitor
      │
      ▼
packet_transaction
```

The Monitor:

1. Waits for a clock edge.
2. Samples the DUT output signals.
3. Checks `valid_o`.
4. When a valid packet is present, creates a `packet_transaction`.
5. Copies `data_o` and `dest_o` into the transaction.
6. Prints the observed transaction.

For example:

```text
valid_o = 1
data_o  = 8'hAB
dest_o  = 2'b10
```

is reconstructed as:

```text
packet_transaction
data = 8'hAB
dest  = 2'b10
```

The Monitor does not drive any DUT signals.

---

## 8. Reset Handling in the Monitor

The Monitor must not interpret reset activity as a valid packet.

During reset:

```text
rst_n = 0
```

the DUT output is reset and `valid_o` is inactive.

Normal transaction monitoring therefore begins after reset is released.

---

## 9. Test

The test creates the required UVM components:

```text
packet_test
│
├── packet_sequencer
├── packet_driver
└── packet_monitor
```

The Sequencer and Driver are connected through:

```text
seq_item_port
      │
      ▼
seq_item_export
```

The test then starts the packet sequence and controls the UVM run-phase objection.

The final synchronization ensures that the last DUT output has enough time to be observed by the Monitor before the run phase ends.

---

## 10. Verification Flow

The complete transaction flow is:

```text
┌─────────────────────┐
│ packet_sequence     │
│                     │
│ Generate 10 packets │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ packet_sequencer    │
└──────────┬──────────┘
           │
           │ seq_item_port
           ▼
┌─────────────────────┐
│ packet_driver       │
│                     │
│ Transaction →       │
│ Interface signals   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ packet_router DUT   │
│                     │
│ 1-cycle registered  │
│ packet transfer     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ packet_monitor      │
│                     │
│ Interface signals → │
│ Transaction         │
└─────────────────────┘
```

---

## 11. Simulation Result

The final simulation successfully observed all 10 generated transactions.

The Monitor output included:

```text
data_o = 00 dest_o = 11
data_o = ff dest_o = 01
data_o = 9b dest_o = 11
data_o = 25 dest_o = 01
data_o = 36 dest_o = 11
data_o = 4c dest_o = 10
data_o = f6 dest_o = 01
data_o = ad dest_o = 01
data_o = d3 dest_o = 10
data_o = 13 dest_o = 10
```

Simulation summary:

```text
UVM_INFO    : 13
UVM_WARNING: 0
UVM_ERROR  : 0
UVM_FATAL  : 0
```

The Monitor successfully reconstructed all 10 packets from the DUT output.

---

## Key Takeaways

### 1. Driver

The Driver converts:

```text
Transaction → DUT signals
```

### 2. Monitor

The Monitor converts:

```text
DUT signals → Transaction
```

### 3. Sequencer ↔ Driver

The connection uses:

```text
seq_item_port ↔ seq_item_export
```

This is different from an analysis port.

### 4. Virtual Interface

A `virtual interface` allows UVM classes to access signals belonging to a module-level interface instance.

### 5. `uvm_config_db`

`uvm_config_db` provides a mechanism for passing the virtual interface from the top-level testbench to UVM components.

### 6. Reset Is Part of Verification

The Driver must avoid sending transactions during reset, while the Monitor must avoid interpreting reset activity as valid DUT output.

### 7. Transaction Flow

The most important mental model from Day 23 is:

```text
Sequence
   ↓
Sequencer
   ↓
Driver
   ↓
Interface
   ↓
DUT
   ↓
Interface
   ↓
Monitor
   ↓
Transaction
```

---

## Day 23 Challenge Status

* [x] Create a packet transaction
* [x] Generate directed and randomized transactions
* [x] Create a Sequencer
* [x] Implement a Driver
* [x] Connect Sequencer to Driver
* [x] Introduce a virtual interface
* [x] Pass the virtual interface using `uvm_config_db`
* [x] Implement a Monitor
* [x] Handle reset in the Driver
* [x] Handle reset in the Monitor
* [x] Observe all 10 generated transactions
* [x] Complete the basic UVM stimulus-to-observation flow

### Next Step

Day 24 will extend this architecture by introducing communication from the Monitor to other verification components using:

```text
uvm_analysis_port
```

and will begin building a mechanism to automatically check whether the DUT output matches the expected behavior.
