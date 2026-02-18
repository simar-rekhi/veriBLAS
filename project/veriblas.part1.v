// This is the beginning of Part 1 Section 5 - Implement Gate-Based Code
/******************************************

 Gate-Based Code in Verilog 
 by Veriblas
 
 Spring 2026

 ALU Project Part 1

 The purpose of this program is to demonstrate an understanding of
 gate-based logic and general Verilog capabilities. It does so by
 using a truth table's normalized equations in order to display
 said truth table.

 It contains modules for the testbench and breadboard. Effectively,
 the testbench handles the passing and receiving of the inputs and
 outputs of the breadboard. The breadboard holds all equations, which
 then are returned as results (r0-r9). 

 Contributors:
    N. Mateo Garcia (IDE: VSCode; no external tools used)
    Aryan KC

 Reviewers:
    Simar Rekhi
    Yashita Singh Rathore

********************************************/

// -Breadboard module-
// Contains all minterms and equations
// Results of equations are sent back to the testbench
module Breadboard(w,x,y,z,
                    r0,r1,r2,r3,r4,
                    r5,r6,r7,r8,r9);

// -I/O Declaration-
input w,x,y,z;
output r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;

// -Wire & Reg Matching-
wire w,x,y,z;
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;

// -Always container for equations-
// No time constraints if you have the following variables
always @ (w,x,y,z,
            r0,r1,r2,r3,r4,
            r5,r6,r7,r8,r9)
    begin
    // -Minterm definition-
    // Combinations of individual inputs are used to
    // define the minterms used within the equations (m0-m15)



    // -Equation construction & results-
    // Using the minterms, full equations are constructed
    // and put into results (r0-r9)



    end

endmodule
