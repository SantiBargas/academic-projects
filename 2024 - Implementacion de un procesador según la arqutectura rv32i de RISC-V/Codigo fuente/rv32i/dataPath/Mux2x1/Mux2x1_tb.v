`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module Mux2x1_tb();

    reg [31:0] e1;               // Entrada 1 de 32 bits
    reg [31:0] e2;               // Entrada 2 de 32 bits
    reg sel;                     // Señal de selección
    wire [31:0] salMux;          // Salida del multiplexor

    // Instancia del módulo Mux2x1
    Mux2x1 UUT (
        .e1(e1),
        .e2(e2),
        .sel(sel),
        .salMux(salMux)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, Mux2x1_tb);            // Volcado de todas las variables

        // Prueba 1: sel = 0, e1 = 0xAAAAAAAA, e2 = 0x55555555
        e1 = 32'hAAAAAAAA;
        e2 = 32'h55555555;
        sel = 0;                           // Seleccionar e1
        #10;
        $display("sel = %b, salMux = %h", sel, salMux); // Debería ser 0xAAAAAAAA

        // Prueba 2: sel = 1
        sel = 1;                           // Seleccionar e2
        #10;
        $display("sel = %b, salMux = %h", sel, salMux); // Debería ser 0x55555555

        // Prueba 3: Cambiar los valores de entrada
        e1 = 32'h12345678;
        e2 = 32'h87654321;
        sel = 0;                           // Seleccionar e1
        #10;
        $display("sel = %b, salMux = %h", sel, salMux); // Debería ser 0x12345678

        sel = 1;                           // Seleccionar e2
        #10;
        $display("sel = %b, salMux = %h", sel, salMux); // Debería ser 0x87654321

        // Finalizar la simulación
        $finish;
    end

endmodule
