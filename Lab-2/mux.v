module mux
		#(parameter N = 32)
		(inA, inB, sel, out);
	
	input wire [N - 1:0] inA;
	input wire [N - 1:0] inB;
	input wire sel;

	output wire [N - 1:0] out;

	assign out = (sel) ? inB : inA;
endmodule
