module stack(in, push, pop, rst, clk, out, empty);
	input[1:0] in;
	input push, pop, rst, clk;
	output[1:0] out;
	reg[1:0] out;
	output empty;
	reg[1:0] sMem[0:255];
	reg[7:0] size;
	assign empty = ~|size;
	always@(posedge clk, posedge rst)
	begin
		if(rst)
			size <= 8'b00000000;
		else if(pop)
		begin
			if(!empty)
			begin
				out = sMem[size-1];
				size = size-1;
				
			end
		end
		else if(push)
		begin
			begin
				sMem[size] = in;
				size = size+1;
			end
		end
	end
endmodule
