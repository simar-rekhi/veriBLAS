// nor32.v
// 32-bit bitwise nor module
// Structural: instantiates 32 individual 1-bit NOR gate primitives
// CS 4341 Spring 2026 - ALU Project Phase 3

module nor32 (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Y
);

    nor g0  (Y[0],  A[0],  B[0]);
    nor g1  (Y[1],  A[1],  B[1]);
    nor g2  (Y[2],  A[2],  B[2]);
    nor g3  (Y[3],  A[3],  B[3]);
    nor g4  (Y[4],  A[4],  B[4]);
    nor g5  (Y[5],  A[5],  B[5]);
    nor g6  (Y[6],  A[6],  B[6]);
    nor g7  (Y[7],  A[7],  B[7]);
    nor g8  (Y[8],  A[8],  B[8]);
    nor g9  (Y[9],  A[9],  B[9]);
    nor g10 (Y[10], A[10], B[10]);
    nor g11 (Y[11], A[11], B[11]);
    nor g12 (Y[12], A[12], B[12]);
    nor g13 (Y[13], A[13], B[13]);
    nor g14 (Y[14], A[14], B[14]);
    nor g15 (Y[15], A[15], B[15]);
    nor g16 (Y[16], A[16], B[16]);
    nor g17 (Y[17], A[17], B[17]);
    nor g18 (Y[18], A[18], B[18]);
    nor g19 (Y[19], A[19], B[19]);
    nor g20 (Y[20], A[20], B[20]);
    nor g21 (Y[21], A[21], B[21]);
    nor g22 (Y[22], A[22], B[22]);
    nor g23 (Y[23], A[23], B[23]);
    nor g24 (Y[24], A[24], B[24]);
    nor g25 (Y[25], A[25], B[25]);
    nor g26 (Y[26], A[26], B[26]);
    nor g27 (Y[27], A[27], B[27]);
    nor g28 (Y[28], A[28], B[28]);
    nor g29 (Y[29], A[29], B[29]);
    nor g30 (Y[30], A[30], B[30]);
    nor g31 (Y[31], A[31], B[31]);

endmodule
