`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd"

module IM_tb;

    // Señales de prueba
    reg [4:0] addressIM;      // Dirección de la instrucción
    wire [31:0] inst;         // Instrucción leída

    // Instanciación del módulo IM
    IM im_module (
        .addressIM(addressIM),
        .inst(inst)
    );

    // Proceso de prueba
    initial begin
		$dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, IM_tb);
        // Inicializar la dirección
        addressIM = 5'b00000; // Leer la instrucción en dirección 0
        #10; // Esperar un ciclo
        $display("Inst at address %d: %h", addressIM, inst); // Mostrar la instrucción leída
        
        addressIM = 5'b00001; // Leer la instrucción en dirección 1
        #10;
        $display("Inst at address %d: %h", addressIM, inst); // Mostrar la instrucción leída

        addressIM = 5'b00010; // Leer la instrucción en dirección 2
        #10;
        $display("Inst at address %d: %h", addressIM, inst); // Mostrar la instrucción leída

        addressIM = 5'b00011; // Leer la instrucción en dirección 3
        #10;
        $display("Inst at address %d: %h", addressIM, inst); // Mostrar la instrucción leída

        // Finalizar la simulación
        $finish;
    end

endmodule
