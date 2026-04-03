module cla_cascade432 (
    input  [31:0] a,
    input  [31:0] b,
    input         cin,
    output [31:0] sum,
    output        cout
);

    wire [31:0] P, G;
    assign P = a ^ b;
    assign G = a & b;

    wire [8:0] C;
    assign C[0] = cin;

    // --- Bloco 0: bits 0-3 ---
    wire c1_0, c2_0, c3_0;
    assign c1_0 = G[0] | (P[0] & C[0]);
    assign c2_0 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign c3_0 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[1] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
                  (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign sum[0] = P[0] ^ C[0];
    assign sum[1] = P[1] ^ c1_0;
    assign sum[2] = P[2] ^ c2_0;
    assign sum[3] = P[3] ^ c3_0;

    // --- Bloco 1: bits 4-7 ---
    wire c1_1, c2_1, c3_1;
    assign c1_1 = G[4] | (P[4] & C[1]);
    assign c2_1 = G[5] | (P[5] & G[4]) | (P[5] & P[4] & C[1]);
    assign c3_1 = G[6] | (P[6] & G[5]) | (P[6] & P[5] & G[4]) | (P[6] & P[5] & P[4] & C[1]);
    assign C[2] = G[7] | (P[7] & G[6]) | (P[7] & P[6] & G[5]) |
                  (P[7] & P[6] & P[5] & G[4]) | (P[7] & P[6] & P[5] & P[4] & C[1]);
    assign sum[4] = P[4] ^ C[1];
    assign sum[5] = P[5] ^ c1_1;
    assign sum[6] = P[6] ^ c2_1;
    assign sum[7] = P[7] ^ c3_1;

    // --- Bloco 2: bits 8-11 ---
    wire c1_2, c2_2, c3_2;
    assign c1_2 = G[8] | (P[8] & C[2]);
    assign c2_2 = G[9] | (P[9] & G[8]) | (P[9] & P[8] & C[2]);
    assign c3_2 = G[10] | (P[10] & G[9]) | (P[10] & P[9] & G[8]) | (P[10] & P[9] & P[8] & C[2]);
    assign C[3] = G[11] | (P[11] & G[10]) | (P[11] & P[10] & G[9]) |
                  (P[11] & P[10] & P[9] & G[8]) | (P[11] & P[10] & P[9] & P[8] & C[2]);
    assign sum[8]  = P[8]  ^ C[2];
    assign sum[9]  = P[9]  ^ c1_2;
    assign sum[10] = P[10] ^ c2_2;
    assign sum[11] = P[11] ^ c3_2;

    // --- Bloco 3: bits 12-15 ---
    wire c1_3, c2_3, c3_3;
    assign c1_3 = G[12] | (P[12] & C[3]);
    assign c2_3 = G[13] | (P[13] & G[12]) | (P[13] & P[12] & C[3]);
    assign c3_3 = G[14] | (P[14] & G[13]) | (P[14] & P[13] & G[12]) | (P[14] & P[13] & P[12] & C[3]);
    assign C[4] = G[15] | (P[15] & G[14]) | (P[15] & P[14] & G[13]) |
                  (P[15] & P[14] & P[13] & G[12]) | (P[15] & P[14] & P[13] & P[12] & C[3]);
    assign sum[12] = P[12] ^ C[3];
    assign sum[13] = P[13] ^ c1_3;
    assign sum[14] = P[14] ^ c2_3;
    assign sum[15] = P[15] ^ c3_3;

    // --- Bloco 4: bits 16-19 ---
    wire c1_4, c2_4, c3_4;
    assign c1_4 = G[16] | (P[16] & C[4]);
    assign c2_4 = G[17] | (P[17] & G[16]) | (P[17] & P[16] & C[4]);
    assign c3_4 = G[18] | (P[18] & G[17]) | (P[18] & P[17] & G[16]) | (P[18] & P[17] & P[16] & C[4]);
    assign C[5] = G[19] | (P[19] & G[18]) | (P[19] & P[18] & G[17]) |
                  (P[19] & P[18] & P[17] & G[16]) | (P[19] & P[18] & P[17] & P[16] & C[4]);
    assign sum[16] = P[16] ^ C[4];
    assign sum[17] = P[17] ^ c1_4;
    assign sum[18] = P[18] ^ c2_4;
    assign sum[19] = P[19] ^ c3_4;

    // --- Bloco 5: bits 20-23 ---
    wire c1_5, c2_5, c3_5;
    assign c1_5 = G[20] | (P[20] & C[5]);
    assign c2_5 = G[21] | (P[21] & G[20]) | (P[21] & P[20] & C[5]);
    assign c3_5 = G[22] | (P[22] & G[21]) | (P[22] & P[21] & G[20]) | (P[22] & P[21] & P[20] & C[5]);
    assign C[6] = G[23] | (P[23] & G[22]) | (P[23] & P[22] & G[21]) |
                  (P[23] & P[22] & P[21] & G[20]) | (P[23] & P[22] & P[21] & P[20] & C[5]);
    assign sum[20] = P[20] ^ C[5];
    assign sum[21] = P[21] ^ c1_5;
    assign sum[22] = P[22] ^ c2_5;
    assign sum[23] = P[23] ^ c3_5;

    // --- Bloco 6: bits 24-27 ---
    wire c1_6, c2_6, c3_6;
    assign c1_6 = G[24] | (P[24] & C[6]);
    assign c2_6 = G[25] | (P[25] & G[24]) | (P[25] & P[24] & C[6]);
    assign c3_6 = G[26] | (P[26] & G[25]) | (P[26] & P[25] & G[24]) | (P[26] & P[25] & P[24] & C[6]);
    assign C[7] = G[27] | (P[27] & G[26]) | (P[27] & P[26] & G[25]) |
                  (P[27] & P[26] & P[25] & G[24]) | (P[27] & P[26] & P[25] & P[24] & C[6]);
    assign sum[24] = P[24] ^ C[6];
    assign sum[25] = P[25] ^ c1_6;
    assign sum[26] = P[26] ^ c2_6;
    assign sum[27] = P[27] ^ c3_6;

    // --- Bloco 7: bits 28-31 ---
    wire c1_7, c2_7, c3_7;
    assign c1_7 = G[28] | (P[28] & C[7]);
    assign c2_7 = G[29] | (P[29] & G[28]) | (P[29] & P[28] & C[7]);
    assign c3_7 = G[30] | (P[30] & G[29]) | (P[30] & P[29] & G[28]) | (P[30] & P[29] & P[28] & C[7]);
    assign C[8] = G[31] | (P[31] & G[30]) | (P[31] & P[30] & G[29]) |
                  (P[31] & P[30] & P[29] & G[28]) | (P[31] & P[30] & P[29] & P[28] & C[7]);
    assign sum[28] = P[28] ^ C[7];
    assign sum[29] = P[29] ^ c1_7;
    assign sum[30] = P[30] ^ c2_7;
    assign sum[31] = P[31] ^ c3_7;

    assign cout = C[8];

endmodule
