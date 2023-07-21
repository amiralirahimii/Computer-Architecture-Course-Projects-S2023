module EMReg(clk, regWriteE, resultSrcE, memWriteE, ALUResultE, writeDataE, RDE, immExtE, PCPlus4E, regWriteM, resultSrcM, memWriteM,
		ALUResultM, writeDataM, RDM, immExtM, PCPlus4M);
	input clk;
	input regWriteE;
	input[1:0] resultSrcE;
	input memWriteE;
	input[31:0] ALUResultE, writeDataE;
	input[4:0] RDE;
	input[31:0] immExtE, PCPlus4E;

	output reg regWriteM;
	output reg[1:0] resultSrcM;
	output reg memWriteM;
	output reg[31:0] ALUResultM, writeDataM;
	output reg[4:0] RDM;
	output reg[31:0] immExtM, PCPlus4M;

	always@(posedge clk)
	begin
		{regWriteM, resultSrcM, memWriteM, ALUResultM, writeDataM, RDM, immExtM, PCPlus4M} = {regWriteE, resultSrcE, memWriteE,
		ALUResultE, writeDataE, RDE, immExtE, PCPlus4E};
	end

endmodule
