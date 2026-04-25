// testbench.v
// Testbench for AND breadboard module
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

            $display("Result: 0x%08h | Z:%b N:%b C:%b V:%b Err:%b", 
                      RESULT, flag_zero, flag_negative, flag_carry, flag_overflow, flag_error);
            $display("----------------------------------------------------------");

            if (flag_error)
                $display("  [ERROR] Opcode %b is not AND (1010). Result is undefined.", op);

            $display("");
        end
    endtask

    // TEST SEQUENCE
    initial begin
        // --- Waveform Setup & Initial Reset ---
        $dumpfile("alu_stories.vcd");
        $dumpvars(0, testbench);
        
        RST = 1; A = 0; B = 0; OPCODE = 4'b0000;
        @(posedge CLK); #1; RST = 0;
        $display("--- System Reset Complete: Starting Math Stories --- \n");

        // =========================================================
        // STORY 1: Area of a Circle (Area = pi * r^2)
        // Let radius r = 10, pi approx 3
        // =========================================================
        $display("STORY 1: Area of a Circle (r=10, pi=3)");
        
        send_cmd(32'd10, 32'd10, 4'b0010); // r * r (Mult) -> Result: 100
        send_cmd(RESULT, 32'd3,  4'b0010); // Result * pi (Mult) -> Result: 300
        
        $display(">> Calculated Area of Circle: %d \n", RESULT);


        // =========================================================
        // STORY 2: Volume of a Sphere (Vol = (4 * pi * r^3) / 3)
        // Let radius r = 5, pi approx 3 (pi and /3 cancel out, but we'll show the steps)
        // =========================================================
        $display("STORY 2: Volume of a Sphere (r=5, pi=3)");
        
        send_cmd(32'd5,  32'd5,  4'b0010); // r * r = 25
        send_cmd(RESULT, 32'd5,  4'b0010); // 25 * r = 125 (r^3)
        send_cmd(RESULT, 32'd3,  4'b0010); // 125 * pi = 375
        send_cmd(RESULT, 32'd4,  4'b0010); // 375 * 4 = 1500
        send_cmd(RESULT, 32'd3,  4'b0110); // 1500 / 3 = 500 (Div)
        
        $display(">> Calculated Volume of Sphere: %d \n", RESULT);

        // =========================================================
        // STORY 3: Surface Area of a Cone (SA = pi*r*l + pi*r^2)
        // Let r=3, slant height l=7, pi approx 3
        // =========================================================
        $display("STORY 3: Surface Area of a Cone (r=3, l=7, pi=3)");
        
        // Part 1: pi * r * l
        send_cmd(32'd3,  32'd3,  4'b0010); // pi * r = 9
        send_cmd(RESULT, 32'd7,  4'b0010); // 9 * l = 63
        
        begin : cone_calc
            reg [31:0] part_a;
            part_a = RESULT; // Save 63 in a temp register

            // Part 2: pi * r^2
            send_cmd(32'd3,  32'd3,  4'b0010); // r * r = 9
            send_cmd(RESULT, 32'd3,  4'b0010); // 9 * pi = 27
            
            // Part 3: Add them together
            send_cmd(part_a, RESULT, 4'b0001); // 63 + 27 = 90
        end
        
        $display(">> Calculated Surface Area of Cone: %d \n", RESULT);

        $display("========================================");
        $display("  All Stories Complete. Final Result: %d", RESULT);
        $display("========================================");
        $finish;
    end

endmodule
