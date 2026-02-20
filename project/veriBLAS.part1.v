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
    N. Mateo Garcia (IDE: VSCode; Compiler: iVerilog via VSCode extension / Windows Terminal; no external tools used)
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
    //
    // Dev Note: I was originally going to predefine the
    // minterms, but there is a lot of them needed so it'll
    // be directly defined instead. Maybe at a later date,
    // when more minterms are required, I'll go through and
    // redefine the results with them.

    r0 = (~x&~y&~z)|(w&~y&~z)|(~w&x&z)|(w&~x&y);
    r1 = (~w&~y)|(x&~z)|(w&~x)|(w&y&z);
    r2 = (~w&~x&~z)|(~w&x&z)|(x&y)|(w&y&z);
    r3 = (~w&y&~z)|(w&~y&z)|(~w&x&~y&~z);
    r4 = (~w&x&~y&~z)|(~w&x&y&z)|(w&x&y&~z)|(w&~x&~y&z);
    r5 = (~w&~x&~z)|(~w&~y)|(x&~y&z)|(w&x&y&~z);
    r6 = (~w&~x&~z)|(x&~y&z)|(w&~y&~z)|(w&~x&y&z);
    r7 = (~x&~y&z)|(x&y&~z)|(w&~y&~z)|(w&y&z);
    r8 = (~x&~y&z)|(~x&y&~z)|(~w&x&~z)|(w&~y&~z)|(w&x&y&z);
     r9 = (~w&~y&~z)|(w&~x&y&z)|(x&y);



    end

endmodule

// Testbench Module with the Stimulus requirement
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
