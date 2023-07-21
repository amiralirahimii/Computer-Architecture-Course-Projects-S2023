module CPU(clk, readData, adrOut, writeData, memWrite);
	input clk;
	input[31:0] readData;
	output[31:0] adrOut, writeData;
	output memWrite;
	wire PCWrite, adrSrc, IRWrite;
	wire[2:0] ALUControl, immSrc;
	wire[1:0] resultSrc, ALUSrcA, ALUSrcB;
	wire zero, LSB;
	wire[6:0] op, func7;
	wire[2:0] func3;
	controller CU(clk, op, func3, func7, zero, LSB, PCWrite, adrSrc, memWrite, IRWrite, resultSrc, ALUControl, ALUSrcA, ALUSrcB, immSrc, regWrite);
	dataPath DP(clk, readData, PCWrite, adrSrc, IRWrite, regWrite, ALUControl, immSrc, resultSrc, ALUSrcA, ALUSrcB, zero, LSB, adrOut, writeData,
		op, func3, func7);
endmodule
