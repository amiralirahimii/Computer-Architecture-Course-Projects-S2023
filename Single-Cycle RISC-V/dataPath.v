module dataPath(clk, instR, readData, ALUControl, ALUControl, immSrc, PCSrc, resultSrc, ALUSrc, regWrite, PCOut, ALUResultOut,
 		writeData, zero, LSB);
	input clk;
	input[31:0] instR, readData;
	input[2:0] ALUControl, immSrc;
	input[1:0] PCSrc, resultSrc;
	input ALUSrc, regWrite;
	output[31:0] PCOut, ALUResultOut, writeData;
	output zero, LSB;
	wire[31:0] PCNext, PC, srcA, RD2, srcB, ALUResult, result, PCTarget, immExt, PCPlus4;
	mux3to1 PCMux(PCPlus4, PCTarget, ALUResult, PCSrc, PCNext);
	reg32bit PCReg(PCNext, clk, PC);
	regFile myRegFile(instR[19:15], instR[24:20], instR[11:7], result, regWrite, clk, srcA, RD2);
	mux2to1 srcBMux(RD2, immExt, ALUSrc, srcB);
	ALU myALU(srcA, srcB, ALUControl, zero, ALUResult);
	mux4to1 resultMux(ALUResult, readData, PCPlus4, immExt, resultSrc, result);
	adder32bit PCaddImm(PC, immExt, PCTarget);
	immExtend myImmExtend(instR[31:7], immSrc, immExt);
	adder32bit PCadd4(PC, 4, PCPlus4);
	assign PCOut = PC;
	assign ALUResultOut = ALUResult;
	assign writeData = RD2;
	assign LSB = ALUResult[0];

endmodule
