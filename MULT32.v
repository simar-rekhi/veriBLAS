// MULT32.v
// 32-bit Multiplier module
// Structural: utilizes array multiplication and partial products to generate output
// CS 4341 Spring 2026 - ALU Project Phase 2
// Modeled after: https://github.com/Littled58/verilog-multipliers/blob/master/braun_mul.v


// Dev note: this should be changed to compensate for 32-bit, currently is 4-bit

`include "ADD32.v"

module braun_mul(a, b, product);
    input [31:0] a;
    input [31:0] b;
    output [63:0] product;

    wire [31:0] pp0, pp1, pp2, pp3; // partial products
    wire [63:0] sum1, sum2, sum3, sum4;

    // Generate partial products
    assign pp0 = a & {32{b[0]}};
    assign pp1 = a & {32{b[1]}};
    assign pp2 = a & {32{b[2]}};
    assign pp3 = a & {32{b[3]}};
    assign pp4 = a & {32{b[4]}};
    assign pp5 = a & {32{b[5]}};
    assign pp6 = a & {32{b[6]}};
    assign pp7 = a & {32{b[7]}};
    assign pp8 = a & {32{b[8]}};
    assign pp9 = a & {32{b[9]}};
    assign pp10 = a & {32{b[10]}};
    assign pp11 = a & {32{b[11]}};
    assign pp12 = a & {32{b[12]}};
    assign pp13 = a & {32{b[13]}};
    assign pp14 = a & {32{b[14]}};
    assign pp15 = a & {32{b[15]}};
    assign pp16 = a & {32{b[16]}};
    assign pp17 = a & {32{b[17]}};
    assign pp18 = a & {32{b[18]}};
    assign pp19 = a & {32{b[19]}};
    assign pp20 = a & {32{b[20]}};
    assign pp21 = a & {32{b[21]}};
    assign pp22 = a & {32{b[22]}};
    assign pp23 = a & {32{b[23]}};
    assign pp24 = a & {32{b[24]}};
    assign pp25 = a & {32{b[25]}};
    assign pp26 = a & {32{b[26]}};
    assign pp27 = a & {32{b[27]}};
    assign pp28 = a & {32{b[28]}};
    assign pp29 = a & {32{b[29]}};
    assign pp30 = a & {32{b[30]}};
    assign pp31 = a & {32{b[31]}};

    // Shift each partial product and sum them
    assign sum1 = {4'b0000, pp0};           // no shift
    assign sum2 = {3'b000, pp1, 1'b0};      // shift by 1
    assign sum3 = {2'b00, pp2, 2'b00};      // shift by 2
    assign sum4 = {1'b0, pp3, 3'b000};      // shift by 3
    // Needs a bunch more (Sum5-Sum32)

    assign product = sum1 + sum2 + sum3 + sum4 /* Plus all the other ones */;
endmodule