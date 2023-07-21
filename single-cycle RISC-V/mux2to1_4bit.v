module mux2to1_4bit(i0, i1, sel, out);
	input[3:0] i0, i1;
	input sel;
	output [3:0]out;
	assign out = (sel==0) ? i0 : i1;
endmodule