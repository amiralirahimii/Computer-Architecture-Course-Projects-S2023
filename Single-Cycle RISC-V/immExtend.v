module immExtend(in, immSrc, out);
	input[31:7] in;
	input[2:0] immSrc;
	output[31:0] out;
	assign out = (immSrc == 3'b000) ? {{20{in[31]}}, in[31:20]}:
		(immSrc == 3'b001) ? {{20{in[31]}}, in[31:25], in[11:7]}:
		(immSrc == 3'b010) ? {{12{in[31]}}, in[31], in[19:12], in[20], in[30:21], 1'b0}:
		(immSrc == 3'b011) ? {{19{in[31]}}, in[31], in[7], in[30:25], in[11:8], 1'b0}:
		(immSrc == 3'b100) ? {in[31:12], 12'b0}:
		32'b0;
endmodule