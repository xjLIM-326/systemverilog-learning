module day15_challenge;

    semaphore bus_sem;
    event bus_done;

    initial begin
        bus_sem = new(1);
    end

    // Master A
    initial begin

        $display("[%0t] Master A: Waiting for bus access", $time);

        bus_sem.get(1);

        $display("[%0t] Master A: Got bus", $time);

        #10;

        $display("[%0t] Master A: Releasing bus", $time);

        bus_sem.put(1);

        -> bus_done;

    end

    // Master B
    initial begin

        $display("[%0t] Master B: Waiting for bus access", $time);

        bus_sem.get(1);

        $display("[%0t] Master B: Got bus", $time);

        #10;

        $display("[%0t] Master B: Releasing bus", $time);

        bus_sem.put(1);

        -> bus_done;

    end

    // Monitor
    initial begin

        $display("[%0t] Monitor: Waiting for bus transaction", $time);

        @bus_done;

        $display("[%0t] Monitor: Bus transaction completed", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 02:12 2026
[0] Master A: Waiting for bus access
[0] Master A: Got bus
[0] Master B: Waiting for bus access
[0] Monitor: Waiting for bus transaction
[10] Master A: Releasing bus
[10] Master B: Got bus
[10] Monitor: Bus transaction completed
[20] Master B: Releasing bus
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/