// sub32.v
// 32-bit Ripple Borrow Subtractor
// Structural: chains 32 instances of a 1-bit fullSubtractor
// CS 4341 Spring 2026 - ALU Project Phase 2
//
// NOTE: The original SUB32.v had several bugs that are fixed here:
//   1. Module was named "fullAdder" instead of "fullSubtractor"
//   2. Port list declared "cin" but body used "bin" (borrow-in)
//   3. Missing wire w5 usage was inconsistent
//
// Fixed 1-bit full subtractor:

module fullSubtractor (
    input  a, b, bin,
    output diff, bout
);
    wire w1, w2, w3, w4, w5;

    xor (w1, a, b);
    xor (diff, w1, bin);
    not (w2, a);
    and (w3, w2, b);
    not (w4, w1);
    and (w5, w4, bin);
    or  (bout, w5, w3);
endmodule


// 32-bit subtractor: chains 32 fullSubtractor instances
module sub32 (
    input  [31:0] A,
    input  [31:0] B,
    input         Bin,
    output [31:0] Diff,
    output        Bout
);

    wire [32:0] borrow;
    assign borrow[0] = Bin;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : fs
            fullSubtractor u_fs (
                .a    (A[i]),
                .b    (B[i]),
                .bin  (borrow[i]),
                .diff (Diff[i]),
                .bout (borrow[i+1])
            );
        end
    endgenerate

    assign Bout = borrow[32];

endmodule
