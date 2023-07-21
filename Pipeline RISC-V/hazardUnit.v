module hazardUnit(RS1D, RS2D, RS1E, RS2E, RDE, PCSrcE, resultSrcE, RDM, regWriteM, RDW, regWriteW, resultSrcM, resultSrcW, stallF, stallD, flushD, flushE, forwardAE,
		forwardBE);
	input[4:0] RS1D, RS2D, RS1E, RS2E, RDE;
	input[1:0] PCSrcE, resultSrcE;
	input[4:0] RDM;
	input regWriteM;
	input[4:0] RDW;
	input regWriteW;
	input[1:0] resultSrcM, resultSrcW;

	output reg stallF=0, stallD=0, flushD=0, flushE=0;
	output reg[1:0] forwardAE=0, forwardBE=0;

	reg lwStall;

	always@(RS1D, RS2D, RS1E, RS2E, RDE, PCSrcE, resultSrcE, RDM, regWriteM, RDW, regWriteW, resultSrcM, resultSrcW)
	begin
		{stallF, stallD, flushD, flushE, forwardAE, forwardBE} = 0;//ask soheil
		if (((RS1E == RDM) && regWriteM) && RS1E!=0)
			forwardAE = 2'b10;
		else if ((RS1E == RDW && regWriteW && RS1E!=0) || (RS1E == RDW && resultSrcW==2'b11 && RS1E!=0))
			forwardAE = 2'b01;
		else if(RS1E == RDM && resultSrcM==2'b11 && RS1E!=0)
			forwardAE = 2'b11;
		else
			forwardAE = 2'b00;

		if (((RS2E == RDM) && regWriteM) && RS2E!=0)
			forwardBE = 2'b10;
		else if ((RS2E == RDW && regWriteW && RS2E!=0) || (RS2E == RDW && resultSrcW==2'b11 && RS2E!=0))
			forwardBE = 2'b01;
		else if(RS2E == RDM && resultSrcM==2'b11 && RS2E!=0)
			forwardBE = 2'b11;
		else
			forwardBE = 2'b00;


		if(((RS1D == RDE) || (RS2D == RDE)) && (resultSrcE == 2'b01))
			lwStall = 1'b1;
		else
			lwStall = 1'b0;
		
		{stallF, stallD} = {lwStall, lwStall};
		if(PCSrcE != 2'b00)
			flushD = 1'b1;
		else
			flushD = 1'b0;
		if(PCSrcE != 2'b00 || lwStall == 1)
			flushE = 1'b1;
		else
			flushE = 1'b0;
		
	end

endmodule
