module day01_challenge;

initial begin
    $display("Simulation Start");

    $display("Time = %0t", $time);

    #8;

    $display("Time = %0t", $time);

    #12;

    $display("Time = %0t", $time);

    #15;

    $display("Time = %0t", $time);

    $display("Simulation End");

end

endmodule