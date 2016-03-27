module alucontrol(funct,aluop,out,jumpreg);
input [5:0] funct;
input [2:0] aluop;
output [2:0] out;
output jumpreg;
reg jumpreg;
reg [2:0] out;
parameter [2:0] s0=000,s1=001,s2=010,s9=011,s12=100;
parameter [5:0] s3=6'h20,s4=6'h22,s5=6'h24,s6=6'h25,s7=6'h2A ,s8=6'h8,s10=6'h27,s11=6'h0;

initial
begin
jumpreg=0;
end
always @(aluop ,funct)
begin
jumpreg=0;
case(aluop)
s0: out=000; // add for lw and sw
s1: out=001; // sub for branch
s9: out=010; //and for andi
s12: out=011; //ori
s2:case(funct)
s3: out=000; // add rtype 
s4: out=001; //sub 
s5: out=010;  //and 
s6: out=011; // or 
s7: out=101; // slt
s10: out=100 ; //nor
s11:out=110 ; //sll
s8: jumpreg=1; //jumpreg

endcase
endcase
end
endmodule



