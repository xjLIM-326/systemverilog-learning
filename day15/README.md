# Day 15: Learn Event and Semaphore

## Topics Covered

* Understand `event` as a synchronization and notification mechanism
* Learn how to trigger an event using `->`
* Learn how to wait for an event using `@event`
* Understand `semaphore` as a resource access control mechanism
* Learn how to initialize a semaphore with a number of keys
* Learn how to acquire keys using `get()`
* Learn how to release keys using `put()`
* Understand how `event` and `semaphore` can be combined in a concurrent verification environment

## Examples

### Example 1: Event

Demonstrates basic event synchronization between concurrent processes.

* Producer triggers an event using `->`
* Consumer waits for the event using `@event`
* Consumer resumes execution after the event is triggered

### Example 2: Semaphore

Demonstrates how a semaphore controls access to a shared resource.

* Initialize a semaphore with multiple keys
* Processes acquire keys using `get()`
* Processes release keys using `put()`
* A process blocks when no sufficient keys are available

### Example 3: Event + Semaphore

Combines both synchronization mechanisms.

* Semaphore controls access to a shared resource
* Event notifies a monitor when resource activity is completed

## Challenge

Implemented a shared bus access scenario with two masters and one monitor.

* Use a semaphore with one key to control shared bus access
* Ensure only one master can access the bus at a time
* Use an event to notify the monitor when a bus transaction is completed
* Demonstrate concurrent processes and synchronization using `semaphore` and `event`

## Key Takeaways

* `mailbox` is mainly used for **data transfer**
* `event` is mainly used for **notification**
* `semaphore` is mainly used for **resource access control**
* An event can be triggered multiple times, while `@event` waits for one trigger
* A semaphore blocks a process when the requested number of keys is unavailable
