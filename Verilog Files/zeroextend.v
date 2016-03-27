module zero_ext (in ,out);
input [15:0]in;
output[31:0] out;
reg x=16'b0;
assign out={x,in};
endmodule

