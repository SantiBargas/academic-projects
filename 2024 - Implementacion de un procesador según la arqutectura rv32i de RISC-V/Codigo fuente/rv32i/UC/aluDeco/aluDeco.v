module aluDeco(
	input wire op, f7, 
	input wire[2:0] f3,
	input wire[1:0] aluOp,
	output reg[2:0] aluControl
	);
	
	always @(*) begin
		// Inicializar aluControl a un valor por defecto
        aluControl = 3'bxxx; // Valor indefinido al inicio
		case(aluOp)
			2'b00 : aluControl = 3'b000; //instruction: lw, sw
			2'b01 : aluControl = 3'b001; //beq
			2'b10 :
				begin
					case(f3)
						3'b000 :
							begin
								if (op == 1'b0 && f7 == 1'b0) aluControl = 3'b000;
								if (op == 1'b0 && f7 == 1'b1) aluControl = 3'b000;
								if (op == 1'b1 && f7 == 1'b0) aluControl = 3'b000;
								if (op == 1'b1 && f7 == 1'b1) aluControl = 3'b001;
							end
						3'b010 : aluControl = 3'b101; //slt
						3'b110 : aluControl = 3'b011; //or
						3'b111 : aluControl = 3'b010; //and
					endcase
				end
			default : aluControl = 3'bxxx; // Código indefinido
		endcase
	end
endmodule