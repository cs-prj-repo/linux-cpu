module top_cpu(
    input  wire clk,
    input  wire rst,

    output wire                 commit,
    output wire [31:0]          commit_instr,
    output wire [63:0]          commit_pc,
    output wire [63:0]          commit_pre_pc,
    output wire [63:0]          cur_pc
);

// output declaration of module pc
reg [63:0] pc;

pc u_pc(
    .clk                 	(clk                  ),
    .rst                 	(rst                  ),
    .execute_i_jump_pc   	(execute_i_jump_pc    ),
    .execute_i_need_jump 	(execute_i_need_jump  ),
    .fetch_i_pre_pc      	(fetch_i_pre_pc       ),
    .pc                  	(pc                   )
);

// output declaration of module fetch
wire [31:0]  fetch_o_instr;
wire [63:0]  fetch_o_pc;
wire [63:0]  fetch_o_pre_pc;
wire [160:0] fetch_o_commit_info;

fetch u_fetch(
    .pc                  	(pc                   ),
    .fetch_o_instr       	(fetch_o_instr        ),
    .fetch_o_pc          	(fetch_o_pc           ),
    .fetch_o_pre_pc      	(fetch_o_pre_pc       ),
    .fetch_o_commit_info 	(fetch_o_commit_info  )
);

// output declaration of module regD
reg [63:0] regD_o_pc;
reg [31:0] regD_o_instr;
reg [160:0] regD_o_commit_info;

regD u_regD(
    .clk                 	(clk                  ),
    .rst                 	(rst                  ),
    .regD_bubble         	(regD_bubble          ),
    .regD_stall          	(regD_stall           ),
    .fetch_i_pc          	(fetch_i_pc           ),
    .fetch_i_instr       	(fetch_i_instr        ),
    .fetch_i_commit_info 	(fetch_i_commit_info  ),
    .regD_o_pc           	(regD_o_pc            ),
    .regD_o_instr        	(regD_o_instr         ),
    .regD_o_commit_info  	(regD_o_commit_info   )
);


// output declaration of module decode
wire [13:0] decode_o_alu_info;
wire [11:0] decode_o_opcode_info;
wire [5:0] decode_o_branch_info;
wire [10:0] decode_o_load_store_info;
wire [63:0] decode_o_regdata1;
wire [63:0] decode_o_regdata2;
wire [63:0] decode_o_imm;
wire [4:0] decode_o_rd;
wire decode_o_reg_wen;

decode u_decode(
    .clk                      	(clk                       ),
    .rst                      	(rst                       ),
    .regD_i_instr             	(regD_i_instr              ),
    .execute_i_alu_result     	(execute_i_alu_result      ),
    .regE_i_rd                	(regE_i_rd                 ),
    .regE_i_reg_wen           	(regE_i_reg_wen            ),
    .regM_i_alu_result        	(regM_i_alu_result         ),
    .regM_i_rd                	(regM_i_rd                 ),
    .regM_i_reg_wen           	(regM_i_reg_wen            ),
    .write_back_i_data        	(write_back_i_data         ),
    .write_back_i_rd          	(write_back_i_rd           ),
    .write_back_i_reg_wen     	(write_back_i_reg_wen      ),

    .decode_o_alu_info        	(decode_o_alu_info         ),
    .decode_o_opcode_info     	(decode_o_opcode_info      ),
    .decode_o_branch_info     	(decode_o_branch_info      ),
    .decode_o_load_store_info 	(decode_o_load_store_info  ),
    .decode_o_regdata1        	(decode_o_regdata1         ),
    .decode_o_regdata2        	(decode_o_regdata2         ),
    .decode_o_imm             	(decode_o_imm              ),
    .decode_o_rd              	(decode_o_rd               ),
    .decode_o_reg_wen         	(decode_o_reg_wen          )
);

// output declaration of module regE
reg [63:0] regE_o_regdata1;
reg [63:0] regE_o_regdata2;
reg [63:0] regE_o_imm;
reg [63:0] regE_o_pc;
reg [4:0] regE_o_rd;
reg regE_o_reg_wen;
reg [13:0] regE_o_alu_info;
reg [10:0] regE_o_load_store_info;
reg [11:0] regE_o_opcode_info;
reg [5:0] regE_o_branch_info;
reg [160:0] regE_o_commit_info;

regE u_regE(
    .regE_o_regdata1        	(regE_o_regdata1         ),
    .regE_o_regdata2        	(regE_o_regdata2         ),
    .regE_o_imm             	(regE_o_imm              ),
    .regE_o_pc              	(regE_o_pc               ),
    .regE_o_rd              	(regE_o_rd               ),
    .regE_o_reg_wen         	(regE_o_reg_wen          ),
    .regE_o_alu_info        	(regE_o_alu_info         ),
    .regE_o_load_store_info 	(regE_o_load_store_info  ),
    .regE_o_opcode_info     	(regE_o_opcode_info      ),
    .regE_o_branch_info     	(regE_o_branch_info      ),
    .regE_o_commit_info     	(regE_o_commit_info      )
);


// output declaration of module execute
wire [63:0] execute_o_alu_result;
wire execute_o_need_jump;
wire [63:0] execute_o_jump_pc;

