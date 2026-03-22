module Mux3x1(
	input wire [31:0] e1, e2, e3,
	input wire [1:0] sel,
	output reg [31:0] salMux
);

	always @(*) begin
		case (sel)
			2'b00 : salMux = e1;
			2'b01 : salMux = e2;
			2'b10 : salMux = e3;
		endcase
	end
endmodule