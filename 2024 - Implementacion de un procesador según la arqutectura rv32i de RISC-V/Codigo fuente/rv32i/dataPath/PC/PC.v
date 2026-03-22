/*1) registro contador de programa
nombre: PC
ent: clk, pcNext(32)
sal: pc(32)
*/
module PC (
	input wire clk,				//reloj
	input wire rst,				//reset
	input wire [31:0] pcNext,	//siguiente valor del PC
	output reg [31:0] pc		//valor actual del PC
);

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			pc <= 32'h0000_0000;
		end else
		begin
		pc <= pcNext;
		end
	end
endmodule