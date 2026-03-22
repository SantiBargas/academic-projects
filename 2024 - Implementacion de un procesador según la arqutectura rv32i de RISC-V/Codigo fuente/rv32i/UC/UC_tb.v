`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module UC_tb;

    // Señales de prueba
    reg zero;
    reg [6:0] op;
    reg [2:0] f3;
    reg f7;
    
    wire pcSrc;
    wire [1:0] resSrc;
    wire memWrite;
    wire [2:0] aluControl;
    wire aluSrc;
    wire [1:0] immSrc;
    wire regWrite;

    // Instanciación del módulo UC
    UC uc_inst (
        .zero(zero),
        .op(op),
        .f3(f3),
        .f7(f7),
        .pcSrc(pcSrc),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluControl(aluControl),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .regWrite(regWrite)
    );

    // Proceso de prueba
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, UC_tb); 
        // Inicializar señales
        zero = 0;
        op = 7'b0000000;
        f3 = 3'b000;
        f7 = 0;

        // Estimulos de prueba
        #10;
        op = 7'b1100011; // Branch instruction
        zero = 1;
        #10;
        zero = 0;
        #10;
        op = 7'b1101111; // Jump instruction
        #10;
        op = 7'b0000011; // Load instruction
        #10;
        op = 7'b0100011; // Store instruction
        #10;
        op = 7'b0110011; // R-type instruction
        f3 = 3'b000;
        f7 = 1;
        #10;
        op = 7'b0010011; // I-type instruction
        f3 = 3'b000;
        f7 = 0;
        #10;

        // Finalizar la simulación
        $finish;
    end

    // Monitor para observar las señales
    initial begin
        $monitor("Time = %0t, zero = %b, op = %b, f3 = %b, f7 = %b, pcSrc = %b, resSrc = %b, memWrite = %b, aluControl = %b, aluSrc = %b, immSrc = %b, regWrite = %b",
                 $time, zero, op, f3, f7, pcSrc, resSrc, memWrite, aluControl, aluSrc, immSrc, regWrite);
    end

endmodule