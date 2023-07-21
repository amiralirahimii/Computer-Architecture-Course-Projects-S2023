module dataPath(loadR, loadC, loadCnt, clrCnt, sel, en, push, pop, pushQ, popQ, rst, clk, row, col, moveOut, rs, inc, cout, empty, 
																emptyQ);
	input loadR, loadC, loadCnt, clrCnt, sel, en, push, pop, pushQ, popQ, rst, clk;
	output[3:0] row, col;
	output[1:0] moveOut;
	output rs, inc, cout, empty, emptyQ;
	wire[3:0] wireRow, wireCol, outMux, inReg;
	wire[1:0] outMux2, stackOut, nStackOut, counterOut;
	wire outXor;
	reg4bit rowReg(inReg, loadR, rst, clk, wireRow);
	reg4bit colReg(inReg, loadC, rst, clk, wireCol);
	mux2to1_4bit mux(wireCol, wireRow, outXor, outMux);
	incDec4bit alu(outMux, outMux2[0], inReg);
	assign outXor = ~^outMux2;
	mux2to1_2bit mux2(nStackOut, counterOut, sel, outMux2);
	assign nStackOut = ~stackOut;
	counter2bit counter(stackOut, loadCnt, en, clrCnt, clk, counterOut, cout);
	stack stackD(counterOut, push, pop, rst, clk, stackOut, empty);
	stack stackQ(stackOut, pushQ, popQ, rst, clk, moveOut, emptyQ);
	assign row = wireRow;
	assign col = wireCol;
	assign rs = outXor;
	assign inc = outMux2[0];
endmodule
