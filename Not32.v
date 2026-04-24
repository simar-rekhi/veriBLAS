// not32.v
// 32-bit bitwise not module
// Structural: instantiates 32 individual 1-bit not gate primitives
// CS 4341 Spring 2026 - ALU Project Phase 2

module not32 (
    input  [31:0] A,
    output [31:0] Y
);

    not g0  (Y[0],  A[0]);
    not g1  (Y[1],  A[1]);
    not g2  (Y[2],  A[2]);
    not g3  (Y[3],  A[3]);
    not g4  (Y[4],  A[4]);
    not g5  (Y[5],  A[5]);
    not g6  (Y[6],  A[6]);
    not g7  (Y[7],  A[7]);
    not g8  (Y[8],  A[8]);
    not g9  (Y[9],  A[9]);
    not g10 (Y[10], A[10]);
    not g11 (Y[11], A[11]);
    not g12 (Y[12], A[12]);
    not g13 (Y[13], A[13]);
    not g14 (Y[14], A[14]);
    not g15 (Y[15], A[15]);
    not g16 (Y[16], A[16]);
    not g17 (Y[17], A[17]);
    not g18 (Y[18], A[18]);
    not g19 (Y[19], A[19]);
    not g20 (Y[20], A[20]);
    not g21 (Y[21], A[21]);
    not g22 (Y[22], A[22]);
    not g23 (Y[23], A[23]);
    not g24 (Y[24], A[24]);
    not g25 (Y[25], A[25]);
    not g26 (Y[26], A[26]);
    not g27 (Y[27], A[27]);
    not g28 (Y[28], A[28]);
    not g29 (Y[29], A[29]);
    not g30 (Y[30], A[30]);
    not g31 (Y[31], A[31]);

endmodule
