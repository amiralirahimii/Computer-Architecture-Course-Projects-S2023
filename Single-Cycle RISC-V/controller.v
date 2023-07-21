module controller(op, func3, func7, zero, LSB, PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite);
	input[6:0] op, func7;
	input[2:0] func3;
	input zero, LSB;
	output reg[2:0] ALUControl, immSrc;
	output reg[1:0] PCSrc, resultSrc;
	output reg memWrite, ALUSrc, regWrite;
	parameter[6:0] RTYPE = 7'b0110011, ITYPE = 7'b0010011, STYPE = 7'b0100011, JTYPE = 7'b1101111,
		 BTYPE = 7'b1100011, UTYPE = 7'b0110111, LWTYPE = 7'b0000011, JALRTYPE = 7'b1100111;
	parameter[9:0] ADD = 10'b0000000000, SUB = 10'b0100000000, AND = 10'b0000000111, OR = 10'b0000000110, SLT = 10'b0000000010;
	parameter[2:0] LW = 3'b010, ADDI = 3'b000, XORI = 3'b100, ORI = 3'b110, SLTI = 3'b010, JALR = 3'b000, 
			SW = 3'b010,
			BEQ = 3'b000, BNE = 3'b001, BLT = 3'b100, BGE = 3'b101;

	always@(op, func3, func7, zero, LSB)
	begin
		{ALUControl, immSrc, PCSrc, resultSrc, memWrite, ALUSrc, regWrite} = 13'b0;
		case(op)
			RTYPE:
			begin
				{PCSrc, resultSrc, memWrite, ALUSrc, regWrite} = 7'b0000001;
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
				{PCSrc, resultSrc, memWrite, ALUSrc, immSrc, regWrite} = 10'b0000010001;
				case(func3)
					ADDI: ALUControl = 3'b000;
					XORI: ALUControl = 3'b100;
					ORI: ALUControl = 3'b011;
					SLTI: ALUControl = 3'b101;
				endcase
			end
			STYPE: {PCSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite} = 11'b00100010010;
			JTYPE: {PCSrc, resultSrc, memWrite, immSrc, regWrite} = 9'b011000101;
			BTYPE: 
			begin
				{memWrite, ALUSrc, immSrc, regWrite} = 6'b000110;
				case(func3)
					BEQ:
					begin
						ALUControl <= 3'b001;
						PCSrc <= zero ? 2'b01 : 2'b00;
					end
					BNE:
					begin
						ALUControl <= 3'b001;
						PCSrc <= zero ? 2'b00 : 2'b01;
					end
					BLT:
					begin
						ALUControl <= 3'b101;
						PCSrc <= LSB ? 2'b01 : 2'b00;
					end
					BGE:
					begin
						ALUControl <= 3'b101;
						PCSrc <= LSB ? 2'b00 : 2'b01;
					end
				endcase
			end
			UTYPE: {PCSrc, resultSrc, memWrite, immSrc, regWrite} = 9'b001101001;
			LWTYPE: {PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite} = 13'b0001000010001;
			JALRTYPE: {PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite} = 13'b1010000010001;

		endcase
	end
endmodule