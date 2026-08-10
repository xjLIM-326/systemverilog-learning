module fork_join_example;

    initial begin

        fork

            begin
                #10;
                $display("Process A finished");
            end

            begin
                #100;
                $display("Process B finished");
            end

        join_any

        disable fork;

        $display("Main process continues");

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 10:56 2026
Process A finished
Main process continues
           V C S   S i m u l a t i o n   R e p o r t 
Time: 10 ns
*/