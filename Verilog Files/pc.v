module pc(in,out,clock,reset);
input [31:0] in;
input clock,reset ;
output[31:0] out ;
reg [31:0] out;
wire [31:0] in;
initial 
begin 
out<=32'b0;
end
 
always @(posedge clock)

begin 
if (reset)
out<=32'b0;
else 
out=in ;
end 
endmodule 
