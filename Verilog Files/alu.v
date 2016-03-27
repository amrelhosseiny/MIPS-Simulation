module ALU_v ( A, B, Alu_op, shamt, Alu_result, Zero );
	input [31:0] A,B;
	input [2:0] Alu_op;
        input [4:0] shamt;
	output reg [31:0] Alu_result;
	output Zero ;
	assign Zero = (Alu_result==0);
	always@(A, B, Alu_op) begin
     #200
       	   case(Alu_op) 
                0:Alu_result <= A+B; //lw &sw &addi (rs +imm) ,add (rs+rt) ;
                 1:Alu_result <= A-B; //sub ,beq
                 2:Alu_result <= A&B ;//and , andi (b=sign extation)
                 3:Alu_result<= A|B ;//or ,ori(b=sign extation)
                4:Alu_result<= ~(A|B);//nor
                 5:Alu_result <= (A<B)? 1:0 ; //slt:
                 6:Alu_result <= B << shamt ;
                  default : Alu_result <= 0;
                endcase

              end
endmodule
