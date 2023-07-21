module dataMemory(A, WD, memWrite, clk, RD);
	input[31:0] A, WD;
	input memWrite, clk;
	output[31:0] RD;
	wire[31:0] A00;
	assign A00 = {2'b00, A[31:2]};
	reg[31:0] mem[0:16383];
	initial $readmemh("dataMemory.txt", mem);

	assign RD = mem[A00];
	always@(posedge clk)
	begin
		if(memWrite)
			mem[A00] <= WD;
		else
			mem[A00] <= mem[A00];
	end
endmodule
