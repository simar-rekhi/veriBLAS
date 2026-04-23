// neg32.v
// 32-bit Binary Negation (Two's Complement) module
// Structural: utilizes not32 to invert bits, then adder32 to add 1
// Result = ~A + 1 = -A
// CS 4341 Spring 2026 - ALU Project Phase 2

// Requires: ADD32.v (fullAdder), adder32.v, not32.v

module neg32 (
    input  [31:0] A,
    output [31:0] Y,
    output        Cout   // overflow indicator
);

    wire [31:0] inverted;

    // Step 1: bitwise invert A
    not32 u_inv (
        .A (A),
        .Y (inverted)
    );

    // Step 2: add 1 by setting Cin = 1 and B = 0
    adder32 u_add (
        .A   (inverted),
        .B   (32'b0),
        .Cin (1'b1),
        .Sum (Y),
        .Cout(Cout)
    );

endmodule
