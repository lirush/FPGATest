module MultiModeCounter
(
    input wire clk,
    input wire reset,
    input wire load,
    input wire upDown,
    input wire [3:0] loadValue,
    output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 4'b0000; // при сбросе счетчик устанавливается в 0
    else if (load)
        count <= loadValue; // при активации загрузки присваиваем значение loadValue
    else if (upDown)
        count <= count + 1; // при активации upDown увеличиваем счетчик на 1
    else if ((!upDown) && (count != 4'b0000))
        count <= count - 1; // при деактивации upDown уменьшаем счетчик на 1, если он не равен 0
end

endmodule
