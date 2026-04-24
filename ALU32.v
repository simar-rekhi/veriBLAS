// breadboard.v
// VeriBLAS Breadboard Module
// Matches the Component Diagram from the System Design document
// Accepts: two 32-bit operands, 4-bit opcode, clock, reset
// Produces: 32-bit result stored in accumulator register, status flags
//
// OpCode Table (from System Design):
//   0000 = NOP         (repeat previous value)
//   0001 = Add         (A + B)
//   0010 = Mult        (A * B)
//   0011 = Sub         (A - B)
//   0100 = XOR         (A ^ B)
//   0101 = AND         (A & B)
//   0110 = Div         (A / B) **behavioral
//   0111 = OR          (A | B)
//   1000 = Mod         (A % B) **behavioral
//   1001 = Shift R     (A >> 1)
//   1010 = XNOR        ~(A ^ B)
//   1011 = Shift L     (A << 1)
//   1100 = NOT         (~A)
//   1101 = Negation    (-A) **behavioral
//   1110 = NAND        ~(A & B)
//   1111 = NOR         ~(A | B)
//
// CS 4341 Spring 2026 - ALU Project Phase 3

// --- Include all component modules ---
`include "Add32.v"
`include "Adder32.v"
`include "Sub32.v"
`include "Mult32.v"
`include "Div32.v"
`include "Mod32.v"
`include "And32.v"
`include "Or32.v"
`include "Xor32.v"
`include "Not32.v"
`include "Nand32.v"
`include "Nor32.v"
`include "Xnor32.v"
`include "Neg32.v"
`include "Shift32.v"
`include "OpDec.v"
`include "CtrlMux.v"
`include "Reg32.v"

