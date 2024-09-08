`timescale 1ms/1ms

module tbTwoToFourDecoder;

    reg [1:0] in;
    wire [3:0] out;

    TwoToFourDecoder uut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 2'b00;
        #3;

        in = 2'b01;
        #3;

        in = 2'b10;
        #3;

        in = 2'b11;
        #3;

        $stop;
    end

    initial begin
        // мониторинг сигналов
        $monitor("Time: %0t | in: %b | out: %b", $time, in, out);
    end

endmodule
