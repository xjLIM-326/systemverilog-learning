module basic_mailbox;

    mailbox mbx;

    initial begin
        mbx = new();

        mbx.put(10);
        mbx.put(20);
        mbx.put(30);

        $display("Three numbers inserted.");
    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  5 09:22 2026
Three numbers inserted.
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/