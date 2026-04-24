// CtrlMux.v
// 16-to-1 Multiplexer, 32-bit wide
// Structural: uses AND and OR gate primitives
// Selects one of 16 32-bit channels based on 16-bit one-hot select
// CS 4341 Spring 2026 - ALU Project Phase 3

module ctrlmux (
    input  [15:0] Sel,       // one-hot select from OpDec
    input  [31:0] Ch0,       // Channel 0:  NOP (accumulator feedback)
    input  [31:0] Ch1,       // Channel 1:  Add
    input  [31:0] Ch2,       // Channel 2:  Mult
    input  [31:0] Ch3,       // Channel 3:  Sub
    input  [31:0] Ch4,       // Channel 4:  XOR
    input  [31:0] Ch5,       // Channel 5:  AND
    input  [31:0] Ch6,       // Channel 6:  Div
    input  [31:0] Ch7,       // Channel 7:  OR
    input  [31:0] Ch8,       // Channel 8:  Mod
    input  [31:0] Ch9,       // Channel 9:  Shift R
    input  [31:0] Ch10,      // Channel 10: XNOR
    input  [31:0] Ch11,      // Channel 11: Shift L
    input  [31:0] Ch12,      // Channel 12: NOT
    input  [31:0] Ch13,      // Channel 13: Negation
    input  [31:0] Ch14,      // Channel 14: NAND
    input  [31:0] Ch15,      // Channel 15: NOR
    output [31:0] Y          // selected output
);

    // For each output bit: AND each channel bit with its select line,
    // then OR all 16 results together
    genvar k;
    generate
        for (k = 0; k < 32; k = k + 1) begin : mux_bit
            wire m0, m1, m2, m3, m4, m5, m6, m7;
            wire m8, m9, m10, m11, m12, m13, m14, m15;

            and (m0,  Sel[0],  Ch0[k]);
            and (m1,  Sel[1],  Ch1[k]);
            and (m2,  Sel[2],  Ch2[k]);
            and (m3,  Sel[3],  Ch3[k]);
            and (m4,  Sel[4],  Ch4[k]);
            and (m5,  Sel[5],  Ch5[k]);
            and (m6,  Sel[6],  Ch6[k]);
            and (m7,  Sel[7],  Ch7[k]);
            and (m8,  Sel[8],  Ch8[k]);
            and (m9,  Sel[9],  Ch9[k]);
            and (m10, Sel[10], Ch10[k]);
            and (m11, Sel[11], Ch11[k]);
            and (m12, Sel[12], Ch12[k]);
            and (m13, Sel[13], Ch13[k]);
            and (m14, Sel[14], Ch14[k]);
            and (m15, Sel[15], Ch15[k]);

            or (Y[k], m0, m1, m2, m3, m4, m5, m6, m7,
                       m8, m9, m10, m11, m12, m13, m14, m15);
        end
    endgenerate

endmodule
