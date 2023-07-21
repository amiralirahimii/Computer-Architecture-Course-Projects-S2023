module regFile(A1, A2, A3, WD, regWrite, clk, RD1, RD2);
	input[4:0] A1, A2, A3;
	input[31:0] WD;
	input regWrite, clk;
	output[31:0] RD1, RD2;
	reg[31:0] mem[0:31];
	initial begin
	mem[0] = 32'b0;
	end
	assign RD1 = mem[A1];
	assign RD2 = mem[A2];
	always@(negedge clk)// WARNING: check here bitch
	begin
		if(regWrite && A3!=32'b0)
			mem[A3] <= WD;
		else
			mem[A3] <= mem[A3];
	end
endmodule
