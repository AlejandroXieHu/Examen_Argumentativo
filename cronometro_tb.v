module cronometro_tb ();

    reg clk;
    reg rst;
    reg stop;
    wire [13:0] count;

    cronometro #(.MS_MAX(99), .SEC_MAX(59)) dut (
        .clk(clk),
        .rst(rst),
        .stop(stop),
        .count(count)
    );

    initial
        clk = 0;

    always
        #5 clk = ~clk;

    initial
        begin
            rst = 1;
            stop = 0;

            $display("Inicio de simulacion");
            $monitor("rst = %b | stop = %b | count = %d", rst, stop, count);

            #10;
            rst = 0;

            #100;
            $display("Detener cronometro");
            stop = 1;

            #50;
            $display("Continuar cronometro");
            stop = 0;

            #50;
            $display("Resetear cronometro");
            rst = 1;

            #10;
            rst = 0;

            #50

            $display("Fin de simulacion");
            $finish;
        end

    initial
        begin
            $dumpfile("cronometro_tb.vcd");
            $dumpvars(0, cronometro_tb);
        end

endmodule
