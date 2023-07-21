module reg32bit(in, clk, out);
	input[31:0] in;
	input clk;
	output reg[31:0] out=32'b0;
	always@(posedge clk)
	begin
		out <= in;
	end
endmodule
