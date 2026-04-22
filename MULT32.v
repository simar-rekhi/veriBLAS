// MULT32.v
// 32-bit Multiplier module
// Structural: utilizes array multiplication and partial products to generate output
// CS 4341 Spring 2026 - ALU Project Phase 2
// Modeled after: https://github.com/Littled58/verilog-multipliers/blob/master/braun_mul.v

module mult(a, b, product);
    input [31:0] a;
    input [31:0] b;
    output [63:0] product;

    wire [31:0] pp0, pp1, pp2, pp3; // partial products
    wire [63:0] sum1, sum2, sum3, sum4;

    // Generate partial products
    assign pp0 = a & {32{b[0]}};
    assign pp1 = a & {32{b[1]}};
    assign pp2 = a & {32{b[2]}};
    assign pp3 = a & {32{b[3]}};
    assign pp4 = a & {32{b[4]}};
    assign pp5 = a & {32{b[5]}};
    assign pp6 = a & {32{b[6]}};
    assign pp7 = a & {32{b[7]}};
    assign pp8 = a & {32{b[8]}};
    assign pp9 = a & {32{b[9]}};
    assign pp10 = a & {32{b[10]}};
    assign pp11 = a & {32{b[11]}};
    assign pp12 = a & {32{b[12]}};
    assign pp13 = a & {32{b[13]}};
    assign pp14 = a & {32{b[14]}};
    assign pp15 = a & {32{b[15]}};
    assign pp16 = a & {32{b[16]}};
    assign pp17 = a & {32{b[17]}};
    assign pp18 = a & {32{b[18]}};
    assign pp19 = a & {32{b[19]}};
    assign pp20 = a & {32{b[20]}};
    assign pp21 = a & {32{b[21]}};
    assign pp22 = a & {32{b[22]}};
    assign pp23 = a & {32{b[23]}};
    assign pp24 = a & {32{b[24]}};
    assign pp25 = a & {32{b[25]}};
    assign pp26 = a & {32{b[26]}};
    assign pp27 = a & {32{b[27]}};
    assign pp28 = a & {32{b[28]}};
    assign pp29 = a & {32{b[29]}};
    assign pp30 = a & {32{b[30]}};
    assign pp31 = a & {32{b[31]}};

    // Shift each partial product and sum them
    assign sum1 = {32'b0, pp0, 1'b0};
    assign sum2 = {31'b0, pp1, 2'b0};
    assign sum3 = {30'b0, pp2, 3'b0};
    assign sum4 = {29'b0, pp3, 4'b0};
    assign sum5 = {28'b0, pp4, 5'b0};
    assign sum6 = {27'b0, pp5, 6'b0};
    assign sum7 = {26'b0, pp6, 7'b0};
    assign sum8 = {25'b0, pp7, 8'b0};
    assign sum9 = {24'b0, pp8, 9'b0};
    assign sum10 = {23'b0, pp9, 10'b0};
    assign sum11 = {22'b0, pp10, 11'b0};          
    assign sum12 = {21'b0, pp11, 12'b0};    
    assign sum13 = {20'b0, pp12, 13'b00};    
    assign sum14 = {19'b0, pp13, 14'b0};   
    assign sum15 = {18'b0, pp14, 15'b0};
    assign sum16 = {17'b0, pp15, 16'b0};
    assign sum17 = {16'b0, pp16, 17'b0};
    assign sum18 = {15'b0, pp17, 18'b0};
    assign sum19 = {14'b0, pp18, 19'b0};
    assign sum20 = {13'b0, pp19, 20'b0};
    assign sum21 = {12'b0, pp20, 21'b0};
    assign sum22 = {11'b0, pp21, 22'b0};
    assign sum23 = {10'b0, pp22, 23'b0};
    assign sum24 = {9'b0, pp23, 24'b0};
    assign sum25 = {8'b0, pp24, 25'b0};
    assign sum26 = {7'b0, pp25,  26'b0};
    assign sum27 = {6'b0, pp26, 27'b0};
    assign sum28 = {5'b0, pp27, 28'b0};
    assign sum29 = {4'b0, pp28, 29'b0};        
    assign sum30 = {3'b0, pp29, 30'b0};  
    assign sum31 = {2'b0, pp30, 31'b00};  
    assign sum32 = {1'b0, pp31, 32'b0};

    assign product = sum1 + sum2 + sum3 + sum4 
        + sum5 + sum6 + sum7 + sum8 + sum9 + sum10
        + sum11 + sum12 + sum13 + sum14 + sum15 + sum16
        + sum17 + sum18 + sum19 + sum20 + sum21 + sum22
        + sum23 + sum24 + sum25 + sum26 + sum27 + sum28
        + sum29 + sum30 + sum31 + sum32
endmodule