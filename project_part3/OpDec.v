// OpDec.v
// 4-to-16 Decoder
// Structural: uses NOT and AND gate primitives
// Converts 4-bit opcode into 16-bit one-hot Operation Channel
// CS 4341 Spring 2026 - ALU Project Phase 3

module opdec (
    input  [3:0]  OpCode,
    output [15:0] Channel
);

    // Inverted opcode bits
    wire n3, n2, n1, n0;

    not (n3, OpCode[3]);
    not (n2, OpCode[2]);
    not (n1, OpCode[1]);
    not (n0, OpCode[0]);

    // Each output is a unique minterm of the 4 opcode bits
    and (Channel[0],  n3,        n2,        n1,        n0);        // 0000
    and (Channel[1],  n3,        n2,        n1,        OpCode[0]); // 0001
    and (Channel[2],  n3,        n2,        OpCode[1], n0);        // 0010
    and (Channel[3],  n3,        n2,        OpCode[1], OpCode[0]); // 0011
    and (Channel[4],  n3,        OpCode[2], n1,        n0);        // 0100
    and (Channel[5],  n3,        OpCode[2], n1,        OpCode[0]); // 0101
    and (Channel[6],  n3,        OpCode[2], OpCode[1], n0);        // 0110
    and (Channel[7],  n3,        OpCode[2], OpCode[1], OpCode[0]); // 0111
    and (Channel[8],  OpCode[3], n2,        n1,        n0);        // 1000
    and (Channel[9],  OpCode[3], n2,        n1,        OpCode[0]); // 1001
    and (Channel[10], OpCode[3], n2,        OpCode[1], n0);        // 1010
    and (Channel[11], OpCode[3], n2,        OpCode[1], OpCode[0]); // 1011
    and (Channel[12], OpCode[3], OpCode[2], n1,        n0);        // 1100
    and (Channel[13], OpCode[3], OpCode[2], n1,        OpCode[0]); // 1101
    and (Channel[14], OpCode[3], OpCode[2], OpCode[1], n0);        // 1110
    and (Channel[15], OpCode[3], OpCode[2], OpCode[1], OpCode[0]); // 1111

endmodule
