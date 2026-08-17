class Transaction;

    int id;
    int producer_id;
    int data;
    int bus_id;

    event done;

    function new(int id, int producer_id, int data, int bus_id);
        this.id = id;
        this.producer_id = producer_id;
        this.data = data;
        this.bus_id = bus_id;
    endfunction

endclass


module transaction_controller;

    mailbox #(Transaction) tx_mbx;

    semaphore bus0_sem;
    semaphore bus1_sem;


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
                $urandom_range(0, 255),
                $urandom_range(0, 1)
            );

            $display(
                "[%0t] Producer %0d: Sending TX %0d via Bus %0d",
                $time,
                producer_id,
                tx.id,
                tx.bus_id
            );

            tx_mbx.put(tx);

            // Wait for THIS transaction to complete
            @tx.done;

            $display(
                "[%0t] Producer %0d: TX %0d completed via Bus %0d",
                $time,
                producer_id,
                tx.id,
                tx.bus_id
            );

        end

    endtask


    // ------------------------------------------------
    // Dispatcher
    // ------------------------------------------------

    task automatic dispatcher();

        Transaction tx;

        forever begin

            tx_mbx.get(tx);

            $display(
                "[%0t] Dispatcher: Received TX %0d from Producer %0d via Bus %0d",
                $time,
                tx.id,
                tx.producer_id,
                tx.bus_id
            );

            fork 
                process_transaction(tx);
            join_none

            #0;

        end

    endtask

    task automatic process_transaction(Transaction tx);

        // Acquire bus
        case (tx.bus_id)

            0: bus0_sem.get(1);
            1: bus1_sem.get(1);

            default: $error("Invalid bus_id = %0d", tx.bus_id);

        endcase

        $display(
            "[%0t] Dispatcher: TX %0d acquired Bus %0d",
            $time,
            tx.id,
            tx.bus_id
        );

        // Simulate bus operation
        #10;

        $display(
            "[%0t] Dispatcher: TX %0d finished Bus %0d operation",
            $time,
            tx.id,
            tx.bus_id
        );

        // Release bus
        if (tx.bus_id == 0)
            bus0_sem.put(1);
        else if (tx.bus_id == 1)
            bus1_sem.put(1);

        // Notify THIS transaction
        ->tx.done;

    endtask


    // ------------------------------------------------
    // Monitor
    // ------------------------------------------------

    task monitor();

        forever begin

            #20;

            $display(
                "[%0t] Monitor:\nMailbox size = %0d",
                $time,
                tx_mbx.num()
            );

            if (bus0_sem.try_get(1)) begin
                $display("Bus 0 = FREE");
                bus0_sem.put(1);
            end
            else
                $display("Bus 0 = BUSY");

            if (bus1_sem.try_get(1)) begin
                $display("Bus 1 = FREE");
                bus1_sem.put(1);
            end
            else
                $display("Bus 1 = BUSY");

        end

    endtask


    // ------------------------------------------------
    // Main
    // ------------------------------------------------

    initial begin

        tx_mbx = new();

        // One key for each bus = Each bus can be accessed by only one TX
        bus0_sem = new(1);
        bus1_sem = new(1);

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
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 17 06:06 2026
[9] Producer 2: Sending TX 322 via Bus 0
[9] Dispatcher: Received TX 322 from Producer 2 via Bus 0
[9] Dispatcher: TX 322 acquired Bus 0
[10] Producer 0: Sending TX 848 via Bus 1
[10] Producer 1: Sending TX 100 via Bus 0
[10] Dispatcher: Received TX 848 from Producer 0 via Bus 1
[10] Dispatcher: TX 848 acquired Bus 1
[10] Dispatcher: Received TX 100 from Producer 1 via Bus 0
[19] Dispatcher: TX 322 finished Bus 0 operation
[19] Dispatcher: TX 100 acquired Bus 0
[19] Producer 2: TX 322 completed via Bus 0
[20] Monitor:
Mailbox size = 0
Bus 0 = BUSY
Bus 1 = BUSY
[20] Dispatcher: TX 848 finished Bus 1 operation
[20] Producer 0: TX 848 completed via Bus 1
[24] Producer 2: Sending TX 240 via Bus 1
[24] Dispatcher: Received TX 240 from Producer 2 via Bus 1
[24] Dispatcher: TX 240 acquired Bus 1
[25] Producer 0: Sending TX 652 via Bus 1
[25] Dispatcher: Received TX 652 from Producer 0 via Bus 1
[29] Dispatcher: TX 100 finished Bus 0 operation
[29] Producer 1: TX 100 completed via Bus 0
[34] Dispatcher: TX 240 finished Bus 1 operation
[34] Dispatcher: TX 652 acquired Bus 1
[34] Producer 2: TX 240 completed via Bus 1
[37] Producer 1: Sending TX 845 via Bus 1
[37] Dispatcher: Received TX 845 from Producer 1 via Bus 1
[40] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = BUSY
[43] Producer 2: Sending TX 924 via Bus 0
[43] Dispatcher: Received TX 924 from Producer 2 via Bus 0
[43] Dispatcher: TX 924 acquired Bus 0
[44] Dispatcher: TX 652 finished Bus 1 operation
[44] Dispatcher: TX 845 acquired Bus 1
[44] Producer 0: TX 652 completed via Bus 1
[49] Producer 0: Sending TX 666 via Bus 1
[49] Dispatcher: Received TX 666 from Producer 0 via Bus 1
[53] Dispatcher: TX 924 finished Bus 0 operation
[53] Producer 2: TX 924 completed via Bus 0
[54] Dispatcher: TX 845 finished Bus 1 operation
[54] Dispatcher: TX 666 acquired Bus 1
[54] Producer 1: TX 845 completed via Bus 1
[60] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = BUSY
[64] Dispatcher: TX 666 finished Bus 1 operation
[64] Producer 1: Sending TX 728 via Bus 0
[64] Producer 0: TX 666 completed via Bus 1
[64] Dispatcher: Received TX 728 from Producer 1 via Bus 0
[64] Dispatcher: TX 728 acquired Bus 0
[74] Dispatcher: TX 728 finished Bus 0 operation
[74] Producer 1: TX 728 completed via Bus 0
[80] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = FREE
[100] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = FREE
[120] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = FREE
[140] Monitor:
Mailbox size = 0
Bus 0 = FREE
Bus 1 = FREE

[150] Simulation finished.
           V C S   S i m u l a t i o n   R e p o r t 
Time: 150 ns
*/