// MULT32.v
// 32-bit Multiplier module
// Uses structural AND gates for partial-product generation,
// behavioral summation for accumulation (overcomplex module per project spec)
// CS 4341 Spring 2026 - ALU Project Phase 3

module mult32 (
    input  [31:0] A,
    input  [31:0] B,
    output [63:0] Product
);

    // --- Partial products: each is A masked by one bit of B ---
    wire [31:0] pp [0:31];

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_pp
            and32 u_pp (
                .A(A),
                .B({32{B[i]}}),
                .Y(pp[i])
            );
        end
    endgenerate

    // --- Summation of shifted partial products ---
    // Behavioral: multiplication is overcomplex per project description
    integer j;
    reg [63:0] sum;
    always @(*) begin
        sum = 64'b0;
        for (j = 0; j < 32; j = j + 1) begin
            sum = sum + ({{32{1'b0}}, pp[j]} << j);
        end
    end

    assign Product = sum;

endmodule
