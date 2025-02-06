module execute(
    input wire          regE_i_alu_info,
    input wire  [11:0]  regE_i_opcode_info,
    input wire          regE_i_branch_info,


    input wire [63:0]   regE_i_reg_rdata1,
    input wire [63:0]   regE_i_reg_rdata2,
    input wire [63:0]   regE_i_imm,
    input wire [63:0]   regE_i_pc,

    output wire [63:0]  regE_o_alu_result
);

wire op_alu_imm    = opcode_info_i[11];
wire op_alu_immw   = opcode_info_i[10];
wire op_alu_reg    = opcode_info_i[9 ];
wire op_alu_regw   = opcode_info_i[8 ];
wire op_branch     = opcode_info_i[7 ];
wire op_jal        = opcode_info_i[6 ];
wire op_jalr       = opcode_info_i[5 ];
wire op_load       = opcode_info_i[4 ];
wire op_store      = opcode_info_i[3 ];
wire op_lui        = opcode_info_i[2 ];
wire op_auipc      = opcode_info_i[1 ];


assign alu_result = op_lui   ?      regE_i_imm :
                    op_auipc ? pc + regE_i_imm : 64'd0;


//branch
wire inst_beq   = regE_i_branch_info[5];
wire inst_bne   = regE_i_branch_info[4];
wire inst_blt   = regE_i_branch_info[3];
wire inst_bge   = regE_i_branch_info[2];
wire inst_bltu  = regE_i_branch_info[1];
wire inst_bgeu  = regE_i_branch_info[0];


endmodule



// assign inst_alu = opcode_info[4] | opcode_info[5] | opcode_info[6]  | opcode_info[7];
// assign [63:0] alu_result =  (regE_i_alu_info[27])       ?  regE_i_regdata1 + regE_i_regdata2 :  
//                             (regE_i_alu_info[26])       ?  regE_i_regdata1 + regE_i_regdata2 : 
//                             (regE_i_alu_info[25])       ?  regE_i_regdata1 + regE_i_regdata2 : 
//                             (regE_i_alu_info[24])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[23])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[22])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[21])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[20])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[19])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[18])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[17])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[16])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[15])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[14])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[13])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[12])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[11])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[10])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[9 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[8 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[7 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[6 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[5 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[4 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[3 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[2 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[1 ])       ?  regE_i_regdata1 + regE_i_regdata2 :
//                             (regE_i_alu_info[0 ])       ?  regE_i_regdata1 + regE_i_regdata2 : regE_i_regdata1 + regE_i_regdata2;
