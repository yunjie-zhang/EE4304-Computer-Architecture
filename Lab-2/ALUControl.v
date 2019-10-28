module ALUControl(aluOp, opCode, func, aluFunc);

    input wire [1:0] aluOp;
    input wire [5:0] opCode;
    input wire [5:0] func;

    output reg [2:0] aluFunc;

    always @* begin
        if(aluOp == 2'b10) begin
            case(func)
                6'b100000: aluFunc <= 3'b000; //addition
                //implement other operations here.
                default: aluFunc <= 3'bzzz;
            endcase
        end
        else if (aluOp == 2'b00) begin
        	aluFunc <= 3'b000; //addition for lw, sw
        end
        else if (aluOp == 2'b01) begin
        	aluFunc <= 3'b001; // beq
        end
        else if (aluOp == 2'b11) begin
        	aluFunc <= 3'b000; // addi
        end
    end

endmodule
