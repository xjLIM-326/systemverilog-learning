class Transaction;

    int id;
    int producer_id;
    int data;

    event done;

    function new(int id, int producer_id, int data);
        this.id = id;
        this.producer_id = producer_id;
        this.data = data;
    endfunction

endclass


module transaction_controller;

    mailbox #(Transaction) tx_mbx;

    semaphore bus_sem;


    // ------------------------------------------------
    // Producer
    // ------------------------------------------------

    task automatic producer(int producer_id, int num_transactions);

        Transaction tx;

        repeat (num_transactions) begin

            #($urandom_range(5, 10));

            tx = new(
                $urandom_range(100, 999),
                producer_id,
                $urandom_range(0, 255)
            );

            $display(
                "[%0t] Producer %0d: Sending TX %0d",
                $time,
                producer_id,
                tx.id
            );

            tx_mbx.put(tx);

            // Wait for THIS transaction to complete
            @tx.done;

            $display(
                "[%0t] Producer %0d: TX %0d completed",
                $time,
                producer_id,
                tx.id
            );

        end

    endtask


    // ------------------------------------------------
    // Dispatcher
    // ------------------------------------------------

    task dispatcher();

        Transaction tx;

        forever begin

            tx_mbx.get(tx);

            $display(
                "[%0t] Dispatcher: Received TX %0d from Producer %0d",
                $time,
                tx.id,
                tx.producer_id
            );

            // Acquire bus
            bus_sem.get(1);

            $display(
                "[%0t] Dispatcher: TX %0d acquired bus",
                $time,
                tx.id
            );

            // Simulate bus operation
            #10;

            $display(
                "[%0t] Dispatcher: TX %0d finished bus operation",
                $time,
                tx.id
            );

            // Release bus
            bus_sem.put(1);

            // Notify THIS transaction
            ->tx.done;

        end

    endtask


    // ------------------------------------------------
    // Monitor
    // ------------------------------------------------

    task monitor();

        forever begin

            #20;

            $display(
                "[%0t] Monitor: Mailbox size = %0d",
                $time,
                tx_mbx.num()
            );

        end

    endtask


    // ------------------------------------------------
    // Main
    // ------------------------------------------------

    initial begin

        tx_mbx = new();

        // One key = only one TX can access bus
        bus_sem = new(1);

        fork

            producer(0, 3);

            producer(1, 3);

            producer(2, 3);

            dispatcher();

            monitor();

        join_none

        #150;

        $display(
            "\n[%0t] Simulation finished.",
            $time
        );

        disable fork;

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 16 11:25 2026
[9] Producer 2: Sending TX 322
[9] Dispatcher: Received TX 322 from Producer 2
[9] Dispatcher: TX 322 acquired bus
[10] Producer 0: Sending TX 848
[10] Producer 1: Sending TX 100
[19] Dispatcher: TX 322 finished bus operation
[19] Dispatcher: Received TX 848 from Producer 0
[19] Dispatcher: TX 848 acquired bus
[19] Producer 2: TX 322 completed
[20] Monitor: Mailbox size = 1
[24] Producer 2: Sending TX 130
[29] Dispatcher: TX 848 finished bus operation
[29] Dispatcher: Received TX 100 from Producer 1
[29] Dispatcher: TX 100 acquired bus
[29] Producer 0: TX 848 completed
[39] Dispatcher: TX 100 finished bus operation
[39] Dispatcher: Received TX 130 from Producer 2
[39] Dispatcher: TX 130 acquired bus
[39] Producer 0: Sending TX 856
[39] Producer 1: TX 100 completed
[40] Monitor: Mailbox size = 1
[44] Producer 1: Sending TX 661
[49] Dispatcher: TX 130 finished bus operation
[49] Dispatcher: Received TX 856 from Producer 0
[49] Dispatcher: TX 856 acquired bus
[49] Producer 2: TX 130 completed
[59] Dispatcher: TX 856 finished bus operation
[59] Dispatcher: Received TX 661 from Producer 1
[59] Dispatcher: TX 661 acquired bus
[59] Producer 2: Sending TX 379
[59] Producer 0: TX 856 completed
[60] Monitor: Mailbox size = 1
[67] Producer 0: Sending TX 175
[69] Dispatcher: TX 661 finished bus operation
[69] Dispatcher: Received TX 379 from Producer 2
[69] Dispatcher: TX 379 acquired bus
[69] Producer 1: TX 661 completed
[76] Producer 1: Sending TX 729
[79] Dispatcher: TX 379 finished bus operation
[79] Dispatcher: Received TX 175 from Producer 0
[79] Dispatcher: TX 175 acquired bus
[79] Producer 2: TX 379 completed
[80] Monitor: Mailbox size = 1
[89] Dispatcher: TX 175 finished bus operation
[89] Dispatcher: Received TX 729 from Producer 1
[89] Dispatcher: TX 729 acquired bus
[89] Producer 0: TX 175 completed
[99] Dispatcher: TX 729 finished bus operation
[99] Producer 1: TX 729 completed
[100] Monitor: Mailbox size = 0
[120] Monitor: Mailbox size = 0
[140] Monitor: Mailbox size = 0

[150] Simulation finished.
           V C S   S i m u l a t i o n   R e p o r t 
Time: 150 ns
*/