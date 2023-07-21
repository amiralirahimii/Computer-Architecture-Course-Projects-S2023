module TB();
	reg start, run, RST, clk;
	wire fail, done;
	wire[1:0] move;
	intelRat myRat(start, run, RST, clk, fail, done, move);
	initial
	begin
		clk = 1'b0;
		RST = 1'b0;
		run = 1'b0;
		start = 1'b0;
		#30 start = 1'b1;
		#30 start = 1'b0;
		#10000 run = 1'b1;
		#100000 $stop;
	end
	always
	begin
		#10 clk = ~clk;
	end
endmodule