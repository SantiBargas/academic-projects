`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module rv32i_tb();

    reg clk;                      // Señal de reloj
    reg rst;

    // Instancia del módulo rv32i
    rv32i UUT (
        .clk(clk),
        .rst(rst)
    );

    // Generador de reloj: cambia el estado cada 5 unidades de tiempo
    always #1 clk = ~clk;

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, rv32i_tb);            // Volcado de todas las variables

        // Inicialización
        clk = 0;
        rst = 0;
        #1;
        rst = 1;
        #1;
        rst = 0;

        // Pausa inicial para estabilizar
        // #10;
        
        // Puedes agregar diferentes valores de prueba para el testbench aquí.
        // Por ejemplo:
        // - Puedes cargar diferentes instrucciones en memoria y verificar el comportamiento.
        // - Analizar los resultados de la ALU, el PC y el flujo de datos entre los módulos.
        
        // Espera de tiempo para observar el comportamiento
        #1000;
        
        // Finalizar la simulación
        $finish;
    end


endmodule
