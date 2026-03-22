`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module DM_tb();

    reg clk;                      // Señal de reloj
    reg rst;                      // Señal de reset
    reg [4:0] addressDM;           // Dirección de memoria de 5 bits
    reg we;                        // Señal de habilitación de escritura
    reg [31:0] wd;                 // Dato a escribir (32 bits)
    wire [31:0] rd;                // Dato leído (32 bits)

    // Instancia del módulo DM
    DM UUT (
        .clk(clk),
        .rst(rst),
        .addressDM(addressDM),
        .we(we),
        .wd(wd),
        .rd(rd)
    );

    // Generador de reloj: cambia el estado cada 5 unidades de tiempo
    always #5 clk = ~clk;

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, DM_tb);               // Volcado de todas las variables

        // Inicialización
        clk = 0;
        rst = 1; // Activar reset
        we = 0;
        wd = 0;
        addressDM = 5'b00000;  // Dirección inicial

        // Desactivar reset después de 10 unidades de tiempo
        #10;
        rst = 0;
        
        // Escribir el valor 32'hAAAA_AAAA en la dirección 0
        #10;
        addressDM = 5'b00000;
        wd = 32'hAAAA_AAAA;
        we = 1;
        #10;
        
        // Escribir el valor 32'hBBBB_BBBB en la dirección 1
        addressDM = 5'b00001;
        wd = 32'hBBBB_BBBB;
        #10;
        
        // Desactivar escritura y leer de la dirección 0
        we = 0;
        addressDM = 5'b00000;
        #10;
        $display("Lectura de direccion 0: %h", rd);
        
        // Leer de la dirección 1
        addressDM = 5'b00001;
        #10;
        $display("Lectura de direccion 1: %h", rd);

        // Escribir el valor 32'hCCCC_CCCC en la dirección 2
        addressDM = 5'b00010;
        wd = 32'hCCCC_CCCC;
        we = 1;
        #10;

        // Leer de la dirección 2
        we = 0;
        addressDM = 5'b00010;
        #10;
        $display("Lectura de direccion 2: %h", rd);

        // Finalizar la simulación
        $finish;
    end

endmodule
