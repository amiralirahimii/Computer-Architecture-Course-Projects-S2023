module controller(clk, op, func3, func7, zero, LSB, PCWrite, adrSrc, memWrite, IRWrite, resultSrc, ALUControl, ALUSrcA, ALUSrcB, immSrc, regWrite);
	input clk, zero, LSB;
	input[6:0] op, func7;
	input[2:0] func3;
	output reg PCWrite, adrSrc, memWrite, IRWrite, regWrite;
	output reg[2:0] ALUControl, immSrc;
	output reg[1:0] resultSrc, ALUSrcA, ALUSrcB;

	parameter[4:0] Q0=5'b00000, Q1=5'b00001, Q2=5'b00010, Q3=5'b00011, Q4=5'b00100, Q5=5'b00101, Q6=5'b00110, Q7=5'b00111, Q8=5'b01000,
			Q9=5'b01001, Q10=5'b01010, Q11=5'b01011, Q12=5'b01100, Q13=5'b01101, Q14=5'b01110, Q15=5'b01111, Q16=5'b10000, Q17=5'b10001,
			Q18=5'b10010;

	parameter[6:0] RTYPE = 7'b0110011, ITYPE = 7'b0010011, STYPE = 7'b0100011, JTYPE = 7'b1101111,
		 BTYPE = 7'b1100011, UTYPE = 7'b0110111, LWTYPE = 7'b0000011, JALRTYPE = 7'b1100111;
	parameter[9:0] ADD = 10'b0000_0000_00, SUB = 10'b0100_0000_00, AND = 10'b0000_0001_11, OR = 10'b0000_0001_10, SLT = 10'b0000_0000_10;
	parameter[2:0] LW = 3'b010, ADDI = 3'b000, XORI = 3'b100, ORI = 3'b110, SLTI = 3'b010, JALR = 3'b000, 
			SW = 3'b010,
			BEQ = 3'b000, BNE = 3'b001, BLT = 3'b100, BGE = 3'b101;
	reg[4:0] ps=Q0, ns;

	always@(posedge clk)
	begin
		ps <= ns;
	end
	
	always@(ps, zero, LSB, op, func7, func3)
	begin
		case(ps)
			Q0:ns = Q1;
			Q1:ns = (op == RTYPE) ? Q2 :
				(op == LWTYPE) ? Q4 :
				(op == ITYPE) ? Q7 :
				(op == JALRTYPE) ? Q9 :
				(op == STYPE) ? Q12 :
				(op == JTYPE) ? Q14 :
				(op == BTYPE) ? Q17 :
				(op == UTYPE) ? Q18 : Q0;
			Q2:ns = Q3;
			Q3:ns = Q0;
			Q4:ns = Q5;
			Q5:ns = Q6;
			Q6:ns = Q0;
			Q7:ns = Q8;
			Q8:ns = Q0;
			Q9:ns = Q10;
			Q10:ns = Q11;
			Q11:ns = Q0;
			Q12:ns = Q13;
			Q13:ns = Q0;
			Q14:ns = Q15;
			Q15:ns = Q16;
			Q16:ns = Q0;
			Q17:ns = Q0;
			Q18:ns = Q0;
			default: ns = Q0;
		endcase
	end
	
	always@(ps, zero, LSB, op, func7, func3)
	begin
	{PCWrite, adrSrc, memWrite, IRWrite, resultSrc, ALUControl, ALUSrcA, ALUSrcB, immSrc, regWrite} = 17'b0;
		case(ps)
			Q0:{adrSrc, IRWrite, ALUSrcA, ALUSrcB, ALUControl, resultSrc, PCWrite} = 12'b0100_1000_0101;
			Q1:{ALUSrcA, ALUSrcB, ALUControl, immSrc} = 10'b0101_0000_11;
			Q2:
			begin
				{ALUSrcA, ALUSrcB} = 4'b1000;
				case({func7, func3})
					ADD: ALUControl = 3'b000;
					SUB: ALUControl = 3'b001;
					AND: ALUControl = 3'b010;
					OR: ALUControl = 3'b011;
					SLT: ALUControl = 3'b101;
				endcase
			end
			Q3:{resultSrc, regWrite} = 3'b001;
			Q4:{ALUSrcA, ALUSrcB, ALUControl, immSrc} = 10'b1001_0000_00;
			Q5:{resultSrc, adrSrc} = 3'b001;
			Q6:{resultSrc, regWrite} = 3'b011;
			Q7:
			begin
				{ALUSrcA, ALUSrcB, immSrc} = 7'b1001_000;
				case(func3)
					ADDI: ALUControl = 3'b000;
					XORI: ALUControl = 3'b100;
					ORI: ALUControl = 3'b011;
					SLTI: ALUControl = 3'b101;
				endcase
			end
			Q8:{resultSrc, regWrite} = 3'b001;
			Q9:{ALUSrcA, ALUSrcB, ALUControl} = 7'b0110_000;
			Q10:{resultSrc, regWrite} = 3'b001;
			Q11:{ALUSrcA, ALUSrcB, ALUControl, resultSrc, PCWrite, immSrc} = 13'b1001_0001_0100_0;
			Q12:{ALUSrcA, ALUSrcB, immSrc, ALUControl} = 10'b1001_0010_00;
			Q13:{resultSrc, adrSrc, memWrite} = 4'b0011;
			Q14:{ALUSrcA, ALUSrcB, ALUControl} = 7'b0110_000;
			Q15:{resultSrc, regWrite} = 3'b001;
			Q16:{ALUSrcA, ALUSrcB, ALUControl, resultSrc, PCWrite, immSrc} = 13'b0101_0001_0101_0;
			Q17:
			begin
				{ALUSrcA, ALUSrcB, resultSrc} = 6'b1000_00;
				case(func3)
					BEQ:
					begin
						ALUControl <= 3'b001;
						PCWrite <= zero ? 1 : 0;
					end
					BNE:
					begin
						ALUControl <= 3'b001;
						PCWrite <= zero ? 0 : 1;
					end
					BLT:
					begin
						ALUControl <= 3'b101;
						PCWrite <= LSB ? 1 : 0;
					end
					BGE:
					begin
						ALUControl <= 3'b101;
						PCWrite <= LSB ? 0 : 1;
					end
				endcase
			end
			Q18:{immSrc, resultSrc, regWrite} = 6'b1001_11;
		endcase
	end
endmodule
