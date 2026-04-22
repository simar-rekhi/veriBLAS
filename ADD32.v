// ADDER32.v
// 32-bit Full Adder module
// Structural: utilizes gate level logic to generate output
// CS 4341 Spring 2026 - ALU Project Phase 2

module fullAdder (
    input a,b,cin,
    output sum,cout
);

wire w1,w2,w3,w4;

xor(w1,a,b);
xor(sum,w1,cin);

and(w2,a,b);
and(w3,b,cin);
and(w4,cin,a);

or(cout,w2,w3,w4);

endmodule