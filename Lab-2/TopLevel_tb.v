`include "TopLevel.v"

module TopLevel_tb();

	reg clk;
	reg rst;

	wire [31:0] register;

	TopLevel CPU(
			.clk(clk),
			.rst(rst),
			.test_reg(register)
			);

	always
		#5 clk <= ~clk;


	initial	begin
		$dumpfile("TopLevel.vcd");
		$dumpvars(0, TopLevel_tb); 

		clk <= 1'b0;
		rst <= 1'b1;
		#7 rst <= 1'b0;

		#600
			$finish;
	end

endmodule
