module intelRat(start, run, RST, clk, fail, done, move);
	input start, run, RST, clk;
	output fail, done;
	output[1:0] move;
	wire loadR, loadC, loadCnt, clrCnt, sel, en, push, pop, pushQ, popQ, rst, rs, inc, cout, empty, emptyQ;
	wire[3:0] row, col;
	wire DWrite, write, DRead;
	dataPath dp(loadR, loadC, loadCnt, clrCnt, sel, en, push, pop, pushQ, popQ, rst, clk, row, col, move, rs, inc, cout, 
			empty, emptyQ);
	controller cu(start, run, DRead, rs, inc, cout, empty, emptyQ, RST, clk, row, col, loadR, loadC, loadCnt, clrCnt, sel, pop, en, 
			push, pushQ, popQ, rst, write, fail, done);
	assign DWrite = 1'b1;
	mazeMemory mem(DWrite, row, col, write, clk, DRead);
endmodule