execute u_execute(
    .regE_i_opcode_info     	(regE_i_opcode_info      ),
    .regE_i_branch_info     	(regE_i_branch_info      ),
    .regE_i_load_store_info 	(regE_i_load_store_info  ),
    .regE_i_alu_info        	(regE_i_alu_info         ),
    .regE_i_regdata1        	(regE_i_regdata1         ),
    .regE_i_regdata2        	(regE_i_regdata2         ),
    .regE_i_imm             	(regE_i_imm              ),
    .regE_i_pc              	(regE_i_pc               ),
    .execute_o_alu_result   	(execute_o_alu_result    ),
    .execute_o_need_jump    	(execute_o_need_jump     ),
    .execute_o_jump_pc      	(execute_o_jump_pc       )
);

// output declaration of module regM
reg [10:0] regM_o_load_store_info;
reg [11:0] regM_o_opcode_info;
reg [63:0]  regM_o_regdata2;
reg [63:0]  regM_o_alu_result;
reg [63:0]      regM_o_pc;
reg [4:0]       regM_o_rd;
reg             regM_o_reg_wen;
wire [160:0]    regE_i_commit_info;

regM u_regM(
    .clk                    	(clk                     ),
    .rst                    	(rst                     ),
    .regM_bubble            	(regM_bubble             ),
    .regM_stall             	(regM_stall              ),
    .regE_i_pc              	(regE_i_pc               ),
    .regE_i_load_store_info 	(regE_i_load_store_info  ),
    .regE_i_opcode_info     	(regE_i_opcode_info      ),
    .regE_i_regdata2        	(regE_i_regdata2         ),
    .execute_i_alu_result   	(execute_i_alu_result    ),
    .regE_i_rd              	(regE_i_rd               ),
    .regE_i_reg_wen         	(regE_i_reg_wen          ),
    .regE_i_commit_info     	(regE_i_commit_info      ),
    .regM_o_load_store_info 	(regM_o_load_store_info  ),
    .regM_o_opcode_info     	(regM_o_opcode_info      ),
    .regM_o_regdata2        	(regM_o_regdata2         ),
    .regM_o_alu_result      	(regM_o_alu_result       ),
    .regM_o_pc              	(regM_o_pc               ),
    .regM_o_rd              	(regM_o_rd               ),
    .regM_o_reg_wen         	(regM_o_reg_wen          ),
    .regE_i_commit_info     	(regE_i_commit_info      )
);
// output declaration of module memory
wire [63:0] memory_o_memdata;

memory u_memory(
    .clk                    	(clk                     ),
    .rst                    	(rst                     ),
    .regM_i_load_store_info 	(regM_i_load_store_info  ),
    .regM_i_alu_result      	(regM_i_alu_result       ),
    .regM_i_regdata2        	(regM_i_regdata2         ),
    .memory_o_memdata       	(memory_o_memdata        )
);

// output declaration of module regW
reg [4:0]   regW_o_rd;
reg         regW_o_reg_wen;
reg [63:0]  regW_o_memdata;
reg [11:0]  regW_o_opcode_info;
reg [63:0]  regW_o_alu_result;
reg [63:0]  regW_o_pc;
reg [160:0] regW_o_commit_info;

regW u_regW(
    .clk                	(clk                 ),
    .rst                	(rst                 ),
    .regW_bubble        	(regW_bubble         ),
    .regW_stall         	(regW_stall          ),
    .regM_i_commit_info 	(regM_i_commit_info  ),
    .regM_i_rd          	(regM_i_rd           ),
    .regM_i_pc          	(regM_i_pc           ),
    .regM_i_reg_wen     	(regM_i_reg_wen      ),
    .memory_i_memdata   	(memory_i_memdata    ),
    .regM_i_opcode_info 	(regM_i_opcode_info  ),
    .regM_i_alu_result  	(regM_i_alu_result   ),
    .regW_o_rd          	(regW_o_rd           ),
    .regW_o_reg_wen     	(regW_o_reg_wen      ),
    .regW_o_memdata     	(regW_o_memdata      ),
    .regW_o_opcode_info 	(regW_o_opcode_info  ),
    .regW_o_alu_result  	(regW_o_alu_result   ),
    .regW_o_pc          	(regW_o_pc           ),
    .regW_o_commit_info 	(regW_o_commit_info  )
);
// output declaration of module write_back
wire [4:0]  write_back_o_rd;
wire [63:0] write_back_o_data;
wire        write_back_o_reg_wen;

write_back u_write_back(
    .regW_i_opcode_info   	(regW_i_opcode_info    ),
    .regW_i_alu_result    	(regW_i_alu_result     ),
    .regW_i_memdata       	(regW_i_memdata        ),
    .regW_i_rd            	(regW_i_rd             ),
    .regW_i_pc              (regW_o_pc),
    .regW_i_reg_wen       	(regW_i_reg_wen        ),
    .write_back_o_rd      	(write_back_o_rd       ),
    .write_back_o_data    	(write_back_o_data     ),
    .write_back_o_reg_wen 	(write_back_o_reg_wen  )
);


// output declaration of module ctrl
wire regD_stall;
wire regE_stall;
wire regM_stall;
wire regW_stall;
wire regD_bubble;
wire regE_bubble;
wire regM_bubble;
wire regW_bubble;

ctrl u_ctrl(
    .execute_i_need_jump 	(execute_o_need_jump  ),
    .regD_stall          	(regD_stall           ),
    .regE_stall          	(regE_stall           ),
    .regM_stall          	(regM_stall           ),
    .regW_stall          	(regW_stall           ),
    .regD_bubble         	(regD_bubble          ),
    .regE_bubble         	(regE_bubble          ),
    .regM_bubble         	(regM_bubble          ),
    .regW_bubble         	(regW_bubble          )
);



endmodule