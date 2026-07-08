module tb;

initial begin
    #5;
    $display("Thread A");
end

initial begin
    #10;
    $display("Thread B");
end

endmodule