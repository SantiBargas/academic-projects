`ifdef FROM_RV32I
    `include "dataPath/PC/PC.v"
    `include "dataPath/BR/BR.v"
    `include "dataPath/SE/SE.v"
    `include "dataPath/ALU/ALU.v"
    `include "dataPath/Adder/Adder.v"
    `include "dataPath/Mux2x1/Mux2x1.v"
    `include "dataPath/Mux3x1/Mux3x1.v"
`else
    `include "PC/PC.v"
    `include "BR/BR.v"
    `include "SE/SE.v"
    `include "ALU/ALU.v"
    `include "Adder/Adder.v"
    `include "Mux2x1/Mux2x1.v"
    `include "Mux3x1/Mux3x1.v"
`endif


module dataPath(
    input clk,
    input rst,
    input [31:0] instruccion,
    input wire PCSrc, //Mux2x1_0
    input wire [1:0] ResultSrc, //Mux3x1_0 Entrada de Mux Salida de UC
    input wire RegWrite, //UC salida entrada BR
    input wire [2:0] ALUControl, //ALU entrada para ALU salida de UC
    input wire ALUSrc, //Mux2x1_1  selector para mux2x1_1
    input wire [1:0] ImmSrc, //SE Entrada de SE salida de UC
    input wire [31:0] ReadData, //Mux3x1_0 Entrada de Mux Salida de DM

    output wire [31:0] pc, //PC
    output wire [31:0] ALUResult, //ALU Salida para conectar a DM
    output wire zero, //ALU Salida para conectar a UC
    output wire [31:0] WriteData // es RD2 de BR y va a DM
); 

//PC:
wire [31:0] pcNext; //PC
//adder_0:
wire [31:0] cuatro = 32'b100; //ADDER_0 PC PLUS 4
wire [31:0] PCPlus4; //ADDER PCPlus4
//SE:
wire [31:0] immExt; //SE salida de SE 
//adder_1:
wire [31:0] PCTarget; //ADDER PCTarget
//BR:
wire [31:0] RD1; //BR salida
wire [31:0] RD2; //BR salida
//Mux3x1_0:
wire [31:0] Result; //Mux3x1 salida entrada de BR
//ALU:
wire [31:0] SrcB; //ALU entrada de ALU salida de mux2x1_1



PC PC_0(
    .clk(clk),
    .rst(rst),
    .pcNext(pcNext),
    .pc(pc)
);

Adder Adder_0 ( //ADDER PARA PCPlus4
    .op1(pc), 
    .op2(cuatro),
    .res(PCPlus4)
);

Adder Adder_1 (
    .op1(pc), 
    .op2(immExt),
    .res(PCTarget)
);

Mux2x1 Mux2x1_0 ( //Multiplexor para el PC
    .e1(PCPlus4),
    .e2(PCTarget),
    .sel(PCSrc),
    .salMux(pcNext)
);

BR BR_0 (
    .clk(clk),
    .rst(rst),
    .a1(instruccion[19:15]),
    .a2(instruccion[24:20]),
    .a3(instruccion[11:7]),
    .wd(Result),
	.we(RegWrite),
    .rd1(RD1),
    .rd2(RD2)
); 

Mux2x1 Mux2x1_1 ( //Multiplexor la ALU
    .e1(RD2),
    .e2(immExt),
    .sel(ALUSrc),
    .salMux(SrcB) //NOSE SI ESTA BIEN EL TEGU PONE UN PCAUX
);

ALU ALU_0 (
    .srcA(RD1),
    .srcB(SrcB),
    .ALUControl(ALUControl),
    .result(ALUResult), //CABLE INTERNO Y SALIDA.
    .zero(zero)
);

SE SE_0(
    .inm(instruccion[31:7]),
    .src(ImmSrc),
    .inmExt(immExt)
);

Mux3x1 Mux3x1_0 ( //Multiplexor para conectar a WD3 de BR
    .e1(ALUResult),
    .e2(ReadData),
    .e3(PCPlus4),
    .sel(ResultSrc),
    .salMux(Result)
);

// Asignar RD2 a WriteData
assign WriteData = RD2;

endmodule