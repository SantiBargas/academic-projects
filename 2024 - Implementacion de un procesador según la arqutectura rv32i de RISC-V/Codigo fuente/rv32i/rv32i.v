`define FROM_RV32I
`include "dataPath/dataPath.v"
`include "UC/UC.v"
`include "memory/memory.v"

module rv32i(
    input wire clk,
    input wire rst
);

//cables internos que conectan las señales entre los modulos
wire [31:0] instruccion, pc, ALUResult, ReadData, WriteData;
wire PCSrc, RegWrite, ALUSrc, MemWrite;
wire [1:0] ResultSrc, ImmSrc;
wire [2:0] ALUControl;
wire zero;

dataPath dataPath_0(
    .clk(clk),
    .rst(rst),
    .instruccion(instruccion),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .RegWrite(RegWrite),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .ReadData(ReadData),
    .pc(pc),
    .ALUResult(ALUResult),
    .zero(zero),
    .WriteData(WriteData)
);

UC UC_0(
    .zero(zero),
    .op(instruccion[6:0]),
    .f3(instruccion[14:12]),
    .f7(instruccion[30]),
    .pcSrc(PCSrc),
    .resSrc(ResultSrc),
    .memWrite(MemWrite),
    .aluControl(ALUControl),
    .aluSrc(ALUSrc),
    .immSrc(ImmSrc),
    .regWrite(RegWrite)
);

memory memory_0(
    .clk(clk),
    .pc(pc[6:2]),
    .WriteData(WriteData),
    .ALUResult(ALUResult[6:2]),
    .MemWrite(MemWrite),
    .instruccion(instruccion),
    .ReadData(ReadData)
);


endmodule