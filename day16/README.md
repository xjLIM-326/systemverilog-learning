# Day 16: Learn Fork/Join and Process Control

## Topics Covered

* `fork...join`
* `fork...join_any`
* `fork...join_none`
* `wait fork`
* `disable fork`
* Concurrent process execution
* Parent-child process synchronization
* Terminating forked processes

## Example

The `example/` directory contains examples demonstrating different fork/join mechanisms:

* `fork_join.sv`

  * Demonstrates `fork...join`
  * Parent process waits for all child processes to complete

* `fork_join_any.sv`

  * Demonstrates `fork...join_any`
  * Parent process continues when any one child process completes
  * Other child processes continue running

* `fork_join_none.sv`

  * Demonstrates `fork...join_none`
  * Parent process continues immediately without waiting for child processes

* `wait_fork.sv`

  * Demonstrates `wait fork`
  * Parent process waits for all currently running child processes to complete

* `disable_fork.sv`

  * Demonstrates `disable fork`
  * Terminates remaining active child processes

## Challenge

The `challenge/` directory contains three exercises:

* `fork_join_challenge.sv`

  * Use `fork...join` to execute three master processes concurrently
  * Parent process continues only after all masters finish

* `fork_join_any_challenge.sv`

  * Replace `join` with `join_any`
  * Observe that the parent process continues when the first master finishes
  * Remaining masters continue executing

* `disable_fork_challenge.sv`

  * Use `join_any` together with `disable fork`
  * Parent process continues when the first master finishes
  * Remaining active masters are terminated

## Key Takeaways

| Construct      | Parent Process                       | Child Processes                      |
| -------------- | ------------------------------------ | ------------------------------------ |
| `join`         | Waits for all                        | Continue until completion            |
| `join_any`     | Continues after any one finishes     | Remaining processes continue         |
| `join_none`    | Continues immediately                | Continue in background               |
| `wait fork`    | Waits for all active child processes | Continue until completion            |
| `disable fork` | Does not wait                        | Terminates remaining child processes |

The key concept is that `fork` creates concurrent processes, while `join`, `join_any`, and `join_none` determine when the parent process continues. `wait fork` can be used to wait for child processes later, while `disable fork` can terminate remaining active processes.
