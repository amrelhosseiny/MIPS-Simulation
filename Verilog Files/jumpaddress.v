
module jumpaddress(in1,in2,out);
input [27:0] in1;
input [3:0] in2;
output [31:0] out;
assign out[31:2]={in2, in1[25:0]};
assign out[1:0]=2'b0;
endmodule 
