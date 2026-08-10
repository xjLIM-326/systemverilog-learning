module example2_semaphore;

    semaphore sem;

    initial begin
        sem = new(2);
    end

    // Process A
    initial begin
        #1;

        $display("[%0t] Process A: Waiting for key", $time);

        sem.get(1);

        $display("[%0t] Process A: Got key", $time);

        #10;

        $display("[%0t] Process A: Releasing key", $time);

        sem.put(1);
    end

    // Process B
    initial begin
        #2;

        $display("[%0t] Process B: Waiting for key", $time);

        sem.get(1);

        $display("[%0t] Process B: Got key", $time);

        #10;

        $display("[%0t] Process B: Releasing key", $time);

        sem.put(1);
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 02:01 2026
[1] Process A: Waiting for key
[1] Process A: Got key
[2] Process B: Waiting for key
[2] Process B: Got key
[11] Process A: Releasing key
[12] Process B: Releasing key
           V C S   S i m u l a t i o n   R e p o r t 
Time: 12 ns
*/