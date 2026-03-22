`timescale 1ns / 1ps
`define DUMPSTR(x) `"x.vcd`"

module mainDeco_tb();

    // Declarar señales
    reg [6:0] op;
    wire branch;
    wire [1:0] resSrc;
    wire memWrite;
    wire aluSrc;
    wire [1:0] inmSrc;
    wire regWrite;
    wire [1:0] aluOp;

    // Instanciar el módulo mainDeco
    mainDeco uut (
        .op(op),
        .branch(branch),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .inmSrc(inmSrc),
        .regWrite(regWrite),
        .aluOp(aluOp)
    );

    // Procedimiento de test
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));  // Archivo para almacenar los resultados de la simulación
        $dumpvars(0, mainDeco_tb);   
        // Test 1: op = 3
        op = 3; // 3 en decimal
        #10; // Esperar un tiempo para observar las salidas
        $display("op = %b, branch = %b, regWrite = %b, inmSrc = %b, aluSrc = %b, memWrite = %b, resSrc = %b, aluOp = %b", 
                  op, branch, regWrite, inmSrc, aluSrc, memWrite, resSrc, aluOp);

        // Test 2: op = 35
        op = 35; // 35 en decimal
        #10;
        $display("op = %b, branch = %b, regWrite = %b, inmSrc = %b, aluSrc = %b, memWrite = %b, resSrc = %b, aluOp = %b", 
                  op, branch, regWrite, inmSrc, aluSrc, memWrite, resSrc, aluOp);

        // Test 3: op = 51
        op = 51; // 51 en decimal
        #10;
        $display("op = %b, branch = %b, regWrite = %b, inmSrc = %b, aluSrc = %b, memWrite = %b, resSrc = %b, aluOp = %b", 
                  op, branch, regWrite, inmSrc, aluSrc, memWrite, resSrc, aluOp);

        // Test 4: op = 99
        op = 99; // 99 en decimal
        #10;
        $display("op = %b, branch = %b, regWrite = %b, inmSrc = %b, aluSrc = %b, memWrite = %b, resSrc = %b, aluOp = %b", 
                  op, branch, regWrite, inmSrc, aluSrc, memWrite, resSrc, aluOp);

        // Test 5: op = otro valor (default)
        op = 127; // Valor no definido
        #10;
        $display("op = %b, branch = %b, regWrite = %b, inmSrc = %b, aluSrc = %b, memWrite = %b, resSrc = %b, aluOp = %b", 
                  op, branch, regWrite, inmSrc, aluSrc, memWrite, resSrc, aluOp);

        // Finalizar simulación
        $finish;
    end

endmodule
