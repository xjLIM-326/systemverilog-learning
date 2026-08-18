# Day 18 - Interface, Modport, Virtual Interface & Clocking Block

## Folder Structure

```text
day18/
├── README.md
├── example/
│   ├── interface.sv
│   ├── modport.sv
│   ├── virtual_interface.sv
│   └── clocking_block.sv
└── challenge/
    ├── interface_challenge.sv
    └── virtual_interface_challenge.sv
```

---

# 1. Interface

## Concept

An interface groups related signals into one reusable construct.

Without an interface, the DUT may need multiple individual ports:

```systemverilog
module dut (
    input        clk,
    input        valid,
    input  [7:0] data,
    output       ready
);
```

As the number of signals increases, connecting all signals individually becomes inconvenient.

An interface allows us to group them:

```systemverilog
interface bus_if;

    logic       clk;
    logic       valid;
    logic       ready;
    logic [7:0] data;

endinterface
```

The testbench can instantiate the interface:

```systemverilog
bus_if bus();
```

and connect it to the DUT:

```systemverilog
module dut (
    bus_if bus
);
```

The DUT can then access:

```systemverilog
bus.clk
bus.valid
bus.ready
bus.data
```

The main purpose of an interface is therefore to simplify the connection between the DUT and testbench.

---

# 2. Modport

## Concept

An interface contains signals that may be driven by different components.

For example:

```text
TB  → valid
TB  → data
DUT → ready
```

A modport defines the access direction from the perspective of a particular component.

```systemverilog
modport DUT (
    input  clk,
    input  valid,
    input  data,
    output ready
);
```

From the DUT's perspective:

```text
clk   = input
valid = input
data  = input
ready = output
```

The testbench can have the opposite view:

```systemverilog
modport TB (
    output clk,
    output valid,
    output data,
    input  ready
);
```

Both modports still refer to the same physical interface instance.

```text
                    bus_if
                       │
              ┌────────┴────────┐
              │                 │
              ▼                 ▼
          bus_if.DUT        bus_if.TB
              │                 │
              ▼                 ▼
             DUT            Testbench
```

A modport does not create another interface. It only defines a particular access view.

---

# 3. Virtual Interface

## Concept

Verification environments often use classes such as:

```systemverilog
class Driver;
```

The Driver needs to control DUT signals, but the physical interface is normally instantiated inside a module:

```systemverilog
module tb;

    bus_if bus();

endmodule
```

A class needs a way to access this existing interface.

This is the purpose of a virtual interface.

```systemverilog
class Driver;

    virtual bus_if vif;

endclass
```

The virtual interface is a handle to an existing interface instance.

It does not create another physical interface.

```text
Physical interface
      bus
       │
       │ passed to
       ▼
Virtual interface
      vif
       │
       ▼
    Driver
```

The testbench creates the actual interface:

```systemverilog
bus_if bus();
```

and passes it to the Driver:

```systemverilog
driver = new(bus);
```

The Driver stores the interface handle:

```systemverilog
this.vif = vif;
```

After that, the Driver can access:

```systemverilog
vif.valid
vif.data
vif.clk
```

---

# 4. Clocking Block

## Why Do We Need It?

Suppose the DUT uses:

```systemverilog
always_ff @(posedge bus.clk)
```

while the Driver uses:

```systemverilog
@(posedge vif.clk);
```

Both are synchronized to the same clock edge.

However, being synchronized to the same clock does **not** automatically mean there is no race condition.

The DUT and testbench can still execute around the same simulation time and potentially access the same signals in conflicting scheduling regions.

A clocking block provides a defined timing relationship between the testbench and the DUT.

---

## Basic Clocking Block

```systemverilog
clocking cb @(posedge clk);

    output valid;
    output data;

    input ready;

endclocking
```

The clocking block is associated with:

```systemverilog
@(posedge clk)
```

It does not create another clock.

Instead, it defines how the testbench drives and samples signals around that clock event.

The Driver can synchronize using:

```systemverilog
@(vif.cb);
```

instead of directly using:

```systemverilog
@(posedge vif.clk);
```

Signals can then be accessed through:

