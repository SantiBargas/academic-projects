/*
2) memoria de instrucciones (arreglo de 32 registros de 32 bits(en 32 bits guardo la instr))
nombre: IM
ent: addressIM(5)
sal: inst(32)
*/
module IM(
	input wire [4:0] addressIM,
	output reg [31:0] inst
	);
// Declaración del arreglo de 32 registros de 32 bits
reg [31:0] memory [0:31];

// Inicialización de la memoria
initial begin
    memory[0]  = 32'h00300413;
    memory[1]  = 32'h00100493;
    memory[2]  = 32'h01000913;
    memory[3]  = 32'h009462b3;
    memory[4]  = 32'h00947333;
    memory[5]  = 32'h009403b3;
    memory[6]  = 32'h40940e33;
    memory[7]  = 32'h40848eb3;
    memory[8]  = 32'h00942f33;
    memory[9]  = 32'h0084afb3;
    memory[10] = 32'h01d4afb3;
    memory[11] = 32'h00100293;
    memory[12] = 32'h00000313;
    memory[13] = 32'h01228863;
    memory[14] = 32'h005282b3;
    memory[15] = 32'h00130313;
    memory[16] = 32'hff5ff06f;
    memory[17] = 32'h000004b3;
    memory[18] = 32'h00000293;
    memory[19] = 32'h00a00313;
    memory[20] = 32'h00628863;
    memory[21] = 32'h008484b3;
    memory[22] = 32'h00128293;
    memory[23] = 32'hff5ff06f;
    memory[24] = 32'h00802023;
    memory[25] = 32'h00902223;
    memory[26] = 32'h01202423;
    memory[27] = 32'h00002283;
    memory[28] = 32'h00402303;
    memory[29] = 32'h00802383;
end

// Proceso para leer la instrucción desde la memoria
always @(*) begin
    inst = memory[addressIM]; // Asigna la instrucción basada en la dirección
end
endmodule
//se deberia inicializar con instrucciones en memoria?
