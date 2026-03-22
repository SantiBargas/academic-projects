`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd"

module BR_tb;

    // Señales de prueba
    reg clk;                    // Reloj
    reg rst;                    // Reset
    reg [4:0] a1, a2, a3;      // Direcciones de los registros
    reg [31:0] wd;             // Dato a escribir
    reg we;                    // Habilitación de escritura
    wire [31:0] rd1, rd2;     // Datos leídos de los registros

    // Instanciación del módulo BR
    BR br_module (
        .clk(clk),
        .rst(rst),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd(wd),
        .we(we),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Generador de reloj
    initial begin
        clk = 0; // Inicializar el reloj en 0
        forever #5 clk = ~clk; // Reloj de 10 ns de periodo
    end

    // Proceso de prueba
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, BR_tb);

        // Inicializar señales
        rst = 1; // Activar reset
        a1 = 5'b00000; // Leer registro 0
        a2 = 5'b00001; // Leer registro 1
        a3 = 5'b00010; // Escribir en registro 2
        wd = 32'hDEADBEEF; // Dato a escribir
        we = 0; // Inicialmente no habilitar escritura
        
        // Desactivar reset después de 10 unidades de tiempo
        #10;
        rst = 0;
        
        // Leer registros antes de escribir
        #10;
        $display("Before write: rd1 = %h, rd2 = %h", rd1, rd2);

        // Habilitar escritura
        we = 1; // Habilitar escritura
        #10; // Esperar un ciclo de reloj
        we = 0; // Deshabilitar escritura

        // Leer registros después de escribir
        #10;
        $display("After write: rd1 = %h, rd2 = %h", rd1, rd2);

        // Cambiar a1 y a2 para leer otros registros
        a1 = 5'b00010; // Leer el registro donde se escribió
        a2 = 5'b00000; // Leer registro 0
        #10;
        $display("Read from a1 (2): rd1 = %h, rd2 = %h", rd1, rd2);

        // Finalizar la simulación
        $finish;
    end

endmodule
