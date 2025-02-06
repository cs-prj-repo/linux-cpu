module top_cpu(
    input  wire clk,
    input  wire rst,

    output wire                 commit,
    output wire [31:0]          commit_instr,
    output wire [63:0]          commit_pc,
    output wire [63:0]          commit_pre_pc,
    output wire [63:0]          cur_pc
);

assign cur_pc = next_pc_o_pc;

// output declaration of module regF
wire [63:0] regF_o_pre_pc;

regF u_regF(
    .clk            	(clk             ),
    .rst            	(rst             ),
    .fetch_i_pre_pc 	(fetch_o_pre_pc  ),
    .regF_o_pre_pc  	(regF_o_pre_pc   )
);

// output declaration of module next_pc
// output declaration of module next_pc
wire [63:0] next_pc_o_pc;

next_pc u_next_pc(
    .regF_i_pre_pc 	(regF_o_pre_pc  ),
    .next_pc_o_pc  	(next_pc_o_pc   )
);

// output declaration of module fetch
wire [31:0] fetch_o_instr;
wire [63:0] fetch_o_pre_pc;
wire        fetch_o_commit;
wire [63:0] fetch_o_commit_pc;
wire [31:0] fetch_o_commit_instr;
wire [63:0] fetch_o_commit_pre_pc;

fetch u_fetch(
    .next_pc_i_pc          	(next_pc_o_pc           ),
    .fetch_o_instr         	(fetch_o_instr          ),
    .fetch_o_pre_pc        	(fetch_o_pre_pc         ),
    .fetch_o_commit        	(fetch_o_commit         ),
    .fetch_o_commit_pc     	(fetch_o_commit_pc      ),
    .fetch_o_commit_instr  	(fetch_o_commit_instr   ),
    .fetch_o_commit_pre_pc 	(fetch_o_commit_pre_pc  )
);
// output declaration of module regD
wire [31:0] regD_o_instr;
wire        regD_o_commit;
wire [63:0] regD_o_commit_pc;
wire [31:0] regD_o_commit_instr;
wire [63:0] regD_o_commit_pre_pc;

regD u_regD(
    .clk                   	(clk                    ),
    .rst                   	(rst                    ),
    .fetch_i_instr         	(fetch_o_instr          ),
    .fetch_i_commit        	(fetch_o_commit         ),
    .fetch_i_commit_pc     	(fetch_o_commit_pc      ),
    .fetch_i_commit_instr  	(fetch_o_commit_instr   ),
    .fetch_i_commit_pre_pc 	(fetch_o_commit_pre_pc  ),
    .regD_o_instr          	(regD_o_instr           ),
    .regD_o_commit         	(regD_o_commit          ),
    .regD_o_commit_pc      	(regD_o_commit_pc       ),
    .regD_o_commit_instr   	(regD_o_commit_instr    ),
    .regD_o_commit_pre_pc  	(regD_o_commit_pre_pc   )
);




// output declaration of module decode
wire [27:0] decode_o_alu_info;
wire [11:0] decode_o_opcode_info;
wire [5:0]  decode_o_branch_info;
wire [10:0] decode_o_load_store_info;
wire [63:0] decode_o_reg_rdata1;
wire [63:0] decode_o_reg_rdata2;
wire [63:0] decode_o_imm;

wire [63:0] write_back_o_reg_wdata;
wire [4:0]  write_back_o_rd;
wire        write_back_o_reg_wen;

decode u_decode(
    .clk                      	(clk                       ),
    .rst                      	(rst                       ),
    .regD_i_instr             	(regD_o_instr              ),
    .write_back_i_reg_wdata   	(write_back_o_reg_wdata    ),
    .write_back_i_rd          	(write_back_o_rd           ),
    .write_back_i_reg_wen     	(write_back_o_reg_wen      ),
    .decode_o_alu_info        	(decode_o_alu_info         ),
    .decode_o_opcode_info     	(decode_o_opcode_info      ),
    .decode_o_branch_info     	(decode_o_branch_info      ),
    .decode_o_load_store_info 	(decode_o_load_store_info  ),
    .decode_o_reg_rdata1      	(decode_o_reg_rdata1       ),
    .decode_o_reg_rdata2      	(decode_o_reg_rdata2       ),
    .decode_o_imm             	(decode_o_imm              )
);

// output declaration of module regE
wire regE_o_commit;
wire [63:0] regE_o_commit_pre_pc;
wire [31:0] regE_o_commit_instr;
wire [63:0] regE_o_commit_pc;

regE u_regE(
    .clk                  	(clk                   ),
    .rst                  	(rst                   ),
    .regD_i_commit        	(regD_o_commit         ),
    .regD_i_commit_pre_pc 	(regD_o_commit_pre_pc  ),
    .regD_i_commit_instr  	(regD_o_commit_instr   ),
    .regD_i_commit_pc     	(regD_o_commit_pc      ),
    .regE_o_commit        	(regE_o_commit         ),
    .regE_o_commit_pre_pc 	(regE_o_commit_pre_pc  ),
    .regE_o_commit_instr  	(regE_o_commit_instr   ),
    .regE_o_commit_pc     	(regE_o_commit_pc      )
);

// output declaration of module regM
wire        regM_o_commit;
wire [63:0] regM_o_commit_pre_pc;
wire [31:0] regM_o_commit_instr;
wire [63:0] regM_o_commit_pc;

regM u_regM(
    .clk                  	(clk                   ),
    .rst                  	(rst                   ),
    .regE_i_commit        	(regE_o_commit         ),
    .regE_i_commit_pre_pc 	(regE_o_commit_pre_pc  ),
    .regE_i_commit_instr  	(regE_o_commit_instr   ),
    .regE_i_commit_pc     	(regE_o_commit_pc      ),
    .regM_o_commit        	(regM_o_commit         ),
    .regM_o_commit_pre_pc 	(regM_o_commit_pre_pc  ),
    .regM_o_commit_instr  	(regM_o_commit_instr   ),
    .regM_o_commit_pc     	(regM_o_commit_pc      )
);

// output declaration of module regW
wire regW_o_commit;
wire [63:0] regW_o_commit_pre_pc;
wire [31:0] regW_o_commit_instr;
wire [63:0] regW_o_commit_pc;

regW u_regW(
    .clk                  	(clk                   ),
    .rst                  	(rst                   ),
    .regM_i_commit        	(regM_o_commit         ),
    .regM_i_commit_pre_pc 	(regM_o_commit_pre_pc  ),
    .regM_i_commit_instr  	(regM_o_commit_instr   ),
    .regM_i_commit_pc     	(regM_o_commit_pc      ),
    .regW_o_commit        	(regW_o_commit         ),
    .regW_o_commit_pre_pc 	(regW_o_commit_pre_pc  ),
    .regW_o_commit_instr  	(regW_o_commit_instr   ),
    .regW_o_commit_pc     	(regW_o_commit_pc      )
);



assign commit       = regW_o_commit;
assign commit_instr = regW_o_commit_instr;
assign commit_pc    = regW_o_commit_pc;
assign commit_pre_pc = regW_o_commit_pre_pc;
endmodule