module example3_event_semaphore;

    semaphore sem;
    event resource_done;

    initial begin
        sem = new(1);
    end

    // Process A
    initial begin

        $display("[%0t] A: Waiting for resource", $time);

        sem.get(1);

        $display("[%0t] A: Got resource", $time);

        #10;

        $display("[%0t] A: Finished using resource", $time);

        sem.put(1);

        -> resource_done;

    end

    // Process B
    initial begin

        $display("[%0t] B: Waiting for resource", $time);

        sem.get(1);

        $display("[%0t] B: Got resource", $time);

        #5;

        $display("[%0t] B: Finished using resource", $time);

        sem.put(1);

        -> resource_done;

    end

    // Monitor
    initial begin

        $display("[%0t] Monitor: Waiting for activity", $time);

        @resource_done;

        $display("[%0t] Monitor: Resource activity detected", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 02:03 2026
[0] A: Waiting for resource
[0] A: Got resource
[0] B: Waiting for resource
[0] Monitor: Waiting for activity
[10] A: Finished using resource
[10] B: Got resource
[10] Monitor: Resource activity detected
[15] B: Finished using resource
           V C S   S i m u l a t i o n   R e p o r t 
Time: 15 ns
*/