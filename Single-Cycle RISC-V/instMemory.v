module instMemory(A, RD);
	input[31:0] A;
	output[31:0] RD;
	wire[31:0] A00;
	assign A00 = {2'b00, A[31:2]};
	reg[31:0] mem[0:16383];
	initial $readmemh("instructionMemory.txt", mem);

	assign RD = mem[A00];
	
endmodule
