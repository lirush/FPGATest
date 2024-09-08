module AdderWithCarry
(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire bin,
    output wire [3:0] s,
    output wire bout,
    output wire underflow
);

wire [4:0] result;

// вычисляем сумму и перенос
assign result = a + b + bin;

// присваиваем 4-битный результат
assign s = result[3:0];

// присваиваем перенос
assign bout = result[4];

// присваиваем флаг переполнения как перенос
assign underflow = bout;

endmodule

