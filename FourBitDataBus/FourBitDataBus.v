module FourBitDataBus
(
    input wire clk,
    input wire reset,
    input wire [3:0] dataIn,
    input wire validIn,
    output reg [3:0] dataOut,
    output reg validOut
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        dataOut <= 4'b0000; // при сбросе устанавливаем значение в 0
        validOut <= 0; // при сбросе сигнал валидности становится неактивным
    end else if (validIn) begin
        dataOut <= dataIn; // при активном сигнале валидности загружаем входные данные
        validOut <= 1; // сигнал валидности на выходе активен
    end
end

endmodule
