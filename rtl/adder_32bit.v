module adder_32bit (
    input  [31:0] a,   // Primeiro operando
    input  [31:0] b,   // Segundo operando
    input         cin, // Carry-in
    output [31:0] sum, // Soma
    output        cout // Carry-out
);
    assign {cout, sum} = a + b + cin;
endmodule

