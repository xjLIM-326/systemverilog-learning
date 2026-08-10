module example1_event;

    event data_ready;

    // Producer
    initial begin
        #10;

        $display("[%0t] Producer: Data is ready!", $time);

        -> data_ready;
    end

    // Consumer
    initial begin

        $display("[%0t] Consumer: Waiting for data...", $time);

        @data_ready;

        $display("[%0t] Consumer: Data received!", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 01:59 2026
[0] Consumer: Waiting for data...
[10] Producer: Data is ready!
[10] Consumer: Data received!
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10 ns
*/