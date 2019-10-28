module sll
		#(parameter offset = 2,
		parameter inSize = 32,
		parameter outSize = 32)
		(in, out);
	
	input wire [inSize - 1:0] in;
	output wire [outSize - 1:0] out;

	assign out = in <<< offset;
endmodule
