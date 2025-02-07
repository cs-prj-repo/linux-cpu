module execute(
    input wire  [27:0]  regE_i_alu_info,
    input wire  [11:0]  regE_i_opcode_info,
    input wire  [5:0]   regE_i_branch_info,
    input wire  [10:0]  regE_i_load_store_info,
    input wire [63:0]   regE_i_regdata1,
    input wire [63:0]   regE_i_regdata2,
    input wire [63:0]   regE_i_imm,
    input wire [63:0]   regE_i_pc,

    input wire  [63:0]  regE_i_commit_pre_pc,  // 输出提交PC

    output wire [63:0]  execute_o_commit_pre_pc,
    output wire         execute_o_is_jump,
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

wire alu_add        =  regE_i_alu_info[27];
wire alu_sub        =  regE_i_alu_info[26];
wire alu_sll        =  regE_i_alu_info[25];
wire alu_slt        =  regE_i_alu_info[24];
wire alu_sltu       =  regE_i_alu_info[23];
wire alu_xor        =  regE_i_alu_info[22];
wire alu_srl        =  regE_i_alu_info[21];
wire alu_sra        =  regE_i_alu_info[20];
wire alu_or         =  regE_i_alu_info[19];
wire alu_and        =  regE_i_alu_info[18];


wire [63:0] alu_src1 = op_alu_reg ? regE_i_regdata1 : 
                       op_alu_imm ? regE_i_regdata1 : 64'd0;

wire [63:0] alu_src2 = op_alu_reg ? regE_i_regdata2 : 
                       op_alu_imm ? regE_i_imm      : 64'd0;
                       
assign execute_o_alu_result = op_lui    ?               regE_i_imm :
                              op_auipc  ?   regE_i_pc + regE_i_imm :
                              op_jal    ?   regE_i_pc + regE_i_imm : 
                              alu_add   ?   alu_src1  + alu_src2   : 
                              alu_sub   ?   alu_src1  - alu_src2   : 64'd0;

assign execute_o_commit_pre_pc = op_jal ? execute_o_alu_result : regE_i_commit_pre_pc;
assign execute_o_is_jump       = op_jal;
//branch
// wire inst_beq   = regE_i_branch_info[5];
// wire inst_bne   = regE_i_branch_info[4];
// wire inst_blt   = regE_i_branch_info[3];
// wire inst_bge   = regE_i_branch_info[2];
// wire inst_bltu  = regE_i_branch_info[1];
// wire inst_bgeu  = regE_i_branch_inf;
endmodule



