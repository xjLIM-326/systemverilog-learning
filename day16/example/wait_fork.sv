module fork_join_example;

    initial begin

        fork

            begin
                #10;
                $display("[%0t] Process A finished", $time);
            end

            begin
                #20;
                $display("[%0t] Process B finished", $time);
            end

        join_none

        $display("[%0t] Main process continues", $time);

        wait fork;

        $display("[%0t] All child processes finished", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 10:54 2026
[0] Main process continues
[10] Process A finished
[20] Process B finished
[20] All child processes finished
           V C S   S i m u l a t i o n   R e p o r t 
Time: 20 ns
*/