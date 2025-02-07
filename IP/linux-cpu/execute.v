module execute(
    input wire  [27:0]  regE_i_alu_info,
    input wire  [11:0]  regE_i_opcode_info,
    input wire  [5:0]   regE_i_branch_info,
    input wire  [10:0]  regE_i_load_store_info,

    input wire [63:0]   regE_i_regdata1,
    input wire [63:0]   regE_i_regdata2,
    input wire [63:0]   regE_i_imm,
    input wire [63:0]   regE_i_pc,

    output wire [63:0]  execute_o_alu_result
);

wire op_lui        = regE_i_opcode_info[11 ];
wire op_auipc      = regE_i_opcode_info[10 ];
wire op_jal        = regE_i_opcode_info[9 ];
wire op_jalr       = regE_i_opcode_info[8 ];
wire op_alu_reg    = regE_i_opcode_info[7 ];
wire op_alu_regw   = regE_i_opcode_info[6 ];
wire op_alu_imm    = regE_i_opcode_info[5];
wire op_alu_immw   = regE_i_opcode_info[4];
wire op_load       = regE_i_opcode_info[3 ];
wire op_store      = regE_i_opcode_info[2 ];
wire op_branch     = regE_i_opcode_info[1 ];
wire op_system     = regE_i_opcode_info[0];


assign execute_o_alu_result = op_lui   ?             regE_i_imm :
                              op_auipc ? regE_i_pc + regE_i_imm : 64'd0;


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
