module counter2bit(dataIn, load, enable, rst, clk, dataOut, cout);
	input[1:0] dataIn;
	input load, enable, rst, clk;
	output reg[1:0] dataOut;
	output cout;
	always@(posedge clk)
	begin
		if(rst)
			dataOut <= 2'b00;
		else if(load)
			dataOut <= dataIn;
		else if(enable)
			dataOut <= dataOut + 1;
		else
			dataOut <= dataOut;
	end
	assign cout = &dataOut;
endmodule
