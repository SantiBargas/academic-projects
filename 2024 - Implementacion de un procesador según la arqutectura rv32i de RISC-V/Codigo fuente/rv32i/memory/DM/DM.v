/*
4) memoria de datos
nombre: DM
ent: clk, addressDM(5), weD
sal: rd(32)
*/
module DM (
    input wire clk,                  // Señal de reloj
    input wire rst,
    input wire [4:0] addressDM,      // Dirección de la memoria (5 bits)
    input wire we,                   // Señal de habilitación de escritura
    input wire [31:0] wd,            // Dato a escribir (32 bits)
    output reg [31:0] rd             // Dato leído (32 bits)
);

// Declaración de la memoria de datos: 32 registros de 32 bits
reg [31:0] memory [0:31];

// Proceso de escritura
always @(posedge clk) begin
    if (we) begin
        memory[addressDM] <= wd; // Escribir el dato wd en la dirección especificada
    end
end

// Proceso de lectura
always @(*) begin
    rd = memory[addressDM];     // Leer el dato de la dirección especificada
end

endmodule
