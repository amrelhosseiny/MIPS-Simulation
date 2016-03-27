module Mux1 (a,b,out1,sel);
input[31:0]a,b;
input sel ;
output[31:0] out1;
assign out1 =(sel)?a:b;
endmodule
