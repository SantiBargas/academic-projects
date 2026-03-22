`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module ALU_tb;

	// Declarar variables para el testbench
	reg [31:0] srcA, srcB;
	reg [2:0] ALUControl;
	wire [31:0] result;

	// Instanciar el módulo ALU
	ALU UUT (
		.srcA(srcA),
		.srcB(srcB),
		.ALUControl(ALUControl),
		.result(result)
	);

	// Bloque inicial para la simulación
	initial begin
	$dumpfile(`DUMPSTR(`VCD_OUTPUT));//-- File were to store the simulation results
	$dumpvars(0, ALU_tb);
		// Test case 1: Suma (ALUControl = 000)
		srcA = 32'd10; srcB = 32'd20; ALUControl = 3'b000;
		#10; // Esperar 10 unidades de tiempo
		$display("ADD: srcA = %d, srcB = %d, result = %d", srcA, srcB, result);

		// Test case 2: Resta (ALUControl = 001)
		srcA = 32'd30; srcB = 32'd10; ALUControl = 3'b001;
		#10;
		$display("SUB: srcA = %d, srcB = %d, result = %d", srcA, srcB, result);

		// Test case 3: AND (ALUControl = 010)
		srcA = 32'b1010; srcB = 32'b1100; ALUControl = 3'b010;
		#10;
		$display("AND: srcA = %b, srcB = %b, result = %b", srcA, srcB, result);

		// Test case 4: OR (ALUControl = 011)
		srcA = 32'b1010; srcB = 32'b1100; ALUControl = 3'b011;
		#10;
		$display("OR: srcA = %b, srcB = %b, result = %b", srcA, srcB, result);

		// Test case 5: SLT (Set Less Than, ALUControl = 101)
		srcA = 32'd5; srcB = 32'd10; ALUControl = 3'b101;
		#10;
		$display("SLT: srcA = %d, srcB = %d, result = %d", srcA, srcB, result);

		// Test case 6: SLT (srcA > srcB, ALUControl = 101)
		srcA = 32'd15; srcB = 32'd10; ALUControl = 3'b101;
		#10;
		$display("SLT: srcA = %d, srcB = %d, result = %d", srcA, srcB, result);

		// Finalizar la simulación
		$finish;
	end

endmodule
