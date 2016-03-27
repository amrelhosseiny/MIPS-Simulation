module control_unit(ALUsrc,ALUsrc2,Jumpandlink, MemRead,MemWrite,ALUop,RegDst,Regwrite,Branch,MemtoReg,jump,opcode);//clk,reset
output ALUsrc,jump,ALUsrc2,Jumpandlink,MemRead,MemWrite,RegDst,Regwrite,Branch,MemtoReg;
output [2:0] ALUop;
reg [2:0] ALUop;
reg ALUsrc,ALUsrc2,Jumpandlink, MemRead,jump,MemWrite,RegDst,Regwrite,Branch,MemtoReg;
input [5:0] opcode;
//input clk,reset;
always @(*)
begin
if(opcode==3) Jumpandlink=1'b1;  // jumpandlink             
else Jumpandlink=1'b0;

if(opcode==2) jump=1'b1;  // jump              
else jump=1'b0;

if (opcode ==12 || opcode==13) ALUsrc2=1'b1; //andi,ori
else  ALUsrc2=1'b0;

if(opcode==8) RegDst=1'b0; //addi
else if (opcode==3) RegDst=1'bx;
else RegDst=1'b1;

if(opcode==0 || opcode ==13) RegDst=1'b1; //R_format(add,sub,nor,and,or,jr,sll and slt)
else RegDst=1'b0;

if(opcode==35) MemRead=1'b1; //Lw
else MemRead=1'b0;

if (opcode==43) MemWrite=1'b1; //Sw
else MemWrite=1'b0;

if (opcode==4) Branch=1'b1; // branch 
else Branch=1'b0;


if(opcode==12 || opcode ==3 || opcode ==0 || opcode ==8 || opcode ==1) Regwrite=1'b1; 
else Regwrite=1'b0;


if(opcode===13) RegDst=1'b0;
if(opcode===13) Regwrite=1'b1;


if (opcode==43||opcode==35||opcode==8)  ALUop=3'b000;
else if (opcode==0) ALUop=3'b010;
else if (opcode==12) ALUop=3'b011;
else if (opcode==2) ALUop=3'bxxx;
else if (opcode==13) ALUop=3'b100;
else  ALUop=3'b001;



if (opcode==43||opcode==35 || opcode==8 || opcode==13) ALUsrc=1'b1;
else if (opcode==2 || opcode==3 || opcode==12) ALUsrc=1'bx;
else ALUsrc=0;



if (opcode==35) MemtoReg=1;
else if (opcode==2 || opcode==3 || opcode==43 || opcode==4) MemtoReg=1'bx;
else MemtoReg=0;


if (opcode==2 || opcode==0) Branch=1'b0;



if (opcode==0 || opcode==35) Regwrite=1;
else if(opcode==2 || opcode==43 || opcode==4) Regwrite=0;
 

end
endmodule

/*module cont_unit_tb;

reg  [31:26] opcode;

wire [1:0] ALUop;

wire  ALUsrc, MemRead,MemWrite,RegDst,Regwrite,Branch,MemtoReg;

cont_unit c1 (.ALUsrc(ALUsrc), .MemRead(MemRead),.MemWrite(MemWrite),.RegDst(RegDst),.Regwrite(Regwrite),.Branch(Branch),.MemtoReg(MemtoReg),.ALUop(ALUop),.opcode(opcode));
initial
begin
end 
endmodule*/ 

