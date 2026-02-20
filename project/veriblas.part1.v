/******************************************

 Gate-Based Code in Verilog 
 by veriBLAS

 Language: iVerilog (Icarus Verilog)
 Editor: Visual Studio Code (VSCode)
 Compiler: iVerilog (via MacOS Terminal)
 2/18/2026

 Spring 2026 CS4341.007

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
    Aryan KC (Editor: VSCode; Compiler: iVerilog via MacOS Terminal)

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

// -Wire & Reg Assignments-
wire w,x,y,z;
reg r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;

// -Always container for equations-
// No time constraints if you have the following variables
always @ (w,x,y,z,
            r0,r1,r2,r3,r4,
            r5,r6,r7,r8,r9)
    begin

    // -Equation construction & results-
    // Using the minterms, full equations are constructed
    // and put into results (r0-r9).

    // r0 (f0) Minterm Form: Rows 0, 5, 7, 8, 10, 11, 12
    r0 = (~w&~x&~y&~z)|(~w&x&~y&z)|(~w&x&y&z)|(w&~x&~y&~z)|(w&~x&y&~z)|
         (w&~x&y&z)|(w&x&~y&~z);

    // r1 (f1) Minterm Form: Rows 0, 1, 4, 5, 6, 9, 11, 12, 14, 15
    r1 = (~w&~x&~y&~z)|(~w&~x&~y&z)|(~w&x&~y&~z)|(~w&x&~y&z)|(~w&x&y&~z)
         |(w&~x&~y&z)|(w&~x&y&z)|(w&x&~y&~z)|(w&x&y&~z)|(w&x&y&z);

    // r2 (f2) Minterm Form: Rows 0, 2, 5, 6, 7, 11, 14, 15
    r2 = (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&x&~y&z)|(~w&x&y&~z)|(~w&x&y&z)
         |(w&~x&y&z)|(w&x&y&~z)|(w&x&y&z);

    // r3 (f3) Minterm Form: Rows 2, 4, 9, 10, 13
    r3 = (~w&~x&y&~z)|(~w&x&~y&~z)|(w&~x&~y&z)|(w&~x&y&~z)|(w&x&~y&z);

    // r4 (f4) Minterm Form: Rows 4, 7, 9, 14
    r4 = (~w&x&~y&~z)|(~w&x&y&z)|(w&~x&~y&z)|(w&x&y&~z);

    // r5 (f5) Minterm Form: Rows 0, 1, 2, 4, 5, 13, 14
    r5 = (~w&~x&~y&~z)|(~w&~x&~y&z)|(~w&~x&y&~z)|(~w&x&~y&~z)|(~w&x&~y&z)|
         (w&x&~y&z)|(w&x&y&~z);

    // r6 (f6) Minterm Form: Rows 0, 2, 5, 8, 11, 12, 13
    r6 = (~w&~x&~y&~z)|(~w&~x&y&~z)|(~w&x&~y&z)|(w&~x&~y&~z)|(w&~x&y&z)|
         (w&x&~y&~z)|(w&x&~y&z);

    // r7 (f7) Minterm Form: Rows 1, 6, 8, 9, 11, 12, 14, 15
    r7 = (~w&~x&~y&z)|(~w&x&y&~z)|(w&~x&~y&~z)|(w&~x&~y&z)|(w&~x&y&z)|
         (w&x&~y&~z)|(w&x&y&~z)|(w&x&y&z);

    // r8 (f8) Minterm Form: Rows 1, 2, 4, 6, 8, 9, 10, 12, 15
    r8 = (~w&~x&~y&z)|(~w&~x&y&~z)|(~w&x&~y&~z)|(~w&x&y&~z)|(w&~x&~y&~z)|
         (w&~x&~y&z)|(w&~x&y&~z)|(w&x&~y&~z)|(w&x&y&z);

    // r9 (f9) Minterm Form: Rows 0, 4, 6, 7, 11, 14, 15
    r9 = (~w&~x&~y&~z)|(~w&x&~y&~z)|(~w&x&y&~z)|(~w&x&y&z)|(w&~x&y&z)|
         (w&x&y&~z)|(w&x&y&z);

    end

endmodule

// Skeleton for testbench module
module testbench();

    reg [4:0] i; // Loop var
    // Registers for input vars
    reg a;
    reg b;
    reg c;
    reg d;

    // Wires for all 10 equations
    wire f0,f1,f2,f3,f4,f5,f6,f7,f8,f9;

    Breadboard ALU(a,b,c,d,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9);

    initial begin
        // Print the header for the truth table
        $display("W X Y Z | r0 r1 r2 r3 r4 r5 r6 r7 r8 r9");
        $display("-----------------------------------------");

        // The Stimulus: Loop 16 times for all 4-bit combinations
        for (i = 0; i < 16; i = i + 1) begin
            
            // Assign bits of i to inputs and wait for logic to settle
            {a, b, c, d} = i[3:0]; 
            #1; 
            
            // Display the result in the terminal
            $display("%b %b %b %b |  %b  %b  %b  %b  %b  %b  %b  %b  %b  %b", 
                     a, b, c, d, f0, f1, f2, f3, f4, f5, f6, f7, f8, f9);
        end
        $finish; // Ends the simulation
    end

endmodule

/*

Equations from truthtable:

f0: x'y'z'+wy'z'+w'xz+wx'y
f1: w'y'+xz'+wx'z+wyz
f2: w'x'z'+w'xz+xy+wyz
f3: w'yz'+wy'z+w'xy'z'
f4: w'xy'z'+w'xyz+wxyz'+wx'y'z
f5: w'x'z'+w'y'+xy'z+wxyz'
f6: w'x'z'+xy'z+wy'z'+wx'yz
f7: x'y'z+xyz'+wy'z'+wyz
f8: x'y'z+x'yz'+w'xz'+wy'z'+wxyz
f9: w'y'z+wx'yz+xy

*/
