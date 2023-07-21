module controller(start, run, D, rs, inc, cout, empty, emptyQ, RST, clk, row, col, loadR, loadC, loadCnt, clrCnt, sel, pop, en, push, 
											pushQ, popQ, rstOut, write, fail, done);
	
	input start, run, D, rs, inc, cout, empty, emptyQ, RST, clk;
	input[3:0] row, col;
	output loadR, loadC, loadCnt, clrCnt, sel, pop, en, push, pushQ, popQ, rstOut, write, fail, done;
	reg loadR, loadC, loadCnt, clrCnt, sel, pop, en, push, pushQ, popQ, rstOut, write, fail, done;
	parameter[4:0] Q0=5'b00000, Q1=5'b00001, Q2=5'b00010, Q3=5'b00011, Q4=5'b00100, Q5=5'b00101, Q6=5'b00110, Q7=5'b00111, Q8=5'b01000, 
			Q9=5'b01001, Q10=5'b01010, Q11=5'b01011, Q12=5'b01100, Q13=5'b01101, Q14=5'b01110, Q15=5'b01111, Q16=5'b10000, 
			Q17=5'b10001, Q18=5'b10010, Q19=5'b10011, Q20=5'b10100, Q21=5'b10101, Q22=5'b10110, Q23=5'b10111;
	reg[4:0] ps=Q22, ns;
	always@(posedge clk, posedge RST)
	begin
		if(RST)
			ps = Q22;
		else
			ps = ns; 
	end
	always@(ps, start, run, D, rs, inc, cout, empty, emptyQ, row, col)
	begin
		case(ps)
			Q0:ns = Q23;
			Q1:ns = (rs==1 & ({inc,row}!=5'b00000) & ({inc, row}!=5'b11111)) ? Q3 :
				(rs==0 & ({inc,col}!=5'b00000) & ({inc, col}!=5'b11111)) ? Q8 :
				(rs==1 & ({inc,row}==5'b11111) & cout==1) ? Q9:
				Q2;
			Q2:ns = Q1;
			Q3:ns = Q4;
			Q4:ns = Q5;
			Q5:ns = (D==1) ? Q9 : Q6;
			Q6:ns = ({row, col}==8'b11111111) ? Q18 : Q7;
			Q7:ns = Q1;
			Q8:ns = Q4;
			Q9:ns = (empty==1) ? Q17 : Q10;
			Q10:ns = Q11;
			Q11:ns = (rs==1) ? Q12 : Q13;
			Q12:ns = Q14;
			Q13:ns = Q14;
			Q14:ns = Q15;
			Q15:ns = (cout==1) ? Q16 : Q1;
			Q16:ns = Q9;
			Q17:ns = Q22;
			Q18:ns = Q19;
			Q19:ns = (empty==1) ? Q20 : Q18;
			Q20:ns = (run==1) ? Q21 : Q20;
			Q21:ns = (emptyQ==1) ? Q22 : Q21;
			Q22:ns = (start==1) ? Q0 : Q22;
			Q23:ns = Q1;
			default:ns = Q22;
		endcase
	end
	always@(ps)
	begin
		{loadR, loadC, loadCnt, clrCnt, sel, pop, en, push, pushQ, popQ, rstOut, write, fail, done} = 14'b00000000000000;
		case(ps)
			Q0: {rstOut, clrCnt} = 2'b11;
			Q1: sel = 1'b1;
			Q2: en = 1'b1;
			Q3: {push, loadR, sel} = 3'b111;
			Q4: ;
			Q5: write = 1'b1;
			Q6: ;
			Q7: clrCnt = 1'b1;
			Q8: {push, loadC, sel} = 3'b111;
			Q9: ;
			Q10: pop = 1'b1;
			Q11: sel = 1'b0;
			Q12: loadR = 1'b1;
			Q13: loadC = 1'b1;
			Q14: loadCnt = 1'b1;
			Q15: en = 1'b1;
			Q16: ;
			Q17: fail = 1'b1;
			Q18: pop = 1'b1;
			Q19: pushQ = 1'b1;
			Q20: done = 1'b1;
			Q21: {popQ, done} = 2'b11;
			Q22: ;
			Q23: write = 1'b1;
		endcase
	end
endmodule




