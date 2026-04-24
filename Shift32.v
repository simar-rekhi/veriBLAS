// SHIFT32.v
// 32-bit Shift module
// Structural: utilizes linked D flip flops and gate logic to generate output
// dir = 0 for left shift by 1, dir = 1 for right shift by 1
// CS 4341 Spring 2026 - ALU Project Phase 3

// --- 32-bit D Flip-Flop ---
module dFlipFlop(clk, D, Q, Qn);
    input         clk;
    input  [31:0] D;
    output [31:0] Q;
    output [31:0] Qn;

    reg [31:0] Q;

    always @(posedge clk) begin
        Q <= D;
    end

    // Qn is the bitwise complement of Q
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : inv
            not (Qn[i], Q[i]);
        end
    endgenerate

endmodule

// --- 32-bit Shift (left or right by 1 position) ---
module shift(a, dir, clk, out);
    input  [31:0] a;
    input  [1:0]  dir;    // 0 for left, 1 for right
    input         clk;
    output [31:0] out;

    // --- Internal wires ---
    wire [31:0] left_shifted;   // a shifted left by 1
    wire [31:0] right_shifted;  // a shifted right by 1

    // --- Left shift by 1: {a[30:0], 0} ---
    // Structural: wire a[k-1] to left_shifted[k], fill bit 0 with 0
    assign left_shifted[0] = 1'b0;
    genvar k;
    generate
        for (k = 1; k < 32; k = k + 1) begin : lsh
            buf (left_shifted[k], a[k-1]);
        end
    endgenerate

    // --- Right shift by 1: {0, a[31:1]} ---
    // Structural: wire a[k+1] to right_shifted[k], fill bit 31 with 0
    assign right_shifted[31] = 1'b0;
    generate
        for (k = 0; k < 31; k = k + 1) begin : rsh
            buf (right_shifted[k], a[k+1]);
        end
    endgenerate

    // --- 2:1 Mux per bit: select left or right based on dir[0] ---
    // out[k] = (dir[0] & right_shifted[k]) | (~dir[0] & left_shifted[k])
    wire [31:0] mux_out;
    wire ndir;
    not (ndir, dir[0]);

    generate
        for (k = 0; k < 32; k = k + 1) begin : mux
            wire sel_right, sel_left;
            and (sel_right, dir[0], right_shifted[k]);
            and (sel_left,  ndir,   left_shifted[k]);
            or  (mux_out[k], sel_right, sel_left);
        end
    endgenerate

    // --- DFF to register the shifted result ---
    wire [31:0] dff_q;
    wire [31:0] dff_qn;

    dFlipFlop u_dff (
        .clk (clk),
        .D   (mux_out),
        .Q   (dff_q),
        .Qn  (dff_qn)
    );

    // Output is the combinational mux result (not the DFF output)
    // so shift behaves like the other combinational operation modules
    // and the breadboard register handles the final clocking
    assign out = mux_out;

endmodule
