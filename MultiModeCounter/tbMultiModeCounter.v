`timescale 1ms/1ms

module tbMultiModeCounter;

    reg clk;
    reg reset;
    reg load;
    reg upDown;
    reg [3:0] loadValue;
    wire [3:0] count;

    MultiModeCounter uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .upDown(upDown),
        .loadValue(loadValue),
        .count(count)
    );

    // генерируем тактовый сигнал
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        // начальные значения и тестирование модуля
        reset = 1;
        load = 0;
        upDown = 0;
        loadValue = 4'b0000;
        #10;

        reset = 0;
        loadValue = 4'b1010; // загрузка значения 1010
        load = 1;
        #10;
        
        load = 0;
        upDown = 1; // счет вверх
        #10;
        
        upDown = 0; // счет вниз
        #10;
        
        loadValue = 4'b0011; // загрузка нового значения
        load = 1;
        #10;
        
        load = 0;
        upDown = 1; // счет вверх
        #10;
        
        $stop;
    end

    initial begin
        // мониторинг сигналов
        $monitor("Time: %0t | count: %b | reset: %b | load: %b | upDown: %b | loadValue: %b", 
                 $time, count, reset, load, upDown, loadValue);
    end

endmodule
