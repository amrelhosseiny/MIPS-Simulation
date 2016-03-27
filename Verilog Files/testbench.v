module integrated();
reg reset;
reg clk;
wire [31:0] w1,w2,w9,w10,w13,w14,w15,w17,w19,w20,w21,w22,w33,w34,w39,w40,w41,w43,w45,w47,w48;
wire[15:0] w11 ;
wire[4:0] w3,w4,w5,w6,w7,w16,w8;
wire w24,w25,w26,w28,w29,w30,w31,w32,w35,w36,w37,w38,w46;
wire [5:0] w12,w23;
wire[2:0] w18;
wire[2:0] w27;
wire[27:0] w42;
wire [3:0] w44;
assign w23 = w2[31:26];
assign w44 = w43 [31:28];
assign w3 = w2[25:21];
assign w4 = w2 [20:16];
assign w5 = w2 [15:11];
assign w11 = w2 [15:0];
assign w16 = w2 [10:6];
assign w12 = w2 [5:0];
assign w42 =  w2 [27:0];
assign w8=5'b11111;
assign w47 = w43;
pc x1(.in(w41),.out(w1) ,.clock(clk),.reset(reset));
incr_pc x50 (.in1(w1),.out1(w43));
instmemory x2(.pc(w1), .data_out(w2));

 bitmux_5 des1(.b(w4) ,.a(w5), .out1(w6) ,.sel(w29));
 bitmux_5 des2 (.b(w6) ,.a(w8), .out1(w7) ,.sel(w30));
signext x4(.in(w11), .out(w13)); 
zero_ext x5(.in(w11) , .out(w48));
memoryfile x6(.readreg1(w3) , .readreg2(w4) , .writereg(w7) , .regwrite(w24) , .writedata(w9) , .readdata1(w15) , .readdata2(w10),.clk(clk));
control_unit x7(.ALUsrc(w25), .ALUsrc2(w46),.Jumpandlink(w30), .MemRead(w31), .MemWrite(w26),.ALUop(w27),.RegDst(w29), .Regwrite(w24), .Branch(w35),.MemtoReg(w28), .jump(w38),.opcode(w23));//clk,re
Mux1 rt_s (.b(w10),.a(w13),.sel(w25),.out1(w14));
Mux1 m1 (.b(w14), .a(w48), .sel(w46), .out1(w17));
ALU_v x9 ( .A(w15), .B(w17), .Alu_op(w18), .Alu_result(w19), .Zero(w36),.shamt(w16) ); 
Mux1 memreg (.b(w19), .a(w21),.sel(w28), .out1(w22));
Mux1 jal(.b(w22) ,.a(w47) ,.sel(w30) ,.out1(w9));
alucontrol x10(.funct(w12), .aluop(w27),.out(w18),.jumpreg(w32));
jumpaddress x11(.in1(w42),.in2(w44),.out(w45));
and x12(w37,w36,w35);
data_memory x13( .clk(clk) , .address(w19),.data_in(w10), .data_out(w21) , .read(w31) ,.write(w26));
alu_branch x14(.in1(w43),.in2(w40),.out1(w39)); 
Mux1 pcscr (.b(w43),.a(w39),.out1(w34),.sel(w37));
Mux1 jump(.b(w34),.a(w45),.out1(w33),.sel(w38));
shiftleft x16(.in(w13),.out(w40));
Mux1 r1 (.b(w33),.a(w15),.out1(w41),.sel(w32));
initial
begin
clk=1;
forever
begin 
 # 500 clk =!clk;
end
end

initial 
begin
reset = 1;
#400 reset=0;
end
always@(posedge clk)
begin
$display ($time," %d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",w1,w2,w15,w17,w19,w21,w9,w37,w34,w38,w33,w32,w23,w41);
end






endmodule
