module TB();
	reg clk=1'b0;
	CPU myCPU(clk);
	always begin
		#10 clk = ~clk;
	end
	initial begin
		#10000 $stop;
	end
endmodule