```systemverilog
vif.cb.valid
vif.cb.data
vif.cb.ready
```

---

# 5. Clocking Block Directions

Consider:

```systemverilog
clocking cb @(posedge clk);

    output valid;
    output data;

    input ready;

endclocking
```

The directions are from the perspective of the clocking block user, which in our case is the testbench.

Therefore:

```text
valid → output
data  → output
ready → input
```

This corresponds to:

```text
Testbench ───── valid ─────► DUT
Testbench ───── data  ─────► DUT

Testbench ◄──── ready ────── DUT
```

The clocking block therefore describes how the testbench interacts with the DUT.

---

# 6. Clocking Block + Modport

We can expose the clocking block through the TB modport:

```systemverilog
modport TB (
    clocking cb,
    output clk
);
```

A Driver can then declare:

```systemverilog
virtual bus_if.TB vif;
```

and access:

```systemverilog
vif.cb
```

The relationship is:

```text
                         bus_if
                            │
              ┌─────────────┴─────────────┐
              │                           │
         bus_if.DUT                   bus_if.TB
              │                           │
              ▼                           ▼
             DUT                        Driver
                                           │
                                  virtual interface
                                           │
                                           ▼
                                      clocking cb
```

---

# 7. Transaction

## Concept

A Transaction represents the high-level operation or data that the testbench wants to send to the DUT.

For example:

```systemverilog
class Transaction;

    rand bit [7:0] data;

endclass
```

The testbench can create and randomize it:

```systemverilog
Transaction tx;

tx = new();
tx.randomize();
```

The Driver receives the Transaction:

```systemverilog
task drive(input Transaction tx);
```

and uses:

```systemverilog
tx.data
```

to drive the interface.

This gives us a clean separation:

```text
Transaction
     │
     │ describes WHAT to send
     ▼
Driver
     │
     │ determines HOW to send it
     ▼
Interface
     │
     ▼
DUT
```

This separation is an important foundation for UVM.

---

# 8. Valid/Ready Handshake

The challenge uses a simple valid/ready protocol.

The testbench drives:

```text
valid
data
```

The DUT drives:

```text
ready
```

A transfer is considered complete when:

```text
valid = 1
ready = 1
```

The Driver therefore keeps `valid` asserted while waiting for `ready`.

For example:

```systemverilog
do begin

    @(vif.cb);

end while (!vif.cb.ready);

vif.cb.valid <= 1'b0;
```

The Driver continues waiting until:

```systemverilog
vif.cb.ready
```

becomes `1`.

Only then does it deassert `valid`.

---

# 9. Complete Example

```systemverilog
interface bus_if;

    logic       clk;
    logic       valid;
    logic       ready;
    logic [7:0] data;

    clocking cb @(posedge clk);

        output valid;
        output data;

        input ready;

    endclocking

    modport DUT (
        input  clk,
        input  valid,
        input  data,
        output ready
    );

    modport TB (
        clocking cb,
        output clk
    );

endinterface


module dut (
    bus_if.DUT bus
);

    always_ff @(posedge bus.clk) begin

        if (bus.valid) begin

            bus.ready <= 1'b1;

            if (bus.ready)
                $display("DUT received = %02h", bus.data);

        end
        else begin

            bus.ready <= 1'b0;

        end

    end

endmodule


class Transaction;

    rand bit [7:0] data;

endclass


class Driver;

    virtual bus_if.TB vif;

    function new(virtual bus_if.TB vif);
        this.vif = vif;
    endfunction

    task drive(input Transaction tx);

        @(vif.cb);

        vif.cb.valid <= 1'b1;
        vif.cb.data  <= tx.data;

        $display("TB sent = %02h", tx.data);

        do begin

            @(vif.cb);

        end while (!vif.cb.ready);

        vif.cb.valid <= 1'b0;

    endtask

endclass


module tb;

    bus_if bus();

    dut u_dut (
        .bus(bus)
    );

    Driver driver;
    Transaction tx;

    initial begin

        bus.clk = 0;

        forever #5 bus.clk = ~bus.clk;

    end

    initial begin

        driver = new(bus);

        repeat (4) begin

            tx = new();
            tx.randomize();

            driver.drive(tx);

        end

        #20;

        $finish;

    end

endmodule
```

