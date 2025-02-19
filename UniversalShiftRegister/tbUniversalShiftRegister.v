`timescale 1ms/1ms

module tbUniversalShiftRegister;

    reg [3:0] d;
    reg clk;
    reg reset;
    reg load;
    reg shiftLeft;
    reg shiftRight;
    wire [3:0] q;

    UniversalShiftRegister uut (
        .d(d),
        .clk(clk),
        .reset(reset),
        .load(load),
        .shiftLeft(shiftLeft),
        .shiftRight(shiftRight),
        .q(q)
    );

    // генерируем тактовый сигнал
    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 1;
        load = 0;
        d = 4'b0000;
        shiftLeft = 0;
        shiftRight = 0;
        #10;
        
        reset = 0;
        load = 1;
        d = 4'b1010; // загружаем данные в регистр
        #10;
        
        d = 4'b0011;
        #10;
        
        load = 0;
        shiftLeft = 1;
        d = 4'b1011; // сдвигаем влево
        #10;
        
        shiftLeft = 0;
        load = 1;
        d = 4'b1011; // снова загружаем данные
        #10;
        
        load = 0;
        shiftRight = 1;
        d = 4'b1010; // сдвигаем вправо
        #10;
        
        d = 4'b1110;

        #15;
        $display("Time: %0t | d: %b | q: %b | reset: %b | load: %b | shiftLeft: %b | shiftRight: %b",
                 $time, d, q, reset, load, shiftLeft, shiftRight);            
        
        load = 0;
        shiftLeft = 0;
        shiftRight = 0;
        #10;

        reset = 1;
        #10;

        $stop;        
        
    end

endmodule
