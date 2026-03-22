`ifdef FROM_RV32I
    `include "memory/DM/DM.v"
    `include "memory/IM/IM.v"
`else
    `include "DM/DM.v"
    `include "IM/IM.v"
`endif

module memory(
    //IM:
    input wire [4:0] pc, //chequear
    //DM:
    input wire clk,
    input wire rst,
    input wire [31:0] WriteData,
    input wire [4:0] ALUResult, //chequar que es de 5 o 32
    input wire MemWrite,

    output wire [31:0] instruccion, //IM
    output wire [31:0] ReadData //DM
);

DM DM_0(
    .clk(clk),
    .addressDM(ALUResult),
    .we(MemWrite),
    .wd(WriteData),
    .rd(ReadData)
);

IM IM_0(
    .addressIM(pc),
    .inst(instruccion)
);


endmodule