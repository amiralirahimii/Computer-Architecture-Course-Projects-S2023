module adder32bit(A, B, out);
	input[31:0] A, B;
	output[31:0] out;
	assign out = A + B;
endmodule
