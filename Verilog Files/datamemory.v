module data_memory( clk , address,data_in, data_out , read ,write);
input clk,read, write;
input[31:0] address;
input[31:0] data_in;
output[31:0] data_out;
reg[31:0]  data_out;
wire [31:0] data_in; 
wire [31:0] address;
reg[7:0] my_memory[0:255];
 //assign data_out = my_memory[address];
initial
begin
//$fopen("data.txt",r);
$readmemb("data.txt" , my_memory);
end

always @ (read, data_in, address)
#200
begin 
if(read==1) begin
data_out[31:24] <= my_memory[address];
data_out[23:16] <= my_memory[address+1];
data_out[15:8] <= my_memory[address+2];
data_out[7:0] <= my_memory[address+3];
end
end

always@(posedge clk)
#200
begin
if(write==1)
begin
my_memory[address+3]<= data_in[7:0];
my_memory[address+2]<= data_in[15:8];
my_memory[address+1]<= data_in[23:16];
my_memory[address]<= data_in[31:24];
end
end
endmodule
