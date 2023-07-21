module reg4bit(dataIn, load, rst, clk, dataOut);
	input[3:0] dataIn;
	input load, rst, clk;
	output reg [3:0] dataOut;
	always@(posedge clk)
	begin
		if(rst)
			dataOut <= 4'b0000;
		else if(load)
			dataOut <= dataIn;
		else
			dataOut <= dataOut;
	end
endmodule