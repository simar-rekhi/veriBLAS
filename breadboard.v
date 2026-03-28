// breadboard.v
// Breadboard module for AND operation
// Accepts: two 32-bit operands, 4-bit opcode, clock, reset
// Produces: 32-bit result stored in accumulator register, status flags
// Opcode 1010 = AND
// CS 4341 Spring 2026 - ALU Project Phase 2

module breadboard (
    input             CLK,
    input             RST,
    input      [31:0] A,
    input      [31:0] B,
    input      [3:0]  OPCODE,
    output     [31:0] RESULT,
    output            flag_zero,
    output            flag_negative,
    output            flag_error
);

    // --- Interface wire: connects and32 output to DFF input ---
    wire [31:0] and_out;
    wire [31:0] acc_in;

    // --- AND module (structural gate-level) ---
    and32 u_and (
        .A(A),
        .B(B),
        .Y(and_out)
    );

    // --- Opcode check: only pass and_out through if OPCODE == 1010 ---
    // If opcode does not match, feed 0 to accumulator
    assign acc_in = (OPCODE == 4'b1010) ? and_out : 32'b0;

    // --- Accumulator register (32-bit DFF) ---
    // Stores result on rising clock edge
    reg [31:0] acc;
    always @(posedge CLK) begin
        if (RST)
            acc <= 32'b0;
        else
            acc <= acc_in;
    end

    // --- Outputs ---
    assign RESULT        = acc;
    assign flag_zero     = (acc == 32'b0);
    assign flag_negative = acc[31];

    // Error: opcode sent was not AND (1010)
    assign flag_error    = (OPCODE != 4'b1010);

endmodule
