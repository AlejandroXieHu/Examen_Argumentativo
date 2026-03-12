module cronometro #(parameter MS_MAX = 99, parameter SEC_MAX = 59) (

    input clk,
    input rst,
    input stop,

    output reg [13:0] count

);

    reg [6:0] ms;   // Contador de milisegundos
    reg [5:0] sec;  // Contador de segundos

    always @(posedge clk or posedge rst)
		begin
			if (rst)
				begin
					ms  <= 0;
					sec <= 0;
				end

			else if (!stop)
				begin
					if (ms == MS_MAX)
						begin
							ms <= 0;

							if (sec == SEC_MAX)
								sec <= 0;
							else
								sec <= sec + 1;
						end
					else
						ms <= ms + 1;
				end
		end

    // Conversión a formato para mostrar en el display de la tarjeta
    always @(*)
		begin
			count = sec * 100 + ms;
		end

endmodule
