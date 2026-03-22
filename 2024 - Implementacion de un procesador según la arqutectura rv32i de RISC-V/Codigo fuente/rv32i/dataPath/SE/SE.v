module SE (
    input wire [31:7] inm, // Entrada 
    input wire [1:0] src,  // Selector de la instrucción (I, S, B, U, J)
    output reg [31:0] inmExt // Salida extendida a 32 bits
);

always @(*) begin
    case (src)
        2'b00: begin // Tipo I
            inmExt = {{20{inm[31]}}, inm[31:20]};
        end
        2'b01: begin // Tipo S
            inmExt = {{20{inm[31]}}, inm[31:25], inm[11:7]};
        end
        2'b10: begin // Tipo B
            inmExt = {{29{inm[31]}}, inm[31], inm[7], inm[30:25], inm[11:8], 1'b0};
        end
        2'b11: begin // Tipo J
            inmExt = {{12{inm[31]}}, inm[19:12], inm[20], inm[30:21],1'b0};
        end
        default: inmExt = 32'b0;
    endcase
end

endmodule
