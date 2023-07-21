module decoder(jalr, jal, branch, zero, LSB, func3, PCSrc);
	input jalr, jal, branch, zero, LSB;
	input[2:0] func3;
	output reg[1:0] PCSrc=2'b00;

	parameter[2:0] BEQ = 3'b000, BNE = 3'b001, BLT = 3'b100, BGE = 3'b101;
	
	always@(jalr, jal, branch, zero, LSB)
	begin
		if(jal)
			PCSrc = 2'b01;
		else if(jalr)
			PCSrc = 2'b10;
		else if(branch)
		begin
			case(func3)
				BEQ: PCSrc = zero ? 2'b01 : 2'b00;
				BNE: PCSrc = zero ? 2'b00 : 2'b01;
				BLT: PCSrc = LSB ? 2'b01 : 2'b00;
				BGE: PCSrc = LSB ? 2'b00 : 2'b01;
			endcase
		end
		
		else
			PCSrc = 2'b00;
	end
endmodule
	
