`include "PC.v"
`include "InstructionMemory.v"
`include "RegFile.v"
`include "mux.v"
`include "ALU.v"
`include "SignExtend.v"
`include "DataMemory.v"
`include "sll.v"
`include "ALUControl.v"
`include "Control.v"

module TopLevel(clk, rst, test_reg);
	parameter WORD = 32;
	output [WORD - 1:0] test_reg;

	input wire clk;
	input wire rst;

	reg [WORD - 1:0] PCin;
	wire [WORD - 1:0] PCout;

	wire [WORD - 1:0] PCnext;

	wire [WORD - 1:0] addOut;

	wire [WORD - 1:0] iMemOut;
	wire [WORD - 1:0] muxDMemOut;
	
	wire [WORD - 1: 0] muxPCInOut;
	wire [WORD - 1: 0] muxAOutPC;

	wire [4:0] writeRegister;

	wire [WORD - 1:0] regOutA;
	wire [WORD - 1:0] regOutB;
	
	wire [WORD - 1:0] ALUOut;
	wire [WORD - 1:0] muxALUOut;
	wire ALUZero;
	
	wire [WORD - 1:0] signExtendOut;
	
	wire [WORD - 1:0] dMemOut;
	wire [WORD - 1:0] sslOut;
	wire [27:0] sslPcOut;
	
	wire dMemWrite;
	wire dMemRead;
	
	wire [2:0] aluFunc;
	wire branchCtr;
	wire jump;
	

	PC pc(
			.clk(clk),
			.rst(rst),
			.in(PCin),
			.out(PCout)
		);

	InstructionMemory iMem(
			.clk(clk),
			.in(PCout),
			.out(iMemOut)
		);
	
	RegFile regFile(
			.clk(clk),
			.rst(rst),
			.addrA(iMemOut[25:21]),
			.addrB(iMemOut[20:16]),
			.addrC(writeRegister),
			.regWrite(regWrite),
			.outA(regOutA),
			.outB(regOutB),
			.writeData(muxDMemOut)
		);

	mux #(.N(5))
		muxRegFile(
			.inA(iMemOut[20:16]),
			.inB(iMemOut[15:11]),
			.sel(regDst),
			.out(writeRegister)
		);
	
	mux #(.N(32))
		muxALU(			
			.inA(regOutB),
			.inB(signExtendOut),
			.sel(aluSrc),
			.out(muxALUOut)
			);
	
	SignExtend signExtend(
			.in(iMemOut[15:0]),
			.out(signExtendOut)
		);
	
	ALU alu(
			.inA(regOutA),
			.inB(muxALUOut),
			.func(aluFunc),
			.out(ALUOut),
			.zero(ALUZero)
		);

	DataMemory dMemory(
			.clk(clk),
			.rst(rst),
			.memWrite(dMemWrite),
			.memRead(dMemRead),
			.addr(ALUOut),
			.writeData(regOutB),
			.out(dMemOut)
		);

	mux muxDMem(
			.inA(ALUOut),
			.inB(dMemOut),
			.sel(memToReg),
			.out(muxDMemOut)
		);

	sll	sll(
			.in(signExtendOut),
			.out(sslOut)
		);

	sll	#(.offset(2),
			.inSize(26),
			.outSize(28))
		sllPC(
			.in(iMemOut[25:0]),
			.out(sslPcOut)
		);

	mux muxPCInA(
			.inA(PCnext),
			.inB(addOut),
			.sel(muxChoice),
			.out(muxAOutPC)
		);

	mux muxPCIn(
			.inA(muxAOutPC),
			.inB({PCnext[31:28], sslPcOut}),
			.sel(jump),
			.out(muxPCInOut)
		);

	
	Control CPUControl(
			.instruction(), //blank
			.regWrite(regWrite),
			.regDst(regDst),
			.aluSrc(aluSrc),
			.memWrite(dMemWrite),
			.memRead(dMemRead),
			.memToReg(memToReg),
			.aluOp(), //blank
			.jump(jump),
			.branch(branchCtr)
		);

	ALUControl ALUControl(
			.aluOp(), //blank
			.opCode(), //blank
			.func(), //blank
			.aluFunc(aluFunc)
		);

	assign PCnext = PCout + 4;
	assign addOut = sslOut + PCnext;
	assign muxChoice = branchCtr & ALUZero;
	
	always @* begin
		if (rst) begin
			PCin <= 32'h00000000;
		end
		else begin
			PCin <= muxPCInOut;
		end
	end

	assign test_reg = dMemory.mem[1];

endmodule
