module ALU(inA, inB, func, out, zero);

	parameter WORD = 32;
	
    input wire [WORD - 1:0] inA;
    input wire [WORD - 1:0] inB;
    
    input wire [2:0] func;

    output wire zero;
    output reg [WORD - 1:0] out;


    always @* begin
        case(func)
	    6'b000: out <= inA + inB;
            //implement other operation here.
        endcase
    end

    assign zero = out ? 1'b0 : 1'b1;

endmodule
