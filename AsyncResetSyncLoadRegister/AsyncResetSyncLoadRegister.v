module AsyncResetSyncLoadRegister
(
    input wire [3:0] d,
    input wire clk,
    input wire reset,
    input wire load,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) 
        q <= 4'b0000; // при сбросе устанавливаем значение в 0
    else if (load)
        q <= d; // при загрузке присваиваем входное значение
end

endmodule
