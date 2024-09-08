module GenSignal(
    input wire clk,           // входной тактовый сигнал (800 МГц)
    input wire reset,         // сигнал сброса
    output reg cnv,           // выходной сигнал cnv
    output reg adcClk         // выходной сигнал adc_clk
);

    // параметры для настройки частоты и длительности импульсов
    parameter cnvWidth = 4;              // длительность импульса для cnv в тактах
    parameter adcClkWidth = 2;          // длительность импульса для adc_clk в тактах
    parameter periodCnv = 640;           // период сигнала cnv в тактах (200 нс / 1.25 нс)
    parameter delayAdcClk = 84;         // задержка для начала adc_clk в тактах (104 нс / 1.25 нс)
    parameter numberPeriodsAdcClk = 9; // количество периодов для adc_clk

    reg [31:0] countCnv;                // счетчик для генерации cnv
    reg [31:0] countAdcClk;            // счетчик для задержки начала adc_clk
    reg cnvReg;                         // временное хранение импульса для cnv
    reg delayAdcClkReg;                 // флаг активации задержки для adc_clk
    reg adcClkReg;                      // временное хранение импульса для adc_clk
    reg clkDiv2;                        // счетчик для деления частоты
    reg [3:0] cntTAdcClk;              // счетчик количества периодов для adc_clk
    reg adcClkEnable;                  // флаг, отвечающий за активацию генерации adc_clk

    // синхронизация по тактовому сигналу
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            countCnv <= 0;
            cnvReg <= 0;
            cnv <= 0;
            countAdcClk <= 0;
            adcClkReg <= 0;
            delayAdcClkReg <= 0;
            adcClk <= 0;
            clkDiv2 <= 0;
            cntTAdcClk <= 0;
            adcClkEnable <= 0;   // сброс флага генерации adc_clk
        end else begin
            // деление частоты на 2 для adc_clk
            clkDiv2 <= ~clkDiv2;

            // генерация импульса cnv
            if (countCnv < periodCnv - 1) begin
                countCnv <= countCnv + 1;
                if (countCnv == 0) begin
                    delayAdcClkReg <= 1;  // активируем задержку при начале нового цикла cnv
                    adcClkEnable <= 1;    // включаем генерацию adc_clk
                end
            end else begin
                countCnv <= 0;
            end

            // импульс для cnv
            if (countCnv < cnvWidth) begin
                cnvReg <= 1;
            end else begin
                cnvReg <= 0;
            end
            cnv <= cnvReg;

            // генерация импульсов adc_clk после задержки и до достижения 9 полных периодов
            if (adcClkEnable && delayAdcClkReg && clkDiv2) begin
                if (countAdcClk < delayAdcClk) begin
                    countAdcClk <= countAdcClk + 1;
                end else if (cntTAdcClk < (numberPeriodsAdcClk * 2)) begin
                    adcClkReg <= ~adcClkReg;
                    cntTAdcClk <= cntTAdcClk + 1;
                end else begin
                    adcClkReg <= 0;    // останавливаем генерацию импульсов после 9 полных периодов
                    cntTAdcClk <= 0;  // сбрасываем счетчик периодов
                    delayAdcClkReg <= 0;  // завершаем задержку
                    adcClkEnable <= 0; // отключаем генерацию adc_clk
                end
            end
            adcClk <= adcClkReg;
        end
    end

endmodule
