module circuit(clk);
	input clk;
	wire[31:0] readData, adrOut, writeData;
	wire memWrite;
	CPU myCPU(clk, readData, adrOut, writeData, memWrite);
	dataMemory myDataMemory(adrOut, writeData, memWrite, clk, readData);
endmodule
