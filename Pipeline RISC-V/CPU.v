module CPU(clk);
	input clk;
	wire[4:0] RS1D, RS2D, RS1E, RS2E, RDE;
	wire[1:0] PCSrcE, resultSrcE;
	wire[4:0] RDM;
	wire regWriteM;
	wire[4:0] RDW;
	wire regWriteW, stallF, stallD, flushD, flushE;
	wire[1:0] forwardAE, forwardBE;
	wire[1:0] resultSrcM, resultSrcW;

	wire[6:0] op;
	wire[2:0] func3;
	wire[6:0] func7;
	wire regWrite;
	wire[1:0] resultSrc;
	wire memWrite, jal, branch, jalr;
	wire[2:0] ALUControl;
	wire ALUSrc;
	wire[2:0] immSrc;

	hazardUnit HU(RS1D, RS2D, RS1E, RS2E, RDE, PCSrcE, resultSrcE, RDM, regWriteM, RDW, regWriteW, resultSrcM, resultSrcW, stallF,
			stallD, flushD, flushE, forwardAE, forwardBE);
	
	dataPath DP(clk, regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc, stallF, stallD, flushD, 
		flushE, forwardAE, forwardBE, op, func3, func7, RS1D, RS2D, RS1E, RS2E, RDE, PCSrcE, resultSrcE,
		RDM, regWriteM, RDW, regWriteW, resultSrcM, resultSrcW);

	controller CU(op, func3, func7, regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc);
	
endmodule
