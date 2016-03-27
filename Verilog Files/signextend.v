module signext (in , out);
input in;
output out;

wire [15:0] in;
reg [31:0] out;

always @ (in)
 begin
out[31:16] = {16{in[15]}};
out [15:0] = in[15:0];
end

endmodule
