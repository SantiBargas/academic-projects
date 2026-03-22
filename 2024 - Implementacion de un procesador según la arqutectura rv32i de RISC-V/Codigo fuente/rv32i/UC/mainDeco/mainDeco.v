module mainDeco(
    input wire [6:0] op,
    output reg branch,
    output reg [1:0] resSrc,
    output reg memWrite,
    output reg aluSrc,
    output reg [1:0] inmSrc,
    output reg regWrite,
    output reg [1:0] aluOp,
    output reg jump
);
always @(*) begin
    case (op)
        3 : //load word
            begin
                regWrite = 1'b1;
                inmSrc = 2'b00;
                aluSrc = 1'b1;
                memWrite = 1'b0;
                resSrc = 2'b01;
                branch = 1'b0;
                aluOp = 2'b00;
                jump = 1'b0;
            end
        35 : //store word
            begin
                regWrite = 1'b0;
                inmSrc = 2'b01;
                aluSrc = 1'b1;
                memWrite = 1'b1;
                resSrc = 2'bxx;
                branch = 1'b0;
                aluOp = 2'b00;
                jump = 1'b0;
            end
        51 : //R-type
            begin
                regWrite = 1'b1;
                inmSrc = 2'bxx;
                aluSrc = 1'b0;
                memWrite = 1'b0;
                resSrc = 2'b00;
                branch = 1'b0;
                aluOp = 2'b10;
                jump = 1'b0;
            end
        99 : //beq
            begin
                regWrite = 1'b0;
                inmSrc = 2'b10;
                aluSrc = 1'b0;
                memWrite = 1'b0;
                resSrc = 2'bxx;
                branch = 1'b1;
                aluOp = 2'b01;
                jump = 1'b0;
            end
        19 : //addi
            begin
                regWrite = 1'b1;
                inmSrc = 2'b00;
                aluSrc = 1'b1;
                memWrite = 1'b0;
                resSrc = 2'b00;
                branch = 1'b0;
                aluOp = 2'b10;
                jump = 1'b0;
            end
        111 : //jal
            begin
                regWrite = 1'b1;
                inmSrc = 2'b11;
                aluSrc = 1'bx;
                memWrite = 1'b0;
                resSrc = 2'b10;
                branch = 1'b0;
                aluOp = 2'bxx;
                jump = 1'b1;
            end
        default :
             begin
                regWrite = 1'bx;
                inmSrc = 2'bxx;
                aluSrc = 1'bx;
                memWrite = 1'bx;
                resSrc = 2'bxx;
                branch = 1'bx;
                aluOp = 2'bxx;
                jump = 1'bx;
             end
    endcase
end
endmodule