module day01_bonus;

initial begin
    repeat(3) begin
        #5;
        $display("A @ %0t", $time);
    end
end

initial begin
    repeat (2) begin
        #7;
        $display("B @ %0t", $time);
    end
end

endmodule