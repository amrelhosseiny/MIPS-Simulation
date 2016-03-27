module bitmux_5 (a,b,out1,sel);
input[4:0]a,b;
input sel ;
output[4:0] out1;
assign out1 =(sel)?a:b;
endmodule
