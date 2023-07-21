module FDReg(clk, en, clr, instRF, PCF, PCPlus4F, instRD, PCD, PCPlus4D);
	input clk, en, clr;
	input[31:0] instRF, PCF, PCPlus4F;
	output reg[31:0] instRD, PCD, PCPlus4D;
	always@(posedge clk)
	begin
		if(clr)
			{instRD, PCD, PCPlus4D} = 96'b0;
		else if(~en)//check here at end
			{instRD, PCD, PCPlus4D} = {instRF, PCF, PCPlus4F};
		else
			{instRD, PCD, PCPlus4D} = {instRD, PCD, PCPlus4D};
	end

endmodule

