module CPU(clk, instR, readData, PCOut, ALUResultOut, writeData, memWrite);
	input clk;
	input[31:0] instR, readData;
	output[31:0] PCOut, ALUResultOut, writeData;
	output memWrite;
	wire[2:0] ALUControl, immSrc;
	wire[1:0] PCSrc, resultSrc;
	wire ALUSrc, regWrite, zero, LSB;
	dataPath DP(clk, instR, readData, ALUControl, ALUControl, immSrc, PCSrc, resultSrc, ALUSrc, regWrite, PCOut, ALUResultOut,
 		writeData, zero, LSB);
	controller CU(instR[6:0], instR[14:12], instR[31:25], zero, LSB, PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite);

endmodule
