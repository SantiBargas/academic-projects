`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module SE_tb();

    reg [24:0] inm;    // Entrada inmediata de 25 bits
    reg [1:0] src;     // Selector de instrucción
    wire [31:0] inmExt; // Salida extendida a 32 bits

    // Instanciamos el módulo SE
    SE UUT (
        .inm(inm),
        .src(src),
        .inmExt(inmExt)
    );

    // Bloque inicial de prueba
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo de volcado de la simulación
        $dumpvars(0, SE_tb);               // Volcado de todas las variables

		inm = 25'b0;
        src = 2'b00;

        // Esperar un tiempo para ver el comportamiento inicial
        #10;

        // Caso 1: Tipo I (src = 2'b00)
        inm = 25'b1111111111111111111111111;  // Valor de inm (25 bits)
        src = 2'b00;                         // Tipo I
        #10;                                 // Esperamos 10 unidades de tiempo
        inm = 25'b1010101010101111111111110;
        #10

        // Caso 2: Tipo S (src = 2'b01)
        inm = 25'b1111111111111111100000000;  // Valor de inm (25 bits)
        src = 2'b01;                         // Tipo S
        #10;                                 // Esperamos 10 unidades de tiempo

        // Caso 3: Tipo B (src = 2'b10)
        inm = 25'b1000000000000000000000000;  // Valor de inm (25 bits)
        src = 2'b10;                         // Tipo B
        #10;                                 // Esperamos 10 unidades de tiempo

        // Caso 4: Tipo J (src = 2'b11)
        inm = 25'b0100000000000000000000000;  // Valor de inm (25 bits)
        src = 2'b11;                         // Tipo J
        #10;                                 // Esperamos 10 unidades de tiempo


        // Finalizar la simulación
        $finish;
    end

endmodule
