`ifdef FROM_RV32I
    `include "UC/mainDeco/mainDeco.v"
    `include "UC/aluDeco/aluDeco.v"
`else
    `include "mainDeco/mainDeco.v"
    `include "aluDeco/aluDeco.v"
`endif


module UC(
	input wire zero,
	input wire [6:0] op,
	input wire [2:0] f3,
	input wire f7,
	
	output reg pcSrc,
	output wire [1:0] resSrc,
	output wire memWrite,
	output wire [2:0] aluControl,
	output wire aluSrc,
	output wire [1:0] immSrc,
	output wire regWrite
);

wire [1:0] aluOp;
wire branch;
wire jump;

always @(*) begin
	pcSrc = (zero & branch)|jump;
end

mainDeco mainDeco_0 (
        .op(op),
		.branch(branch),
		.resSrc(resSrc),
		.memWrite(memWrite),
		.aluSrc(aluSrc),
		.inmSrc(immSrc),
		.regWrite(regWrite),
		.aluOp(aluOp),
		.jump(jump)
    );
	
aluDeco aluDeco_0 (
        .f3(f3),
		.op(op[5]),
		.f7(f7),
		.aluOp(aluOp),
		.aluControl(aluControl)
    );
	
endmodule