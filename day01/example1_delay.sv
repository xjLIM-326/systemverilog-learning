module tb;

initial begin
    $display("Simulation Start");

    #5;
    $display("5 ns");

    #10;
    $display("15 ns");

    #20;
    $display("35 ns");

    $display("Simulation End");
end

endmodule