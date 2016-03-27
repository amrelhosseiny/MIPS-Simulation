module addpc4(in1,out1);
input [31:0] in1;
output [31:0] out1;
assign out1= in1+ 32'b100;
endmodule
