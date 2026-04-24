// Mod32.v
// 32-bit Modulus module
// Behavioral: Modulus is overcomplex per project description
// Produces remainder of A % B; sets error flag on mod-by-zero
// CS 4341 Spring 2026 - ALU Project Phase 3

module mod32 (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Y,
    output        ModError   // high when B == 0
);

    assign ModError = (B == 32'b0);
    assign Y = (B == 32'b0) ? 32'hFFFFFFFF : A % B;

endmodule
