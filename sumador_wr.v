module sumador_wr (

	input  MAX10_CLK1_50,
	input  [7:0] SW,  
	input  [1:0] KEY,   

	output [0:6] HEX0,    
	output [0:6] HEX1,     
	output [0:6] HEX2,      
	output [0:6] HEX3       

);

	wire rst;
	wire start;        
	wire slow_clk;         
	wire [15:0] resultado;  

	assign rst   = ~KEY[0];   
	assign start = ~KEY[1];

	clock_divider #(.FREQ(1)) clk_div (
		.clk(MAX10_CLK1_50), 
		.rst(rst), 
		.clk_div(slow_clk)
	);

	sumador sum (
		.clk(slow_clk),
		.rst(rst),
		.start(start),
		.SW(SW),
		.suma(resultado)
	);

	BCD_4Displays display (
		.bcd_in(resultado), 
		.D_un(HEX0), 
		.D_de(HEX1), 
		.D_ce(HEX2), 
		.D_mi(HEX3)
	);

endmodule
