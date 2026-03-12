module cronometro_wr (

	input  MAX10_CLK1_50,
	input  [1:0] KEY,

	output [0:6] HEX0,
	output [0:6] HEX1,
	output [0:6] HEX2,
	output [0:6] HEX3

);

	wire rst;       
	wire stop;  // Señal para detener el cronómetro
	wire slow_clk;     

	wire [13:0] count; 

	assign rst  = ~KEY[0];  
	assign stop = ~KEY[1]; 

	clock_divider #(.FREQ(1000)) clk_div (
	    .clk(MAX10_CLK1_50),
		.rst(rst),
		.clk_div(slow_clk)
	);

	cronometro #(.MS_MAX(99), .SEC_MAX(59)) cronometro (
		.clk(slow_clk),
		.rst(rst),
		.stop(stop),
		.count(count)
	);

	BCD_4Displays display (
		.bcd_in(count),
		.D_un(HEX0),
		.D_de(HEX1),
		.D_ce(HEX2),
		.D_mi(HEX3)
	);

endmodule