module breadboard (
    // --- Inputs (per System Design Input List) ---
    input             CLK,        // Clock, 1-bit
    input             RST,        // Reset, 1-bit (high = reset)
    input      [31:0] OperandA,   // Operand A, 32-bits
    input      [31:0] OperandB,   // Operand B, 32-bits
    input      [3:0]  OpCode,     // OpCode, 4-bits

    // --- Output (per System Design Output List) ---
    output     [31:0] OpResult,   // 32-bit result from register

    // --- Status Flags ---
    output            flag_zero,
    output            flag_negative,
    output            flag_carry,
    output            flag_overflow,
    output            flag_error
);

    // =========================================================
    // Interface Wires (per System Design Interface List)
    // =========================================================

    // Operation Channel: 16-bits, connects OpDec and CtrlMux
    wire [15:0] OperationChannel;

    // CtrlMux b: 32-bits, connects CtrlMux and Reg
    wire [31:0] CtrlMuxB;

    // Accumulator: 32-bits, connects Reg output back to CtrlMux (NOP channel)
    wire [31:0] Accumulator;

    // --- Channel wires: each connects an operation module to CtrlMux ---
    wire [31:0] AddChannel;        // Ch1:  Add -> CtrlMux
    wire [31:0] MultChannel;       // Ch2:  Mult -> CtrlMux
    wire [31:0] SubChannel;        // Ch3:  Sub -> CtrlMux
    wire [31:0] XORChannel;        // Ch4:  XOR -> CtrlMux
    wire [31:0] ANDChannel;        // Ch5:  AND -> CtrlMux
    wire [31:0] DivChannel;        // Ch6:  Div -> CtrlMux
    wire [31:0] ORChannel;         // Ch7:  OR -> CtrlMux
    wire [31:0] ModChannel;        // Ch8:  Mod -> CtrlMux
    wire [31:0] ShiftRChannel;     // Ch9:  ShiftR -> CtrlMux
    wire [31:0] XNORChannel;       // Ch10: XNOR -> CtrlMux
    wire [31:0] ShiftLChannel;     // Ch11: ShiftL -> CtrlMux
    wire [31:0] NOTChannel;        // Ch12: NOT -> CtrlMux
    wire [31:0] NegationChannel;   // Ch13: Neg -> CtrlMux
    wire [31:0] NANDChannel;       // Ch14: NAND -> CtrlMux
    wire [31:0] NORChannel;        // Ch15: NOR -> CtrlMux

    // --- Extra status wires ---
    wire        add_cout;          // carry from adder
    wire        sub_bout;          // borrow from subtractor
    wire [63:0] mult_product;      // full 64-bit product
    wire        neg_cout;          // negation overflow
    wire        div_error;         // divide by zero
    wire        mod_error;         // mod by zero

    // =========================================================
    // Component Instantiations (per System Design Parts List)
    // =========================================================

    // --- Add: 32-bit Adder (structural, ripple carry) ---
    adder32 u_add (
        .A    (OperandA),
        .B    (OperandB),
        .Cin  (1'b0),
        .Sum  (AddChannel),
        .Cout (add_cout)
    );

    // --- Sub: 32-bit Subtractor (structural, ripple borrow) ---
    sub32 u_sub (
        .A    (OperandA),
        .B    (OperandB),
        .Bin  (1'b0),
        .Diff (SubChannel),
        .Bout (sub_bout)
    );

    // --- Mult: 32-bit Multiplier (partial products + behavioral sum) ---
    mult32 u_mult (
        .A       (OperandA),
        .B       (OperandB),
        .Product (mult_product)
    );
    assign MultChannel = mult_product[31:0]; // lower 32 bits

    // --- Div: 32-bit Divider (behavioral, overcomplex) ---
    div32 u_div (
        .A        (OperandA),
        .B        (OperandB),
        .Y        (DivChannel),
        .DivError (div_error)
    );

    // --- Mod: 32-bit Modulus (behavioral, overcomplex) ---
    mod32 u_mod (
        .A        (OperandA),
        .B        (OperandB),
        .Y        (ModChannel),
        .ModError (mod_error)
    );

    // --- OR: 32-bit bitwise OR (structural) ---
    or32 u_or (
        .A (OperandA),
        .B (OperandB),
        .Y (ORChannel)
    );

    // --- AND: 32-bit bitwise AND (structural) ---
    and32 u_and (
        .A (OperandA),
        .B (OperandB),
        .Y (ANDChannel)
    );

    // --- XOR: 32-bit bitwise XOR (structural) ---
    xor32 u_xor (
        .A (OperandA),
        .B (OperandB),
        .Y (XORChannel)
    );

    // --- NOT: 32-bit bitwise NOT (structural, operates on A only) ---
    not32 u_not (
        .A (OperandA),
        .Y (NOTChannel)
    );

    // --- Negation: 32-bit two's complement negation (structural) ---
    neg32 u_neg (
        .A    (OperandA),
        .Y    (NegationChannel),
        .Cout (neg_cout)
    );

    // --- NOR: 32-bit bitwise NOR (structural) ---
    nor32 u_nor (
        .A (OperandA),
        .B (OperandB),
        .Y (NORChannel)
    );

    // --- NAND: 32-bit bitwise NAND (structural) ---
    nand32 u_nand (
        .A (OperandA),
        .B (OperandB),
        .Y (NANDChannel)
    );

    // --- XNOR: 32-bit bitwise XNOR (structural) ---
    xnor32 u_xnor (
        .A (OperandA),
        .B (OperandB),
        .Y (XNORChannel)
    );

    // --- Shift L: 32-bit Left Shift by 1 (structural, DFF + gate logic) ---
    shift u_shiftl (
        .a   (OperandA),
        .dir (2'b00),          // dir = 0: left shift
        .clk (CLK),
        .out (ShiftLChannel)
    );

    // --- Shift R: 32-bit Right Shift by 1 (structural, DFF + gate logic) ---
    shift u_shiftr (
        .a   (OperandA),
        .dir (2'b01),          // dir = 1: right shift
        .clk (CLK),
        .out (ShiftRChannel)
    );

    // --- OpDec: 4-to-16 Decoder (structural) ---
    opdec u_opdec (
        .OpCode  (OpCode),
        .Channel (OperationChannel)
    );

    // --- CtrlMux: 16x1 Multiplexer, 32-bit wide (structural) ---
    ctrlmux u_ctrlmux (
        .Sel  (OperationChannel),
        .Ch0  (Accumulator),       // NOP: feed back accumulator
        .Ch1  (AddChannel),
        .Ch2  (MultChannel),
        .Ch3  (SubChannel),
        .Ch4  (XORChannel),
        .Ch5  (ANDChannel),
        .Ch6  (DivChannel),
        .Ch7  (ORChannel),
        .Ch8  (ModChannel),
        .Ch9  (ShiftRChannel),
        .Ch10 (XNORChannel),
        .Ch11 (ShiftLChannel),
        .Ch12 (NOTChannel),
        .Ch13 (NegationChannel),
        .Ch14 (NANDChannel),
        .Ch15 (NORChannel),
        .Y    (CtrlMuxB)
    );

    // --- Reg: 32-bit Memory Register (DFF-based) ---
    reg32 u_reg (
        .D   (CtrlMuxB),
        .CLK (CLK),
        .RST (RST),
        .Q   (Accumulator)
    );

    // =========================================================
    // Outputs
    // =========================================================

    // OpResult comes from the register output
    assign OpResult = Accumulator;

    // --- Status Flags ---
    assign flag_zero     = (Accumulator == 32'b0);
    assign flag_negative = Accumulator[31];
    assign flag_carry    = (OpCode == 4'b0001) ? add_cout :
                           (OpCode == 4'b0011) ? sub_bout : 1'b0;
    assign flag_overflow = (OpCode == 4'b0001) ?
                           (OperandA[31] == OperandB[31]) && (Accumulator[31] != OperandA[31]) :
                           (OpCode == 4'b0011) ?
                           (OperandA[31] != OperandB[31]) && (Accumulator[31] != OperandA[31]) :
                           1'b0;
    assign flag_error    = (OpCode == 4'b0110) ? div_error :
                           (OpCode == 4'b1000) ? mod_error : 1'b0;

endmodule
