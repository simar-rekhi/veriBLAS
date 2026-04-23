// ALU32.v
// 32-bit Arithmetic Logic Unit - Top Level
// Connects all operation modules and selects output via opcode
// CS 4341 Spring 2026 - ALU Project Phase 2
//
// Opcode Table:
//   4'b0000  ->  ADD    (A + B)
//   4'b0001  ->  SUB    (A - B)
//   4'b0010  ->  MUL    (A * B)  [lower 32 bits of 64-bit product]
//   4'b0011  ->  NAND   (~(A & B))
//   4'b0100  ->  OR     (A | B)
//   4'b0101  ->  NOT    (~A)
//   4'b0110  ->  XOR    (A ^ B)
//   4'b0111  ->  XNOR   (~(A ^ B))
//   default  ->  32'b0

`include "ADD32.v"
`include "adder32.v"
`include "sub32.v"
`include "MULT32.v"
`include "nand32.v"
`include "not32.v"
`include "or32.v"
`include "xor32.v"
`include "xnor32.v"

module ALU32 (
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  opcode,
    output reg [31:0] Result,
    output reg        Cout,    // carry-out / borrow-out (valid for ADD/SUB)
    output        Zero         // high when Result == 0
);

    // ---- internal wires for each operation ----

    // ADD
    wire [31:0] add_result;
    wire        add_cout;

    // SUB
    wire [31:0] sub_result;
    wire        sub_bout;

    // MUL
    wire [63:0] mul_product;

    // NAND
    wire [31:0] nand_result;

    // OR
    wire [31:0] or_result;

    // NOT
    wire [31:0] not_result;

    // XOR
    wire [31:0] xor_result;

    // XNOR
    wire [31:0] xnor_result;


    // ---- instantiate every operation module ----

    adder32 u_add (
        .A   (A),
        .B   (B),
        .Cin (1'b0),
        .Sum (add_result),
        .Cout(add_cout)
    );

    sub32 u_sub (
        .A    (A),
        .B    (B),
        .Bin  (1'b0),
        .Diff (sub_result),
        .Bout (sub_bout)
    );

    braun_mul u_mul (
        .a       (A),
        .b       (B),
        .product (mul_product)
    );

    nand32 u_nand (
        .A (A),
        .B (B),
        .Y (nand_result)
    );

    or32 u_or (
        .A (A),
        .B (B),
        .Y (or_result)
    );

    not32 u_not (
        .A (A),
        .Y (not_result)
    );

    xor32 u_xor (
        .A (A),
        .B (B),
        .Y (xor_result)
    );

    xnor32 u_xnor (
        .A (A),
        .B (B),
        .Y (xnor_result)
    );


    // ---- opcode mux ----

    always @(*) begin
        Cout = 1'b0; // default
        case (opcode)
            4'b0000: begin  // ADD
                Result = add_result;
                Cout   = add_cout;
            end
            4'b0001: begin  // SUB
                Result = sub_result;
                Cout   = sub_bout;
            end
            4'b0010: begin  // MUL (lower 32 bits)
                Result = mul_product[31:0];
            end
            4'b0011: begin  // NAND
                Result = nand_result;
            end
            4'b0100: begin  // OR
                Result = or_result;
            end
            4'b0101: begin  // NOT (on A only)
                Result = not_result;
            end
            4'b0110: begin  // XOR
                Result = xor_result;
            end
            4'b0111: begin  // XNOR
                Result = xnor_result;
            end
            default: begin
                Result = 32'b0;
            end
        endcase
    end

    // ---- zero flag ----
    assign Zero = (Result == 32'b0);

endmodule
