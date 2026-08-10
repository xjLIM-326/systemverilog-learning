module day16_challenge_q1;

    initial begin

        $display("[%0t] Main process starts", $time);

        fork

            begin
                $display("[%0t] Master A started", $time);
                #10;
                $display("[%0t] Master A finished", $time);
            end

            begin
                $display("[%0t] Master B started", $time);
                #20;
                $display("[%0t] Master B finished", $time);
            end

            begin
                $display("[%0t] Master C started", $time);
                #30;
                $display("[%0t] Master C finished", $time);
            end

        join

        $display("[%0t] Main process continues", $time);

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug 10 11:01 2026
[0] Main process starts
[0] Master A started
[0] Master B started
[0] Master C started
[10] Master A finished
[20] Master B finished
[30] Master C finished
[30] Main process continues
           V C S   S i m u l a t i o n   R e p o r t 
Time: 30 ns
*/