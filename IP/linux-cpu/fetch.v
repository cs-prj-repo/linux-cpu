module fetch(
	input wire  [63:0]  next_pc_i_pc,
	output wire [31:0]  fetch_o_instr,
	output wire [63:0]	fetch_o_pre_pc,

	//下面四个全部是用作commit的，
	output wire 		fetch_o_commit,
	output wire [63:0]  fetch_o_commit_pc,
	output wire [31:0]  fetch_o_commit_instr,
	output wire [63:0]	fetch_o_commit_pre_pc
);

//fetch进行取指，并进行分支预测
import "DPI-C" function int dpi_mem_read(input longint pc_value, input int len);
assign fetch_o_instr  = dpi_mem_read(next_pc_i_pc, 4);


assign fetch_o_pre_pc = next_pc_i_pc + 64'd4; //分支预测


assign fetch_o_commit = 1;
assign fetch_o_commit_pc 		= next_pc_i_pc;
assign fetch_o_commit_instr		= fetch_o_instr;
assign fetch_o_commit_pre_pc 	= fetch_o_pre_pc;
endmodule