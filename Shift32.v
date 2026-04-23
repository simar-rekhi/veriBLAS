// shift32.v
// 32-bit Bidirectional Barrel Shifter
// Structural: utilizes 5-stage mux network built from gate-level primitives
// CS 4341 Spring 2026 - ALU Project Phase 2
//
// Inputs:
//   A[31:0]    - value to shift
//   shamt[4:0] - shift amount (0-31)
//   dir        - direction: 0 = shift left, 1 = shift right
// Output:
//   Y[31:0]    - shifted result (vacated bits filled with 0)

`include "mux2to1.v"

module shift32 (
    input  [31:0] A,
    input  [4:0]  shamt,
    input         dir,
    output [31:0] Y
);

    // Inter-stage wires: stage 0 input is A, stage 5 output is Y
    wire [31:0] s0, s1, s2, s3, s4;

    // ----------------------------------------------------------------
    // Stage 0: conditional shift by 1
    // ----------------------------------------------------------------
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : stage0

            wire left_src, right_src, shifted;

            // Left-shift source: bit (i-1), or 0 if out of range
            if (i >= 1) begin : ls
                assign left_src = A[i-1];
            end else begin : ls
                assign left_src = 1'b0;
            end

            // Right-shift source: bit (i+1), or 0 if out of range
            if (i + 1 < 32) begin : rs
                assign right_src = A[i+1];
            end else begin : rs
                assign right_src = 1'b0;
            end

            // Select direction
            mux2to1 dm (.a(left_src), .b(right_src), .sel(dir), .out(shifted));
            // Select whether this stage is active
            mux2to1 am (.a(A[i]), .b(shifted), .sel(shamt[0]), .out(s0[i]));

        end
    endgenerate

    // ----------------------------------------------------------------
    // Stage 1: conditional shift by 2
    // ----------------------------------------------------------------
    generate
        for (i = 0; i < 32; i = i + 1) begin : stage1

            wire left_src, right_src, shifted;

            if (i >= 2) begin : ls
                assign left_src = s0[i-2];
            end else begin : ls
                assign left_src = 1'b0;
            end

            if (i + 2 < 32) begin : rs
                assign right_src = s0[i+2];
            end else begin : rs
                assign right_src = 1'b0;
            end

            mux2to1 dm (.a(left_src), .b(right_src), .sel(dir), .out(shifted));
            mux2to1 am (.a(s0[i]), .b(shifted), .sel(shamt[1]), .out(s1[i]));

        end
    endgenerate

    // ----------------------------------------------------------------
    // Stage 2: conditional shift by 4
    // ----------------------------------------------------------------
    generate
        for (i = 0; i < 32; i = i + 1) begin : stage2

            wire left_src, right_src, shifted;

            if (i >= 4) begin : ls
                assign left_src = s1[i-4];
            end else begin : ls
                assign left_src = 1'b0;
            end

            if (i + 4 < 32) begin : rs
                assign right_src = s1[i+4];
            end else begin : rs
                assign right_src = 1'b0;
            end

            mux2to1 dm (.a(left_src), .b(right_src), .sel(dir), .out(shifted));
            mux2to1 am (.a(s1[i]), .b(shifted), .sel(shamt[2]), .out(s2[i]));

        end
    endgenerate

    // ----------------------------------------------------------------
    // Stage 3: conditional shift by 8
    // ----------------------------------------------------------------
    generate
        for (i = 0; i < 32; i = i + 1) begin : stage3

            wire left_src, right_src, shifted;

            if (i >= 8) begin : ls
                assign left_src = s2[i-8];
            end else begin : ls
                assign left_src = 1'b0;
            end

            if (i + 8 < 32) begin : rs
                assign right_src = s2[i+8];
            end else begin : rs
                assign right_src = 1'b0;
            end

            mux2to1 dm (.a(left_src), .b(right_src), .sel(dir), .out(shifted));
            mux2to1 am (.a(s2[i]), .b(shifted), .sel(shamt[3]), .out(s3[i]));

        end
    endgenerate

    // ----------------------------------------------------------------
    // Stage 4: conditional shift by 16
    // ----------------------------------------------------------------
    generate
        for (i = 0; i < 32; i = i + 1) begin : stage4

            wire left_src, right_src, shifted;

            if (i >= 16) begin : ls
                assign left_src = s3[i-16];
            end else begin : ls
                assign left_src = 1'b0;
            end

            if (i + 16 < 32) begin : rs
                assign right_src = s3[i+16];
            end else begin : rs
                assign right_src = 1'b0;
            end

            mux2to1 dm (.a(left_src), .b(right_src), .sel(dir), .out(shifted));
            mux2to1 am (.a(s3[i]), .b(shifted), .sel(shamt[4]), .out(s4[i]));

        end
    endgenerate

    // Final output
    assign Y = s4;

endmodule
