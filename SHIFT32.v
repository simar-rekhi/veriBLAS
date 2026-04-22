// SHIFT32.v
// 32-bit Shift module
// Structural: utilizes linked D flip flops and gate logic to generate output
// CS 4341 Spring 2026 - ALU Project Phase 2

module dFlipFlop(clk, D, Q, Qn)
    input   clk;
    input [31:0] D;

    output [31:0] Q;
    output [31:0] Qn;


endmodule

module shift(a, dir, clk, out)
    input [31:0] a;
    input [1:0] dir;    // 0 for left, 1 for right
    input       clk;

    output [31:0] out;




endmodule