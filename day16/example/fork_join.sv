module fork_join_example;

    initial begin

        $display("[%0t] Main process starts", $time);

        fork

            begin
                #10;
                $display("[%0t] Process A finished", $time);
            end

            begin
                #20;
                $display("[%0t] Process B finished", $time);
            end

            begin
                #30;
                $display("[%0t] Process C finished", $time);
            end

        join

        $display("[%0t] Main process continues", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 10:50 2026
[0] Main process starts
[10] Process A finished
[20] Process B finished
[30] Process C finished
[30] Main process continues
           V C S   S i m u l a t i o n   R e p o r t 
Time: 30 ns
*/