// and32.v
// 32-bit bitwise AND module
// Structural: instantiates 32 individual 1-bit AND gate primitives
// CS 4341 Spring 2026 - ALU Project Phase 2

module and32 (
    input  [31:0] A,
    input  [31:0] B,
    output [31:0] Y
);

    and g0  (Y[0],  A[0],  B[0]);
    and g1  (Y[1],  A[1],  B[1]);
    and g2  (Y[2],  A[2],  B[2]);
    and g3  (Y[3],  A[3],  B[3]);
    and g4  (Y[4],  A[4],  B[4]);
    and g5  (Y[5],  A[5],  B[5]);
    and g6  (Y[6],  A[6],  B[6]);
    and g7  (Y[7],  A[7],  B[7]);
    and g8  (Y[8],  A[8],  B[8]);
    and g9  (Y[9],  A[9],  B[9]);
    and g10 (Y[10], A[10], B[10]);
    and g11 (Y[11], A[11], B[11]);
    and g12 (Y[12], A[12], B[12]);
    and g13 (Y[13], A[13], B[13]);
    and g14 (Y[14], A[14], B[14]);
    and g15 (Y[15], A[15], B[15]);
    and g16 (Y[16], A[16], B[16]);
    and g17 (Y[17], A[17], B[17]);
    and g18 (Y[18], A[18], B[18]);
    and g19 (Y[19], A[19], B[19]);
    and g20 (Y[20], A[20], B[20]);
    and g21 (Y[21], A[21], B[21]);
    and g22 (Y[22], A[22], B[22]);
    and g23 (Y[23], A[23], B[23]);
    and g24 (Y[24], A[24], B[24]);
    and g25 (Y[25], A[25], B[25]);
    and g26 (Y[26], A[26], B[26]);
    and g27 (Y[27], A[27], B[27]);
    and g28 (Y[28], A[28], B[28]);
    and g29 (Y[29], A[29], B[29]);
    and g30 (Y[30], A[30], B[30]);
    and g31 (Y[31], A[31], B[31]);

endmodule
