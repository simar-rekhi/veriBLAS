// adder32.v
// 32-bit Ripple Carry Adder
// Structural: chains 32 instances of the 1-bit fullAdder from ADD32.v
// CS 4341 Spring 2026 - ALU Project Phase 2

module adder32 (
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
