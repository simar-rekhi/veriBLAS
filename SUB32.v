// SUB32.v
// 32-bit Full Subtractor module
// Structural: utilizes gate level logic to generate output
// CS 4341 Spring 2026 - ALU Project Phase 2

module fullAdder (
    input a,b,cin,
    output diff,bout
);

wire w1,w2,w3,w4,w5;

xor(w1,a,b);
xor(diff,w1,bin);

not(w2,a);
and(w3,w2,b);
not(w4,w1);
and(w5,w1,bin);

or(bout,w5,w3);

endmodule