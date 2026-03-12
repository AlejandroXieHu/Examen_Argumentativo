module sumador_tb ();

    reg clk;
    reg [7:0] SW;
    reg [1:0] KEY;

    wire [0:6] HEX0;
    wire [0:6] HEX1;
    wire [0:6] HEX2;
    wire [0:6] HEX3;

    sumador_wr DUT (
        .MAX10_CLK1_50(clk),
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3)
    );

    initial
        clk = 0;

    always
        #10 clk = ~clk;

    initial
        begin
            KEY = 2'b11;
            SW  = 8'd0;

            $display("Inicio de simulacion");

            $monitor("KEY = %b | SW = %d | Resultado = %d", KEY, SW, DUT.resultado);

            #100;

            $display("Reset");
            KEY[0] = 0;
            #200;
            KEY[0] = 1;

            #200;

            SW = 8'd7;
            $display("Numero ingresado: 7");

            #200;

            $display("Inicio de suma");
            KEY[1] = 0;
            #200;
            KEY[1] = 1;

            #50000;

            $display("Fin de simulacion");
            $finish;
        end

    initial 
        begin
            $dumpfile("sumador_tb.vcd");
            $dumpvars(0, sumador_tb);
        end

endmodule
