`timescale 1ns/1ns

module tbAdderWithCarry;

    reg [3:0] a, b;
    reg bin;
    wire [3:0] s;
    wire bout;
    wire underflow;

    AdderWithCarry uut (
        .a(a),
        .b(b),
        .bin(bin),
        .s(s),
        .bout(bout),
        .underflow(underflow)
    );

    initial begin

        // Пример 1: проверяем сложение 7 и 1 без переноса
        a = 4'b0111; b = 4'b0001; bin = 1'b0;
        #10; 
        
        // Пример 2: проверяем сложение 8 и 8 без переноса
        a = 4'b1000; b = 4'b1000; bin = 1'b0;
        #10;
        
        // Пример 3: проверяем сложение 15 и 1 без переноса
        a = 4'b1111; b = 4'b0001; bin = 1'b0;
        #10;
        
        // Пример 4: проверяем сложение 5 и 13 с переносом
        a = 4'b0101; b = 4'b1101; bin = 1'b1;
        #10;

        // Останавливаем симуляцию
        $stop;

    end

endmodule
