// Div32.v
// 32-bit Integer Division module
// Behavioral: Long division is overcomplex per project description
// Produces quotient of A / B; sets error flag on divide-by-zero
// CS 4341 Spring 2026 - ALU Project Phase 3

module div32 (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Y,
    output        DivError   // high when B == 0 (divide by zero)
);

    assign DivError = (B == 32'b0);
    assign Y = (B == 32'b0) ? 32'hFFFFFFFF : A / B;

endmodule
