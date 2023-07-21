module dataPath(clk, readData, PCWrite, adrSrc, IRWrite, regWrite, ALUControl, immSrc, resultSrc, ALUSrcA, ALUSrcB, zero, LSB, adrOut, writeData,
		op, func3, func7);
	input clk;
	input[31:0] readData;
	input PCWrite, adrSrc, IRWrite, regWrite;
	input[2:0] ALUControl, immSrc;
	input[1:0] resultSrc, ALUSrcA, ALUSrcB;
	output zero, LSB;
	output[31:0] adrOut, writeData;
	output[6:0] op, func7;
	output[2:0] func3;
	wire[31:0] PC, adr, instR, oldPC, RD1, RD2, A, B, immExt, srcA, srcB, ALUResult, ALUOut, data, result;
	reg32bitAE PCReg(result, clk, PCWrite, PC);
	mux2to1 adrMux(PC, result, adrSrc, adr);
	reg32bitAE oldPCReg(PC, clk, IRWrite, oldPC);
	reg32bitAE IRReg(readData, clk, IRWrite, instR);
	reg32bit dataReg(readData, clk, data);
	regFile myRegFile(instR[19:15], instR[24:20], instR[11:7], result, regWrite, clk, RD1, RD2);
	reg32bit AReg(RD1, clk, A);
	reg32bit BReg(RD2, clk, B);
	immExtend myImmExtend(instR[31:7], immSrc, immExt);
	mux3to1 srcAMux(PC, oldPC, A, ALUSrcA, srcA);
	mux3to1 srcBMux(B, immExt, 4, ALUSrcB, srcB);
	ALU myALU(srcA, srcB, ALUControl, zero, ALUResult);
	reg32bit ALUOutReg(ALUResult, clk, ALUOut);
	mux4to1 resultMux(ALUOut, data, ALUResult, immExt, resultSrc, result);
	assign LSB = ALUResult[0];
	assign adrOut = adr;
	assign writeData = B;
	assign op = instR[6:0];
	assign func3 = instR[14:12];
	assign func7 = instR[31:25];
endmodule

