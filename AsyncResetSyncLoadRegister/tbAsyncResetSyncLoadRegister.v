`timescale 1ms/1ms

module tbAsyncResetSyncLoadRegister;

    reg [3:0] d;
    reg clk;
    reg reset;
    reg load;
    wire [3:0] q;

    AsyncResetSyncLoadRegister uut (
        .d(d),
        .clk(clk),
        .reset(reset),
        .load(load),
        .q(q)
    );

    // генерируем тактовый сигнал
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 1; 
        load = 0;  // при сбросе сигнал загрузки не важен
        d = 4'b0000;
        #3;
        
        reset = 0;
        load = 1; 
        d = 4'b1010;  // загружаем данные в регистр
        #10;         // ждем несколько тактов
        
        d = 4'b1100;  
        #10;

        load = 0; 
        #10;

        reset = 1;
        #3;        
        
        $stop;
        
    end

endmodule
