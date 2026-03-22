module Mux2x1(
	input wire [31:0] e1, e2,
	input wire sel,
	output reg [31:0] salMux
);

	always @(*) begin
		case (sel)
			1'b0 : salMux = e1;
			1'b1 : salMux = e2;
		endcase
	end
endmodule