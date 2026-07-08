module tb;

initial begin

    $display("Time = %0t", $time);

    #10;

    $display("Time = %0t", $time);

    #20;

    $display("Time = %0t", $time);

end

endmodule