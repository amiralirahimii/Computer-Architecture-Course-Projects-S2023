module MWReg(clk, regWriteM, resultSrcM, ALUResultM, readDataM, RDM, immExtM, PCPlus4M, regWriteW, resultSrcW, ALUResultW, readDataW, RDW,
		immExtW, PCPlus4W);
	input clk;
	input regWriteM;
	input[1:0] resultSrcM;
	input[31:0] ALUResultM, readDataM;
	input[4:0] RDM;
	input[31:0] immExtM, PCPlus4M;
	
	output reg regWriteW;
	output reg[1:0] resultSrcW;
	output reg[31:0] ALUResultW, readDataW;
	output reg[4:0] RDW;
	output reg[31:0] immExtW, PCPlus4W;

	always@(posedge clk)
	begin
		{regWriteW, resultSrcW, ALUResultW, readDataW, RDW, immExtW, PCPlus4W} = {regWriteM, resultSrcM, ALUResultM, readDataM, RDM,
		immExtM, PCPlus4M};
	end

endmodule
