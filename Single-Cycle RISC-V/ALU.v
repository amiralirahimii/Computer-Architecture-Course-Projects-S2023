module ALU(A, B, op, zero, out);
	input signed[31:0] A, B;
	input[2:0] op;
	output zero;
	output[31:0] out;
	assign out = (op==3'b000) ? A + B:
			(op==3'b001) ? A - B:
			(op==3'b010) ? A & B:
			(op==3'b011) ? A | B:
			(op==3'b100) ? A ^ B:
			(op==3'b101) ? ((A < B)? 1 : 0) : 0;
	assign zero = ~|out;
endmodule
