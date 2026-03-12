module sumador (

	input  clk,
	input  rst,
	input  start,
	input  [7:0] SW,
	output reg [15:0] suma

);

  reg [7:0] i;                 // Iterador para realizar la suma
	reg [1:0] current_state;     // Estado actual
	reg [1:0] next_state;        // Siguiente estado
	
	// Definición de estados
	parameter IDLE = 2'd0, SUMA = 2'd1, TERMINADO = 2'd2;
	
	
	// Registro de estado
	always @(posedge clk or posedge rst)
		begin
			if (rst)
				begin
					current_state <= IDLE;
				end
			else
				begin
					current_state <= next_state;
				end
		end
		
		
	// Lógica de siguiente estado
	always @(*)
		begin
			case (current_state)
				IDLE:
					begin
						if (start == 1)
							next_state <= SUMA;
						else
							next_state <= IDLE;
					end
					
				SUMA:
					begin
						if (i > SW)
							next_state <= TERMINADO;
						else
							next_state <= SUMA;
					end
					
				TERMINADO:
					begin
						if (!start)
							next_state <= IDLE;
						else
							next_state <= TERMINADO;
					end
					
				default: next_state <= IDLE;
			endcase
		end
		
		
	// Lógica de salida y operación de suma
	always @(posedge clk or posedge rst)
		begin
			if (rst)
				begin
					suma <= 16'd0;
					i <= 8'd0;
				end
			else
				begin
					case (current_state)
					
						IDLE:
							begin
								suma <= {8'd0, SW};
								i <= 8'd0;
							end
							
						SUMA:
							begin
								if (i == 0)
									begin
										suma <= 16'd0;
										i <= 8'd1;
									end
								else if (i <= SW)
									begin
										suma <= suma + i;  // Acumula la suma
										i <= i + 1;
									end
								else
									begin
										suma <= suma;
										i <= i;
									end
							end
							
						TERMINADO:
							begin
								suma <= suma;  // Mantiene el resultado
							end
							
					endcase
				end
		end

endmodule
