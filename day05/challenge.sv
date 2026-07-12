module day05_challenge;

logic a;
logic b;
logic sel;
logic y;

always_comb begin
    if (sel)
        y = a;
    else
        y = b;
end

initial begin
    a = 1; b = 0; sel = 0;
    #5;

    sel = 1;
    #5;

    b = 1;
    #5;

    a = 0;
    #5;

    sel = 0;
    #5;
end

initial begin
    $monitor("Time=%0t\nsel=%b\na=%b\nb=%b \ny=%b\n",
             $time, sel, a, b, y);
end

endmodule

/*Output
Time=0
sel=0
a=1
b=0 
y=0

Time=5
sel=1
a=1
b=0 
y=1

Time=10
sel=1
a=1
b=1 
y=1

Time=15
sel=1
a=0
b=1 
y=0

Time=20
sel=0
a=0
b=1 
y=1

           V C S   S i m u l a t i o n   R e p o r t 
Time: 25 ns
*/