---

# 10. Challenge 1 - Interface + Modport

## File

```text
challenge/interface_challenge.sv
```

## Objective

Practice defining an interface and controlling access using modports.

## Requirements

Create an interface containing:

```text
clk
valid
ready
data
```

Create a `DUT` modport:

```text
clk   → input
valid → input
data  → input
ready → output
```

Create a `TB` modport:

```text
clk   → output
valid → output
data  → output
ready → input
```

Connect the DUT using:

```systemverilog
bus_if.DUT bus
```

The testbench should:

1. Instantiate the interface.
2. Instantiate the DUT.
3. Generate the clock.
4. Drive `valid` and `data`.
5. Observe `ready`.
6. Verify that the DUT receives the expected data.

The main purpose is to understand:

```text
Interface
    +
Modport
    +
DUT
    +
Testbench
```

---

# 11. Challenge 2 - Virtual Interface + Clocking Block

## File

```text
challenge/virtual_interface_challenge.sv
```

## Objective

Build a class-based Driver that communicates with the DUT through a virtual interface and clocking block.

## Interface Requirements

Define:

```text
clk
valid
ready
data
```

Add a clocking block triggered by:

```systemverilog
@(posedge clk)
```

The clocking block should contain:

```text
valid → output
data  → output
ready → input
```

## Modport Requirements

Create a `DUT` modport:

```text
clk   → input
valid → input
data  → input
ready → output
```

Create a `TB` modport that exposes:

```systemverilog
clocking cb
```

and allows the testbench to control the clock.

## Transaction Requirements

Create:

```systemverilog
class Transaction;

    rand bit [7:0] data;

endclass
```

The Transaction should only represent the data.

It should not directly access the interface.

## Driver Requirements

Create a Driver containing:

```systemverilog
virtual bus_if.TB vif;
```

The constructor should receive the virtual interface.

Implement:

```systemverilog
task drive(input Transaction tx);
```

The Driver must:

1. Wait for the clocking block.
2. Assert `valid`.
3. Drive `data`.
4. Wait for `ready`.
5. Deassert `valid`.

Use:

```systemverilog
@(vif.cb);
```

for transaction synchronization.

Do not use:

```systemverilog
@(posedge vif.clk);
```

inside the Driver for transaction timing.

The Driver should not create or randomize the Transaction.

## Testbench Requirements

The testbench should:

1. Instantiate the interface.
2. Instantiate the DUT.
3. Create the Driver.
4. Create four Transactions.
5. Randomize each Transaction.
6. Send each Transaction through the Driver.
7. Print the data sent by the TB.
8. Print the data received by the DUT.
9. Ensure every transaction is received exactly once.

Expected output structure:

```text
TB sent = XX
DUT received = XX

TB sent = XX
DUT received = XX

TB sent = XX
DUT received = XX

TB sent = XX
DUT received = XX
```

The exact hexadecimal values will be different because `data` is randomized.

---

# 12. Key Takeaways

## Interface

Groups related signals into a single reusable construct.

## Modport

Defines the access direction for a particular component.

## Virtual Interface

Allows class-based components to access an existing interface instance.

## Clocking Block

Defines the timing relationship between the testbench and DUT and helps prevent race conditions.

## Transaction

Represents high-level stimulus.

## Driver

Converts high-level transactions into DUT signal activity.

## Valid/Ready

A transfer occurs when both `valid` and `ready` are asserted.

---

# 13. Connection to UVM

The concepts learned in Day 18 map directly to UVM:

```text
Day 18                 UVM

Transaction class  →   uvm_sequence_item

Driver class       →   uvm_driver

drive()            →   run_phase()

Virtual interface  →   virtual interface

Transaction        →   Sequence Item

Interface signals  →   DUT interface
```

The architecture is:

```text
Transaction
     ↓
Driver
     ↓
Virtual Interface
     ↓
Clocking Block
     ↓
Interface
     ↓
DUT
```

This is an important foundation for understanding how a UVM Driver communicates with a DUT.