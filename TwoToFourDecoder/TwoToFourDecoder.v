module TwoToFourDecoder
(
    input [1:0] in,
    output reg [3:0] out
);

always @(*) begin
    out = 4'b0000; // устанавливаем все выходные биты в 0
    out[in] = 1'b1; // активируем соответствующий выходной бит в зависимости от входного значения
end

endmodule
