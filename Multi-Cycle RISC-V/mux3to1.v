module mux3to1(i0, i1, i2, sel, out);
	input[31:0] i0, i1, i2;
	input[1:0] sel;
	output[31:0] out;
	assign out = (sel==2'b00) ? i0:
			(sel==2'b01) ? i1:
			(sel==2'b10) ? i2: 0;
endmodule
