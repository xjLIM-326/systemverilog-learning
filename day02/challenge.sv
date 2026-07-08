module day02_challenge;

logic [7:0] student_id;
int score;
string name;

initial begin
    student_id = 8'h2A;
    score      = 95;
    name       = "Xian Jun";

    $display("Student Name : %s", name);
    $display("Student ID   : %h", student_id);
    $display("Score        : %0d", score);
end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Jul  8 08:58 2026
Student Name : Xian Jun
Student ID   : 2a
Score        : 95
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/