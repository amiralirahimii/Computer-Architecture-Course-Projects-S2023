module circuit(clk);
	input clk;
	wire[31:0] instR, readData, PCOut, ALUResultOut, writeData;
	wire memWrite;
	instMemory myInstMemory(PCOut, instR);
	dataMemory myDataMemory(ALUResultOut, writeData, memWrite, clk, readData);
	CPU myCPU(clk, instR, readData, PCOut, ALUResultOut, writeData, memWrite);

endmodule