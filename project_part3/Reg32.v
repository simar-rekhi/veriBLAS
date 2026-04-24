// Reg32.v
// 32-bit Memory Register built from D Flip-Flops
// Stores result on rising clock edge; asynchronous reset clears to zero
// CS 4341 Spring 2026 - ALU Project Phase 3

// --- 1-bit D Flip-Flop ---
module dff (
    input  D,
    input  CLK,
    input  RST,
    output reg Q
);
    always @(posedge CLK or posedge RST) begin
        if (RST)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule

// --- 32-bit Register: chains 32 DFF instances ---
module reg32 (
    input  [31:0] D,
    input         CLK,
    input         RST,
    output [31:0] Q
);

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : dff_chain
            dff u_dff (
                .D   (D[i]),
                .CLK (CLK),
                .RST (RST),
                .Q   (Q[i])
            );
        end
    endgenerate

endmodule
