module mux2to1_2bit(i0, i1, sel, out);
	input[1:0] i0, i1;
	input sel;
	output [1:0]out;
	assign out = (sel==0) ? i0 : i1;
endmodule
