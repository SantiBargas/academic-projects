`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module aluDeco_tb;

    // Parámetros de la prueba
    reg op;
    reg f7;
    reg [2:0] f3;
    reg [1:0] aluOp;
    wire [2:0] aluControl;

    // Instanciación del módulo bajo prueba
    aluDeco uut (
        .op(op),
        .f7(f7),
        .f3(f3),
        .aluOp(aluOp),
        .aluControl(aluControl)
    );

    // Procedimiento de prueba
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, aluDeco_tb);               // Volcado de todas las variables
        // Mostrar los resultados
        $monitor("Time: %0dns | op: %b | f7: %b | f3: %b | aluOp: %b | aluControl: %b",
                 $time, op, f7, f3, aluOp, aluControl);
        
        // Probar combinaciones significativas
        // Test 1: lw, sw (aluOp = 00)
        aluOp = 2'b00; f3 = 3'b000; op = 0; f7 = 0; #10; // Expect aluControl = 000
        
        // Test 2: beq (aluOp = 01)
        aluOp = 2'b01; f3 = 3'b000; op = 0; f7 = 0; #10; // Expect aluControl = 001
        
        // Test 3: R-type with f3 = 000
        aluOp = 2'b10; f3 = 3'b000;
        op = 0; f7 = 0; #10; // Expect aluControl = 000
        op = 1; f7 = 0; #10; // Expect aluControl = 000
        op = 0; f7 = 1; #10; // Expect aluControl = 000
        op = 1; f7 = 1; #10; // Expect aluControl = 001
        
        // Test 4: R-type with f3 = 010 (slt)
        f3 = 3'b010; op = 0; f7 = 0; aluOp = 2'b10; #10; // Expect aluControl = 101
        
        // Test 5: R-type with f3 = 110 (or)
        f3 = 3'b110; op = 0; f7 = 0; #10; // Expect aluControl = 011
        
        // Test 6: R-type with f3 = 111 (and)
        f3 = 3'b111; op = 0; f7 = 0; #10; // Expect aluControl = 010
        
        // Test 7: R-type with f3 = 101 (don't care for op and f7)
        f3 = 3'b101; aluOp = 2'b10; op = 0; f7 = 0; #10; // Expect aluControl = xxx

        // Test 8: R-type with f3 = 001 (don't care for op)
        f3 = 3'b001; aluOp = 2'b10; op = 0; f7 = 1; #10; // Expect aluControl = xxx

        // Finalizar la simulación
        $finish;
    end

endmodule
