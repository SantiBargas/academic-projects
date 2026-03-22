`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module Adder_tb();

	// Definir registros de 32 bits para las entradas y cable de 32 bits para la salida
	reg [31:0] test_op1, test_op2;
	wire [31:0] test_res;

	// Instanciar el módulo Adder de 32 bits
	Adder UUT (
		.op1(test_op1),
		.op2(test_op2),
		.res(test_res)
	);

	// Bloque inicial para la simulación
	initial begin
		// Crear el archivo para guardar los resultados de la simulación
		$dumpfile(`DUMPSTR(`VCD_OUTPUT));
		$dumpvars(0, Adder_tb);

		// Prueba 1: Sumar dos números pequeños
		test_op1 = 32'd15;
		test_op2 = 32'd10;
		#1;
		$display("Test 1: op1 = %d, op2 = %d, res = %d", test_op1, test_op2, test_res);

		// Prueba 2: Sumar un número pequeño y uno grande
		test_op1 = 32'd5;
		test_op2 = 32'd123456789;
		#1;
		$display("Test 2: op1 = %d, op2 = %d, res = %d", test_op1, test_op2, test_res);

		// Prueba 3: Sumar dos números grandes
		test_op1 = 32'd123456789;
		test_op2 = 32'd987654321;
		#1;
		$display("Test 3: op1 = %d, op2 = %d, res = %d", test_op1, test_op2, test_res);

		// Prueba 4: Sumar dos números con overflow
		test_op1 = 32'hFFFFFFFF; // Número máximo para 32 bits (4294967295 en decimal)
		test_op2 = 32'd1;
		#1;
		$display("Test 4: op1 = %h, op2 = %d, res = %h", test_op1, test_op2, test_res);

		// Finalizar simulación
		$finish;
	end

endmodule
