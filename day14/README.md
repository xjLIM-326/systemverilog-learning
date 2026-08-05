# Day 14 - Learn Mailbox Communication in SystemVerilog

## Overview

Day 14 introduces **Mailbox**, one of SystemVerilog's built-in inter-process communication mechanisms. A mailbox provides a thread-safe FIFO channel that allows one process (Producer) to send data or objects to another process (Consumer), making it an essential building block for class-based verification environments.

## Topics Covered

* Creating a mailbox
* `put()` and `get()` operations
* Blocking behavior of `get()`
* Producer-Consumer communication model
* Passing class objects through a mailbox
* Importance of creating a new object for every transaction

## Files

* `basic_mailbox.sv`
  Demonstrates mailbox creation and inserting data using `put()`.

* `producer_consumer.sv`
  Shows synchronization between two concurrent processes using mailbox communication.

* `packet_mailbox.sv`
  Demonstrates passing randomized packet objects between Producer and Consumer.

* `challenge.sv`
  Practice implementing a Producer that generates randomized packets and a Consumer that receives and displays them.

## Key Concepts

### Mailbox

A mailbox is a built-in FIFO communication channel that safely transfers data between concurrent processes.

### `put()`

Adds an item to the back of the mailbox queue.

### `get()`

Removes the item at the front of the mailbox queue.
If the mailbox is empty, `get()` blocks until new data becomes available.

### Producer-Consumer Model

The Producer generates transactions and places them into the mailbox, while the Consumer retrieves and processes them. This communication pattern is widely used in verification environments.

### Object Handle Consideration

When sending class objects through a mailbox, the mailbox stores object handles instead of making copies. Therefore, a new object should generally be created for every transaction to avoid unintentionally modifying previously queued data.

## Learning Outcome

After completing this lesson, you should be able to:

* Create and initialize a mailbox.
* Use `put()` and `get()` for inter-process communication.
* Understand the blocking behavior of mailbox synchronization.
* Implement a basic Producer-Consumer architecture.
* Safely transfer randomized class objects through a mailbox.
