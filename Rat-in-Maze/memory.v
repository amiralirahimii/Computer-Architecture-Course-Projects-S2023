module mazeMemory(in, row, col, write, clk, out);
	input[3:0] row, col;
	input in, write, clk;
	output out;
	reg[0:15] memory[0:15];

	initial
	begin
		$readmemh("Mem.data.txt", memory);
	end

	always@(posedge clk)
	begin
		if(write)
			memory[row][col] <= in;
	end
	assign out = memory[row][col];
endmodule