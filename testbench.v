// testbench.v
// Testbench for AND breadboard module
// Sends opcodes and operands to breadboard on each clock cycle
// Prints: opcode loaded, input values, result, status flags
// CS 4341 Spring 2026 - ALU Project Phase 2

`timescale 1ns/1ps

module testbench;

    // --- Inputs to breadboard ---
    reg        CLK;
    reg        RST;
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0]  OPCODE;

    // --- Outputs from breadboard ---
    wire [31:0] RESULT;
    wire        flag_zero;
    wire        flag_negative;
    wire        flag_error;

    // --- Instantiate breadboard ---
    breadboard uut (
        .CLK         (CLK),
        .RST         (RST),
        .A           (A),
        .B           (B),
        .OPCODE      (OPCODE),
        .RESULT      (RESULT),
        .flag_zero   (flag_zero),
        .flag_negative(flag_negative),
        .flag_error  (flag_error)
    );

    // --- Clock: 10ns period ---
    initial CLK = 0;
    always #5 CLK = ~CLK;

    // --- Task: send one command, wait one clock, print result ---
    task send_cmd;
        input [31:0] in_a;
        input [31:0] in_b;
        input [3:0]  op;
        begin
            A      = in_a;
            B      = in_b;
            OPCODE = op;

            $display("  Loading opcode: %b | A = 0x%08h | B = 0x%08h", op, in_a, in_b);

            @(posedge CLK); #1;

            $display("  Result:         RESULT = 0x%08h | Zero = %b | Neg = %b | Error = %b",
                     RESULT, flag_zero, flag_negative, flag_error);

            if (flag_error)
                $display("  [ERROR] Opcode %b is not AND (1010). Result is undefined.", op);

            $display("");
        end
    endtask

    // --- Test sequence ---
    initial begin
        $display("========================================");
        $display("  CS 4341 ALU Phase 2 - AND Gate Test  ");
        $display("  Opcode 1010 = AND                    ");
        $display("========================================");
        $display("");

        // Reset
        RST = 1; A = 0; B = 0; OPCODE = 4'b1010;
        @(posedge CLK); #1;
        RST = 0;
        $display("-- Reset released --");
        $display("");

        // Test 1: all ones AND alternating pattern
        $display("Test 1: 0xFFFFFFFF AND 0x0F0F0F0F => expect 0x0F0F0F0F");
        send_cmd(32'hFFFFFFFF, 32'h0F0F0F0F, 4'b1010);

        // Test 2: complementary inputs -> zero result, zero flag set
        $display("Test 2: 0xAAAAAAAA AND 0x55555555 => expect 0x00000000 (zero flag)");
        send_cmd(32'hAAAAAAAA, 32'h55555555, 4'b1010);

        // Test 3: identity (AND with all ones)
        $display("Test 3: 0x12345678 AND 0xFFFFFFFF => expect 0x12345678");
        send_cmd(32'h12345678, 32'hFFFFFFFF, 4'b1010);

        // Test 4: both operands same
        $display("Test 4: 0xDEADBEEF AND 0xDEADBEEF => expect 0xDEADBEEF (negative flag)");
        send_cmd(32'hDEADBEEF, 32'hDEADBEEF, 4'b1010);

        // Test 5: A = 0, result must be zero regardless of B
        $display("Test 5: 0x00000000 AND 0xFFFFFFFF => expect 0x00000000 (zero flag)");
        send_cmd(32'h00000000, 32'hFFFFFFFF, 4'b1010);

        // Test 6: wrong opcode — error flag should trigger
        $display("Test 6: Wrong opcode 0000 (ADD) sent to AND breadboard => error flag");
        send_cmd(32'hFFFFFFFF, 32'hFFFFFFFF, 4'b0000);

        $display("========================================");
        $display("  Test sequence complete.              ");
        $display("========================================");
        $finish;
    end

endmodule
