/*
3) banco de registros
nombre: BR
ent: a1(5), a2(5), a3(5), wd(32), we
sal: rd1(32), rd2(32)
*/

module BR(
	input wire clk,
	input wire rst,
	input wire [4:0] a1, a2, a3,	//direcciones de los registros
	input wire [31:0] wd,			//dato a escribir
	input wire we,					//habilitacion de escritura
	output reg [31:0] rd1, rd2		//datos leidos de los registros
	);

reg [31:0] registers [0:31];

// Proceso de lectura
always @(*) begin
    // rd1 = registers[a1];              // Leer el registro a1
    // rd2 = registers[a2];              // Leer el registro a2
    rd1 = (a1 != 0) ? registers[a1] : 1'b0;
    rd2 = (a2 != 0) ? registers[a2] : 1'b0;
end

// Proceso de escritura
always @(posedge clk or posedge rst) begin
	    if (rst) begin
        registers[0] <= 32'h0000_0000;
        registers[1] <= 32'h0000_0000;
        registers[2] <= 32'h0000_0000;
        registers[3] <= 32'h0000_0000;
        registers[4] <= 32'h0000_0000;
        registers[5] <= 32'h0000_0000;
        registers[6] <= 32'h0000_0000;
        registers[7] <= 32'h0000_0000;
        registers[8] <= 32'h0000_0000;
        registers[9] <= 32'h0000_0000;
        registers[10] <= 32'h0000_0000;
        registers[11] <= 32'h0000_0000;
        registers[12] <= 32'h0000_0000;
        registers[13] <= 32'h0000_0000;
        registers[14] <= 32'h0000_0000;
        registers[15] <= 32'h0000_0000;
        registers[16] <= 32'h0000_0000;
        registers[17] <= 32'h0000_0000;
        registers[18] <= 32'h0000_0000;
        registers[19] <= 32'h0000_0000;
        registers[20] <= 32'h0000_0000;
        registers[21] <= 32'h0000_0000;
        registers[22] <= 32'h0000_0000;
        registers[23] <= 32'h0000_0000;
        registers[24] <= 32'h0000_0000;
        registers[25] <= 32'h0000_0000;
        registers[26] <= 32'h0000_0000;
        registers[27] <= 32'h0000_0000;
        registers[28] <= 32'h0000_0000;
        registers[29] <= 32'h0000_0000;
        registers[30] <= 32'h0000_0000;
        registers[31] <= 32'h0000_0000;
    end else
    if (we) begin
        registers[a3] <= wd;          // Escribir el dato wd en el registro a3
    end
end


endmodule