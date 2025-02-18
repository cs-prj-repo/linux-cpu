
module decode(
    input wire clk,                    // 时钟信号
    input wire rst,                    // 复位信号
    input wire [31:0] regD_i_instr,    // 输入指令	

	input wire [63:0] write_back_i_data,
	input wire [4:0]  write_back_i_rd,
	input wire 		  write_back_i_reg_wen,

	output wire [9:0]  decode_o_alu_info,
	output wire [1:0]	decode_o_opcode_info,
	
	//译码得出来的数据信息
    output wire [63:0]  decode_o_regdata1,   
    output wire [63:0]  decode_o_regdata2,   
	output wire [63:0]  decode_o_imm,

	//要写回的数据
	output wire [4:0]	decode_o_rd,
	output wire 	   	decode_o_reg_wen
);


wire [31:0] instr  = regD_i_instr;
wire [6:0]  opcode = instr[6:0];
wire [4:0]	rd 	   = instr[11:7];
wire [2:0]  func3  = instr[14:12]; 
wire [4:0]  rs1    = instr[19:15];
wire [4:0]  rs2    = instr[24:20];
wire [6:0]  func7  = instr[31:25];


//====================================func3=======func7===imm=====================================
wire func3_000 					= (func3 == 3'b000);
wire func3_001  				= (func3 == 3'b001);
wire func3_010  				= (func3 == 3'b010);
wire func3_011  				= (func3 == 3'b011);
wire func3_100 					= (func3 == 3'b100);
wire func3_101  				= (func3 == 3'b101);
wire func3_110					= (func3 == 3'b110);
wire func3_111					= (func3 == 3'b111);
wire func7_0000000 				= (func7 == 7'b0000000);
wire func7_0100000              = (func7 == 7'b0100000);
wire func7_0000001				= (func7 == 7'b0000001);

wire inst_alu_reg			= (opcode == 7'b01_100_11);
wire inst_alu_imm			= (opcode == 7'b00_100_11); 

//alu_reg
wire inst_add  				= (inst_alu_reg  & func3_000 & func7_0000000);
wire inst_sub  				= (inst_alu_reg  & func3_000 & func7_0100000);
wire inst_sll  				= (inst_alu_reg  & func3_001 & func7_0000000);
wire inst_slt  				= (inst_alu_reg  & func3_010 & func7_0000000);
wire inst_sltu 				= (inst_alu_reg  & func3_011 & func7_0000000);
wire inst_xor  				= (inst_alu_reg  & func3_100 & func7_0000000);
wire inst_srl  				= (inst_alu_reg  & func3_101 & func7_0000000);
wire inst_sra  				= (inst_alu_reg  & func3_101 & func7_0100000);
wire inst_or   				= (inst_alu_reg  & func3_110 & func7_0000000);
wire inst_and  				= (inst_alu_reg  & func3_111 & func7_0000000);
//alu_imm
wire inst_addi  			= (inst_alu_imm & func3_000);
wire inst_slli 	 			= (inst_alu_imm & func3_001);
wire inst_slti  			= (inst_alu_imm & func3_010);
wire inst_sltiu 			= (inst_alu_imm & func3_011);
wire inst_xori  			= (inst_alu_imm & func3_100);
wire inst_srli  			= (inst_alu_imm & func3_101 & func7_0000000);
wire inst_srai  			= (inst_alu_imm & func3_101 & func7_0100000);
wire inst_ori   			= (inst_alu_imm & func3_110);
wire inst_andi 			   	= (inst_alu_imm & func3_111);


assign decode_o_opcode_info = {
		inst_alu_reg,
		inst_alu_imm
};
assign decode_o_alu_info = {
		(inst_add  	| inst_addi ), //9
		(inst_sub               ), //8
		(inst_sll  	| inst_slli ), //7
		(inst_slt  	| inst_slti ), //6
		(inst_sltu 	| inst_sltiu), //5
		(inst_xor  	| inst_xori ), //4
		(inst_srl  	| inst_srli ), //3
		(inst_sra  	| inst_srai ), //2
		(inst_or   	| inst_ori  ), //1
		(inst_and  	| inst_andi )  //0
};
wire [63:0] inst_i_imm = { {52{instr[31]}}, instr[31:20] };		
wire [63:0] inst_r_imm =   64'd0;	

wire inst_i_type = inst_alu_imm;
wire inst_r_type = inst_alu_reg;

assign decode_o_imm = 	inst_i_type ? inst_i_imm : 
						inst_r_type ? inst_r_imm : 64'd0;

assign decode_o_rd  		=  rd;

assign decode_o_reg_wen = inst_i_type | inst_r_type;

wire [63:0] regfile_o_regdata1;
wire [63:0] regfile_o_regdata2;
regfile u_regfile(
	.clk                     	(clk                 ),
	.rst                     	(rst                 ),
	.write_back_i_rd      		(write_back_i_rd      		),
	.write_back_i_data    		(write_back_i_data     		),
	.write_back_i_reg_wen 		(write_back_i_reg_wen  		),
	.decode_i_rs1            	(rs1             			),
	.decode_i_rs2            	(rs2             			),
	.regfile_o_regdata1      	(regfile_o_regdata1     	),
	.regfile_o_regdata2      	(regfile_o_regdata2       	)
);
//execute阶段数据前递
assign decode_o_regdata1 = regfile_o_regdata1; 
assign decode_o_regdata2 = regfile_o_regdata2; 

endmodule
