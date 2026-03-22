`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd"

module PC_tb;

    // Señales de prueba
    reg clk;                  // Reloj
    reg rst;                  // Reset
    reg [31:0] pcNext;       // Valor siguiente del PC
    wire [31:0] pc;          // Valor actual del PC

    // Instanciación del módulo PC
    PC pc_module (
        .clk(clk),
        .rst(rst),
        .pcNext(pcNext),
        .pc(pc)
    );

    // Generador de reloj
    initial begin
        clk = 0; // Inicializar el reloj en 0
    end
    
    always #5 clk = ~clk; // Reloj de 10 ns de periodo

    // Proceso de prueba
    initial begin
		$dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, PC_tb);
        
        // Inicialización de señales
        rst = 1; // Activar reset
        #10; // Esperar 10 unidades de tiempo
        rst = 0;

        // Esperar un ciclo de reloj antes de cambiar pcNext
        #10; 
        pcNext = 32'h00000001; // Cambiar pcNext
        #10; // Esperar otro ciclo
        pcNext = 32'h00000002; // Cambiar pcNext
        #10; // Esperar otro ciclo
        pcNext = 32'h00000003; // Cambiar pcNext
        #10; // Esperar otro ciclo

        // Finalizar la simulación
        $finish;
    end

endmodule
