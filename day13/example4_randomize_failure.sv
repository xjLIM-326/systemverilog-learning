class Packet;

    rand bit [7:0] value;

    constraint impossible {
        value > 200;
        value < 100;
    }

endclass

module tb;

    Packet pkt;

    initial begin

        pkt = new();

        if (!pkt.randomize())
            $display("Randomization Failed!");
        else
            $display("Success");

    end

endmodule

/*Output
Compiler version X-2025.06-SP1_Full64; Runtime version X-2025.06-SP1_Full64;  Aug  4 08:06 2026

=======================================================

Solver failed when solving following set of constraints 


rand bit[7:0] value; // rand_mode = ON 

constraint impossible    // (from this) (constraint_mode = ON) (testbench.sv:5)
{
   (value > 8'hc8);
   (value < 8'h64);
}

=======================================================


Note-[CNST-SATE] Standalone test extracted
  A standalone test-case for this failure has automatically been extracted 
  from randomize serial 1 partition 1.
  To reproduce the error using the extracted testcase, please use the 
  following command:
  cd /home/runner/./simv.cst/testcases;
  vcs -sverilog extracted_r_1_p_1_inconsistent_constraints.sv -R
  To reproduce the error using the original design and verbose logging, re-run
  simulation using:
  simv +ntb_solver_debug=trace +ntb_solver_debug_filter=1
  To reproduce the error using the original design and debug the error with 
  Verdi/DVE:
  1. re-compile the original design with -debug_access+all, if not already 
  done so
  	% vcs -debug_access+all <other options>
  2. re-run the simulation interactively with -gui/-verdi
  	% simv -gui/-verdi <other options>
  3. enter the following commands to begin interactive constraint 
  inconsistency debug within Verdi/DVE
  	I. set the breakpoint:	verdi/dve> stop -solver -serial 1
  	II. run the simulation till it stops:	verdi/dve> run
  	III. step in the constraint solver:	verdi/dve> step -solver


Error-[CNST-CIF] Constraints inconsistency failure
testbench.sv, 20
  Constraints are inconsistent and cannot be solved.
  Please check the inconsistent constraints being printed above and rewrite 
  them.

Randomization Failed!
           V C S   S i m u l a t i o n   R e p o r t 
Time: 0 ns
*/