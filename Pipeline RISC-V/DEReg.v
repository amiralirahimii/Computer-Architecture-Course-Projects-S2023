module DEReg(clk, clr, regWriteD, resultSrcD, memWriteD, jalD, branchD, jalrD, ALUControlD, ALUSrcD,func3D ,RD1D, RD2D, PCD, RS1D, RS2D, RDD,
		immExtD, PCPlus4D, regWriteE, resultSrcE, memWriteE, jalE, branchE, jalrE, ALUControlE, ALUSrcE, func3E, RD1E, RD2E, PCE, RS1E,
		RS2E, RDE, immExtE, PCPlus4E);

	input clk, clr;
	input regWriteD;
	input[1:0] resultSrcD;
	input memWriteD, jalD, branchD, jalrD;
	input[2:0] ALUControlD;
	input ALUSrcD;
	input[2:0] func3D;
	input[31:0] RD1D, RD2D, PCD;
	input[4:0] RS1D, RS2D, RDD;
	input[31:0] immExtD, PCPlus4D;

	output reg regWriteE;
	output reg[1:0] resultSrcE;
	output reg memWriteE, jalE, branchE, jalrE;
	output reg[2:0] ALUControlE;
	output reg ALUSrcE;
	output reg[2:0] func3E;
	output reg[31:0] RD1E, RD2E, PCE;
	output reg[4:0] RS1E, RS2E, RDE;
	output reg[31:0] immExtE, PCPlus4E;

	always@(posedge clk)
	begin
		if(clr)
			{regWriteE, resultSrcE, memWriteE, jalE, branchE, jalrE, ALUControlE, ALUSrcE, func3E, RD1E, RD2E, PCE, RS1E, RS2E,
			RDE, immExtE, PCPlus4E} = 0;
		else
			{regWriteE, resultSrcE, memWriteE, jalE, branchE, jalrE, ALUControlE, ALUSrcE, func3E, RD1E, RD2E, PCE, RS1E, RS2E, RDE,
			immExtE, PCPlus4E} = {regWriteD, resultSrcD, memWriteD, jalD, branchD, jalrD, ALUControlD, ALUSrcD, func3D, RD1D, RD2D,
			PCD, RS1D, RS2D, RDD, immExtD, PCPlus4D};
	end

endmodule
			
	
