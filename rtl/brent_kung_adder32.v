module brent_kung_adder32(
    input [31:0] a, b,
    input cin,
    output [31:0] sum,
    output cout
);
    wire [31:0] g, p;
    wire [31:0] c;

    assign g = a & b;
    assign p = a ^ b;

    // Nível 1
    wire [15:0] g2b, p2b;
    assign g2b[0]  = g[1]  | (p[1]  & g[0]);   assign p2b[0]  = p[1]  & p[0];
    assign g2b[1]  = g[3]  | (p[3]  & g[2]);   assign p2b[1]  = p[3]  & p[2];
    assign g2b[2]  = g[5]  | (p[5]  & g[4]);   assign p2b[2]  = p[5]  & p[4];
    assign g2b[3]  = g[7]  | (p[7]  & g[6]);   assign p2b[3]  = p[7]  & p[6];
    assign g2b[4]  = g[9]  | (p[9]  & g[8]);   assign p2b[4]  = p[9]  & p[8];
    assign g2b[5]  = g[11] | (p[11] & g[10]);  assign p2b[5]  = p[11] & p[10];
    assign g2b[6]  = g[13] | (p[13] & g[12]);  assign p2b[6]  = p[13] & p[12];
    assign g2b[7]  = g[15] | (p[15] & g[14]);  assign p2b[7]  = p[15] & p[14];
    assign g2b[8]  = g[17] | (p[17] & g[16]);  assign p2b[8]  = p[17] & p[16];
    assign g2b[9]  = g[19] | (p[19] & g[18]);  assign p2b[9]  = p[19] & p[18];
    assign g2b[10] = g[21] | (p[21] & g[20]);  assign p2b[10] = p[21] & p[20];
    assign g2b[11] = g[23] | (p[23] & g[22]);  assign p2b[11] = p[23] & p[22];
    assign g2b[12] = g[25] | (p[25] & g[24]);  assign p2b[12] = p[25] & p[24];
    assign g2b[13] = g[27] | (p[27] & g[26]);  assign p2b[13] = p[27] & p[26];
    assign g2b[14] = g[29] | (p[29] & g[28]);  assign p2b[14] = p[29] & p[28];
    assign g2b[15] = g[31] | (p[31] & g[30]);  assign p2b[15] = p[31] & p[30];

    // Nível 2
    wire [7:0] g3b, p3b;
    assign g3b[0] = g2b[1]  | (p2b[1]  & g2b[0]);  assign p3b[0] = p2b[1]  & p2b[0];
    assign g3b[1] = g2b[3]  | (p2b[3]  & g2b[2]);  assign p3b[1] = p2b[3]  & p2b[2];
    assign g3b[2] = g2b[5]  | (p2b[5]  & g2b[4]);  assign p3b[2] = p2b[5]  & p2b[4];
    assign g3b[3] = g2b[7]  | (p2b[7]  & g2b[6]);  assign p3b[3] = p2b[7]  & p2b[6];
    assign g3b[4] = g2b[9]  | (p2b[9]  & g2b[8]);  assign p3b[4] = p2b[9]  & p2b[8];
    assign g3b[5] = g2b[11] | (p2b[11] & g2b[10]); assign p3b[5] = p2b[11] & p2b[10];
    assign g3b[6] = g2b[13] | (p2b[13] & g2b[12]); assign p3b[6] = p2b[13] & p2b[12];
    assign g3b[7] = g2b[15] | (p2b[15] & g2b[14]); assign p3b[7] = p2b[15] & p2b[14];

    // Nível 3
    wire [3:0] g4b, p4b;
    assign g4b[0] = g3b[1] | (p3b[1] & g3b[0]);  assign p4b[0] = p3b[1] & p3b[0];
    assign g4b[1] = g3b[3] | (p3b[3] & g3b[2]);  assign p4b[1] = p3b[3] & p3b[2];
    assign g4b[2] = g3b[5] | (p3b[5] & g3b[4]);  assign p4b[2] = p3b[5] & p3b[4];
    assign g4b[3] = g3b[7] | (p3b[7] & g3b[6]);  assign p4b[3] = p3b[7] & p3b[6];

    // Nível 4
    wire [1:0] g5b, p5b;
    assign g5b[0] = g4b[1] | (p4b[1] & g4b[0]);  assign p5b[0] = p4b[1] & p4b[0];
    assign g5b[1] = g4b[3] | (p4b[3] & g4b[2]);  assign p5b[1] = p4b[3] & p4b[2];

    // Nível 5
    wire g6b, p6b;
    assign g6b = g5b[1] | (p5b[1] & g5b[0]);
    assign p6b = p5b[1] & p5b[0];

    // Propagação de carrys
    assign c[0] = cin;
    assign cout = g6b | (p6b & cin);
    assign c[16] = g5b[0] | (p5b[0] & cin);
    assign c[8]  = g4b[0] | (p4b[0] & cin);
    assign c[24] = g4b[2] | (p4b[2] & c[16]);
    assign c[4]  = g3b[0] | (p3b[0] & cin);
    assign c[12] = g3b[2] | (p3b[2] & c[8]);
    assign c[20] = g3b[4] | (p3b[4] & c[16]);
    assign c[28] = g3b[6] | (p3b[6] & c[24]);
    assign c[2]  = g2b[0] | (p2b[0] & cin);
    assign c[6]  = g2b[2] | (p2b[2] & c[4]);
    assign c[10] = g2b[4] | (p2b[4] & c[8]);
    assign c[14] = g2b[6] | (p2b[6] & c[12]);
    assign c[18] = g2b[8] | (p2b[8] & c[16]);
    assign c[22] = g2b[10] | (p2b[10] & c[20]);
    assign c[26] = g2b[12] | (p2b[12] & c[24]);
    assign c[30] = g2b[14] | (p2b[14] & c[28]);

    assign c[1]  = g[0]  | (p[0]  & cin);
    assign c[3]  = g[2]  | (p[2]  & c[2]);
    assign c[5]  = g[4]  | (p[4]  & c[4]);
    assign c[7]  = g[6]  | (p[6]  & c[6]);
    assign c[9]  = g[8]  | (p[8]  & c[8]);
    assign c[11] = g[10] | (p[10] & c[10]);
    assign c[13] = g[12] | (p[12] & c[12]);
    assign c[15] = g[14] | (p[14] & c[14]);
    assign c[17] = g[16] | (p[16] & c[16]);
    assign c[19] = g[18] | (p[18] & c[18]);
    assign c[21] = g[20] | (p[20] & c[20]);
    assign c[23] = g[22] | (p[22] & c[22]);
    assign c[25] = g[24] | (p[24] & c[24]);
    assign c[27] = g[26] | (p[26] & c[26]);
    assign c[29] = g[28] | (p[28] & c[28]);
    assign c[31] = g[30] | (p[30] & c[30]);

    assign sum = a ^ b ^ c;
endmodule

