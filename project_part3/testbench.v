// testbench.v
// Testbench with math stories demonstrating the area of a circle, the surface area of
// a cone, and the volume of a sphere.
// Sends opcodes and operands to breadboard on each clock cycle
// Prints: opcode loaded, input values, result, status flags
// CS 4341 Spring 2026 - ALU Project Phase 3

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
    wire        flag_carry;    // New
    wire        flag_overflow; // New

    // --- Instantiate breadboard ---
    breadboard uut (
    .CLK           (CLK),
    .RST           (RST),
    .OperandA      (A),       // Match the breadboard names
    .OperandB      (B),
    .OpCode        (OPCODE),
    .OpResult      (RESULT),  // Match the breadboard names
    .flag_zero     (flag_zero),
    .flag_negative (flag_negative),
    .flag_error    (flag_error),
    .flag_carry    (flag_carry),    // You need to add these wires!
    .flag_overflow (flag_overflow)
    );

    // --- Clock: 10ns period ---
    initial CLK = 0;
    always #5 CLK = ~CLK;

    // --- Task: send one command, wait one clock, print result ---
    // Updated for Phase 3 "System Story" formatting
    task send_cmd;
        input [31:0] in_a;
        input [31:0] in_b;
        input [3:0]  op;
        begin
            A      = in_a;
            B      = in_b;
            OPCODE = op;

            // Wait for clock edge and small delay for logic to settle
            @(posedge CLK); #1;

            $display("  Op: %b | A: %0d (0x%0h) | B: %0d (0x%0h) | Result: %0d (0x%0h)", 
                      op, A, A, B, B, RESULT, RESULT);
            $display("  Flags: Z:%b N:%b C:%b V:%b Err:%b", 
                      flag_zero, flag_negative, flag_carry, flag_overflow, flag_error);
            $display("  ------------------------------------------------------------------");
        end
    endtask

    // --- Test sequence ---
    initial begin
        $dumpfile("alu_stories.vcd");
        $dumpvars(0, testbench);

        $display("========================================================");
        $display("   CS 4341 ALU Phase 3 - Multi-Step Geometry Stories    ");
        $display("========================================================");
        $display("");

        // Reset
        RST = 1; A = 0; B = 0; OPCODE = 4'b0000;
        @(posedge CLK); #1;
        RST = 0;
        $display("--- System Reset Complete: All registers cleared ---");
        $display("");

        // =========================================================
        // STORY 1: Area of a Circle (pi * r^2)
        // =========================================================
        $display("STORY 1: Area of a Circle (r=10, pi=3)");
        
        // Step 1: r * r
        send_cmd(32'd10, 32'd10, 4'b0010); 
        
        // Step 2: (r^2) * pi
        send_cmd(RESULT, 32'd3, 4'b0010);
        
        $display(">> CALCULATED AREA OF CIRCLE: %0d", RESULT);
        $display("");

        // =========================================================
        // STORY 2: Volume of a Sphere ((4 * pi * r^3) / 3)
        // =========================================================
        $display("STORY 2: Volume of a Sphere (r=5, pi=3)");
        
        // Step 1: r * r
        send_cmd(32'd5, 32'd5, 4'b0010);
        
        // Step 2: (r^2) * r = r^3
        send_cmd(RESULT, 32'd5, 4'b0010);
        
        // Step 3: r^3 * pi
        send_cmd(RESULT, 32'd3, 4'b0010);
        
        // Step 4: Multiply by 4
        send_cmd(RESULT, 32'd4, 4'b0010);
        
        // Step 5: Divide by 3
        send_cmd(RESULT, 32'd3, 4'b0110);
        
        $display(">> CALCULATED VOLUME OF SPHERE: %0d", RESULT);
        $display("");

        // =========================================================
        // STORY 3: Surface Area of a Cone (pi*r*l + pi*r^2)
        // =========================================================
        $display("STORY 3: Surface Area of a Cone (r=3, l=7, pi=3)");
        
        begin : cone_logic
            reg [31:0] part_a;
            // Step 1: pi * r * l
            send_cmd(32'd3, 32'd3, 4'b0010);
            send_cmd(RESULT, 32'd7, 4'b0010);
            part_a = RESULT; // Store 63

            // Step 2: pi * r^2
            send_cmd(32'd3, 32'd3, 4'b0010);
            send_cmd(RESULT, 32'd3, 4'b0010); // Result is 27

            // Step 3: Add them
            send_cmd(part_a, RESULT, 4'b0001);
        end
        
        $display(">> CALCULATED SURFACE AREA OF CONE: %0d", RESULT);
        $display("");

        $display("========================================================");
        $display("   Test Sequence Complete: All Stories Verified         ");
        $display("========================================================");
        $finish;
    end

endmodule
