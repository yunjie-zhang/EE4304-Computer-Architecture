/*
* Author: Christoforos Vasilatos
* Course: Computer Organization and Architecture (ENGR-UH 3511) Fall 2019
* Division: Engineering
* University: New York University Abu Dhabi
*/

module Control(instruction, regWrite, regDst, aluSrc, memWrite, memToReg, memRead, aluOp, jump, branch);
    input wire [5:0] instruction;

    output reg regWrite;
    output reg regDst;
    output reg aluSrc;
    output reg memWrite;
    output reg memToReg;
    output reg memRead;
    output reg [1:0] aluOp;
    output reg jump;
    output reg branch;

    always @* begin
        case(instruction)
            6'b000000: begin regDst <= 1'b1; jump <= 1'b0; aluSrc = 1'b0; memToReg = 1'b0; regWrite = 1'b1; memRead = 1'b0; memWrite = 1'b0; branch = 1'b0; aluOp = 2'b10; end // R
            6'b100011: begin regDst <= 1'b0; jump <= 1'b0; aluSrc = 1'b1; memToReg = 1'b1; regWrite = 1'b1; memRead = 1'b1; memWrite = 1'b0; branch = 1'b0; aluOp = 2'b00; end // lw
            // implement control signals for sw, addi and beq here 
            6'b000010: begin regDst <= 1'b0; jump <= 1'b1; aluSrc = 1'b0; memToReg = 1'b0; regWrite = 1'b0; memRead = 1'b0; memWrite = 1'b0; branch = 1'b0; aluOp = 2'b00; end // jump
            6'b111111: begin regDst <= 1'bz; jump <= 1'bz; aluSrc = 1'bz; memToReg = 1'bz; regWrite = 1'bz; memRead = 1'bz; memWrite = 1'bz; branch = 1'bz; aluOp = 2'bzz; end // halt
            default:   begin regDst <= 1'bz; jump <= 1'bz; aluSrc = 1'bz; memToReg = 1'bz; regWrite = 1'bz; memRead = 1'bz; memWrite = 1'bz; branch = 1'bz; aluOp = 2'bzz; end
        endcase
    end

endmodule
	
