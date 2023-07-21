module dataPath(clk, regWriteD, resultSrcD, memWriteD, jalD, branchD, jalrD, ALUControlD, ALUSrcD, immSrcD, stallF, stallD, flushD, 
		flushE, forwardAE, forwardBE, op, func3, func7, RS1DOut, RS2DOut, RS1EOut, RS2EOut, RDEOut, PCSrcEOut, resultSrcEOut,
		RDMOut, regWriteMOut, RDWOut, regWriteWOut, resultSrcMOut, resultSrcWOut);
	input clk;

	input regWriteD;
	input[1:0] resultSrcD;
	input memWriteD, jalD, branchD, jalrD;
	input[2:0] ALUControlD;
	input ALUSrcD;
	input[2:0] immSrcD;

	input stallF, stallD, flushD, flushE;
	input[1:0] forwardAE, forwardBE;

	//all outputs assigned
	output[6:0] op;
	output[2:0] func3;
	output[6:0] func7;

	output[4:0] RS1DOut, RS2DOut;

	output[4:0] RS1EOut, RS2EOut, RDEOut;
	output[1:0] PCSrcEOut, resultSrcEOut;

	output[4:0] RDMOut;
	output regWriteMOut;
	
	output[4:0] RDWOut;
	output regWriteWOut;
	output[1:0] resultSrcMOut, resultSrcWOut;

	wire[31:0] PCFNext, PCF, PCPlus4F, instRF;

	wire[31:0] instRD;
	wire[2:0] func3D;//to be assigned
	wire[31:0] RD1D, RD2D, PCD;
	wire[4:0] RS1D, RS2D, RDD;//to be assigned
	wire[31:0] immExtD, PCPlus4D;

	wire regWriteE;
	wire[1:0] resultSrcE;
	wire memWriteE, jalE, branchE, jalrE;
	wire[2:0] ALUControlE;
	wire ALUSrcE;
	wire[2:0] func3E;
	wire[31:0] RD1E, RD2E, PCE;
	wire[4:0] RS1E, RS2E, RDE;
	wire[31:0] immExtE, PCPlus4E;
	wire[31:0] srcAE, srcBE, writeDataE, ALUResultE, PCTargetE;
	wire zeroE;

	wire regWriteM;
	wire[1:0] resultSrcM;
	wire memWriteM;
	wire[31:0] ALUResultM, writeDataM;
	wire[4:0] RDM;
	wire[31:0] immExtM, PCPlus4M, readDataM;
	
	wire regWriteW;
	wire[1:0] resultSrcW;
	wire[31:0] ALUResultW, readDataW;
	wire[4:0] RDW;
	wire[31:0] immExtW, PCPlus4W, resultW;

	wire[1:0] PCSrcE;

	mux3to1 PCMux(PCPlus4F, PCTargetE, ALUResultE, PCSrcE, PCFNext);
	reg32bit PCReg(PCFNext, clk, stallF, PCF);

	instMemory IM(PCF, instRF);
	adder32bit addWith4(PCF, 4, PCPlus4F);

	FDReg myFDReg(clk, stallD, flushD, instRF, PCF, PCPlus4F, instRD, PCD, PCPlus4D);
	regFile myRegFile(instRD[19:15], instRD[24:20], RDW, resultW, regWriteW, clk, RD1D, RD2D);
	immExtend myImmExt(instRD[31:7], immSrcD, immExtD);

	DEReg myDEReg(clk, flushE, regWriteD, resultSrcD, memWriteD, jalD, branchD, jalrD, ALUControlD, ALUSrcD, func3D, RD1D, RD2D, PCD, RS1D,
			RS2D, RDD, immExtD, PCPlus4D, regWriteE, resultSrcE, memWriteE, jalE, branchE, jalrE, ALUControlE, ALUSrcE, func3E,
			RD1E, RD2E, PCE, RS1E, RS2E, RDE, immExtE, PCPlus4E);
	mux4to1 forwardAMux(RD1E, resultW, ALUResultM, immExtM, forwardAE, srcAE);
	mux4to1 forwardBMux(RD2E, resultW, ALUResultM, immExtM,forwardBE, writeDataE);
	mux2to1 srcBEMux(writeDataE, immExtE, ALUSrcE, srcBE);
	adder32bit addWithImm(PCE, immExtE, PCTargetE);
	ALU myALU(srcAE, srcBE, ALUControlE, zeroE, ALUResultE);

	EMReg myEMReg(clk, regWriteE, resultSrcE, memWriteE, ALUResultE, writeDataE, RDE, immExtE, PCPlus4E, regWriteM, resultSrcM, memWriteM,
		ALUResultM, writeDataM, RDM, immExtM, PCPlus4M);
	dataMemory DM(ALUResultM, writeDataM, memWriteM, clk, readDataM);
	
	MWReg myMWReg(clk, regWriteM, resultSrcM, ALUResultM, readDataM, RDM, immExtM, PCPlus4M, regWriteW, resultSrcW, ALUResultW, readDataW,
			RDW, immExtW, PCPlus4W);
	mux4to1 resultMux(ALUResultW, readDataW, PCPlus4W, immExtW, resultSrcW, resultW);

	decoder DCD(jalrE, jalE, branchE, zeroE, ALUResultE[0], func3E, PCSrcE);

	assign func3D = instRD[14:12];
	assign RS1D = instRD[19:15];
	assign RS2D = instRD[24:20];
	assign RDD = instRD[11:7];

	assign op = instRD[6:0];
	assign func3 = instRD[14:12];
	assign func7 = instRD[31:25];

	assign RS1DOut = RS1D;
	assign RS2DOut = RS2D;
	
	assign RS1EOut = RS1E;
	assign RS2EOut = RS2E;
	assign RDEOut = RDE;

	assign PCSrcEOut = PCSrcE;
	assign resultSrcEOut = resultSrcE;
	assign RDMOut = RDM;
	assign regWriteMOut = regWriteM;
	assign RDWOut = RDW;
	assign regWriteWOut = regWriteW;
	assign resultSrcMOut = resultSrcM;
	assign resultSrcWOut = resultSrcW;
endmodule


	
