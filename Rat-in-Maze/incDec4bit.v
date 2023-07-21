module incDec4bit(dataIn, incDec, dataOut);
	input[3:0] dataIn;
	input incDec;
	output [3:0] dataOut;
	assign dataOut = (incDec==1) ? (dataIn+1) : (dataIn-1);
endmodule