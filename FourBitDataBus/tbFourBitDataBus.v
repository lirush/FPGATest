`timescale 1ms/1ms

module tbFourBitDataBus;

    reg clk;
    reg reset;
    reg [3:0] dataIn;
    reg validIn;
    wire [3:0] dataOut;
    wire validOut;

    FourBitDataBus uut (
        .clk(clk),
        .reset(reset),
        .dataIn(dataIn),
        .validIn(validIn),
        .dataOut(dataOut),
        .validOut(validOut)
    );

    // генерируем тактовый сигнал
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin

        // мониторинг сигналов
        $monitor("Time: %0t | dataIn: %b | dataOut: %b | reset: %b | validIn: %b | validOut: %b", 
                 $time, dataIn, dataOut, reset, validIn, validOut);    

        reset = 1;
        validIn = 0;
        dataIn = 4'b0000;
        #10;

        reset = 0;
        dataIn = 4'b0110;
        validIn = 1;
        #10;

        dataIn = 4'b1110;
        #10;

        dataIn = 4'b0101;
        #10;

        reset = 1;
        validIn = 0;
        #10;

        $stop;

    end

endmodule
