// Add32.v
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

module add32 (
    input  [31:0] A,
    input  [31:0] B,
    input         Cin,
    output [31:0] Sum,
    output        Cout
);

    wire [32:0] carry; // internal carry chain
    assign carry[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : fa
            fullAdder u_fa (
                .a   (A[i]),
                .b   (B[i]),
                .cin (carry[i]),
                .sum (Sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign Cout = carry[32];

endmodule
