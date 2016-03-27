module instmemory(data_out,pc);

input[31:0] pc;
output[31:0] data_out;


reg[7:0] memory[0:255];

initial
begin
$readmemb("ins.txt", memory);
end


   assign #200 data_out[31:24] = memory[pc];

  assign # 200 data_out[23:16] = memory[pc+1];
  assign #200 data_out[15:8] = memory[pc+2];
 assign #200 data_out[7:0] = memory[pc+3];


endmodule
