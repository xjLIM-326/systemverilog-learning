module producer_consumer;

    mailbox mbx;
    int data;

    initial begin
        mbx = new();
    end

    initial begin
        #5;

        mbx.put(100);
        $display("[%0t] Producer sends %0d", $time, 100);

        #5;

        mbx.put(200);
        $display("[%0t] Producer sends %0d", $time, 200);
    end

    initial begin

        mbx.get(data);
        $display("[%0t] Consumer receives %0d", $time, data);

        mbx.get(data);
        $display("[%0t] Consumer receives %0d", $time, data);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  5 09:24 2026
[5] Producer sends 100
[5] Consumer receives 100
[10] Producer sends 200
[10] Consumer receives 200
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10 ns
*/