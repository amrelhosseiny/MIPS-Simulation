module memoryfile (readreg1 , readreg2 , writereg , regwrite , writedata , readdata1 , readdata2,clk);

input readreg1 , readreg2 , writereg , regwrite , writedata ,clk ;
output readdata1 , readdata2 ;

wire [4:0]readreg1;
wire [4:0] readreg2;
wire [4:0] writereg;
wire regwrite ,clk;
wire [31:0] writedata;

reg [31:0] readdata1;
reg [31:0] readdata2;

reg [31:0] Reg [0:31];

initial begin
Reg[0] =0;
end


always @ (readreg1 , readreg2)fork
readdata1 = Reg [readreg1];
readdata2 = Reg [readreg2];
join
always @ (posedge clk)begin
if (regwrite == 1'b1)
Reg[writereg] = writedata;
end


endmodule 
