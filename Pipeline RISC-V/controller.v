module controller(op, func3, func7, regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc);
	input[6:0] op, func7;
	input[2:0] func3;
	output reg[2:0] ALUControl, immSrc;
	output reg[1:0] resultSrc;
	output reg memWrite, jal, branch, jalr, ALUSrc, regWrite;
	parameter[6:0] RTYPE = 7'b0110011, ITYPE = 7'b0010011, STYPE = 7'b0100011, JTYPE = 7'b1101111,
		 BTYPE = 7'b1100011, UTYPE = 7'b0110111, LWTYPE = 7'b0000011, JALRTYPE = 7'b1100111;
	parameter[9:0] ADD = 10'b0000000000, SUB = 10'b0100000000, AND = 10'b0000000111, OR = 10'b0000000110, SLT = 10'b0000000010;
	parameter[2:0] LW = 3'b010, ADDI = 3'b000, XORI = 3'b100, ORI = 3'b110, SLTI = 3'b010, JALR = 3'b000, 
			SW = 3'b010,
			BEQ = 3'b000, BNE = 3'b001, BLT = 3'b100, BGE = 3'b101;//move to decoder

	always@(op, func3, func7)
	begin
		{regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc} = 14'b0;
		case(op)
			RTYPE:
			begin
				{regWrite, resultSrc, memWrite, jal, branch, jalr, ALUSrc} = 8'b1000_0000;
				case({func7, func3})
					ADD: ALUControl = 3'b000;
					SUB: ALUControl = 3'b001;
					AND: ALUControl = 3'b010;
					OR: ALUControl = 3'b011;
					SLT: ALUControl = 3'b101;
				endcase
			end
			ITYPE:
			begin
				{regWrite, resultSrc, memWrite, jal, branch, jalr, ALUSrc, immSrc} = 11'b1000_0001_000;
				case(func3)
					ADDI: ALUControl = 3'b000;
					XORI: ALUControl = 3'b100;
					ORI: ALUControl = 3'b011;
					SLTI: ALUControl = 3'b101;
				endcase
			end
			STYPE: {regWrite, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc} = 12'b0100_0000_1001;
			JTYPE: {regWrite, resultSrc, memWrite, jal, branch, jalr, immSrc} = 10'b1100_1000_10;
			BTYPE: 
			begin
				{regWrite, memWrite, jal, branch, jalr, ALUSrc, immSrc} = 9'b0001_0001_1;
				case(func3)
					BEQ:
					begin
						ALUControl <= 3'b001;
					end
					BNE:
					begin
						ALUControl <= 3'b001;
					end
					BLT:
					begin
						ALUControl <= 3'b101;
					end
					BGE:
					begin
						ALUControl <= 3'b101;
					end
				endcase
			end
			UTYPE: {regWrite, resultSrc, memWrite, jal, branch, jalr, immSrc} = 10'b1110_0001_00;
			LWTYPE: {regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc} = 14'b1010_0000_0010_00;
			JALRTYPE: {regWrite, resultSrc, memWrite, jal, branch, jalr, ALUControl, ALUSrc, immSrc} = 14'b1100_0010_0010_00;

		endcase
	end
endmodule