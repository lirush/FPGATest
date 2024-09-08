`timescale 1ns/1ps

module tbGenSignal();

    // параметры для тестбенча
    reg clk;
    reg reset;
    wire cnv;
    wire adcClk;
	 
	 localparam CLK_PERIOD = 1.25;

    // экземпляр тестируемого модуля
    GenSignal uut (
        .clk(clk),
        .reset(reset),
        .cnv(cnv),
        .adcclk(adcClk)
    );

    // генерация тактового сигнала с периодом 1.25 нс (800 МГц)
    always begin
        # (CLK_PERIOD / 2) clk = ~clk;
    end

    // процедура для инициализации и запуска теста
    initial begin
        // инициализация сигналов
        clk = 0;
        reset = 1;

        // подождем немного, чтобы сброс сработал
        #10;  // время ожидания сброса (достаточно 10 нс)
        reset = 0;  // сброс снят

        // наблюдаем сигналы в течение некоторого времени
        #30000;  // 1000 нс наблюдения

        // завершение симуляции
        $stop;
    end

    // мониторинг для наблюдения за изменениями сигналов
    initial begin
        $monitor("Time: %0dns, cnv: %b, adc_clk: %b", $time, cnv, adcClk);
    end

endmodule
