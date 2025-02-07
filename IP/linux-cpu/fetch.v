module fetch(
	input wire  [63:0]  pc,
	output wire [31:0]  fetch_o_instr,

	output wire [63:0]  fetch_o_pc,
	output wire [63:0]	fetch_o_pre_pc,

	//下面四个全部是用作commit的，
	output wire [160:0] fetch_o_commit_info
);

//fetch进行取指，并进行分支预测
import "DPI-C" function int dpi_mem_read(input longint pc_value, input int len);
assign fetch_o_instr  = dpi_mem_read(pc, 4);
assign fetch_o_pre_pc = pc + 64'd4; //分支预测
assign fetch_o_pc 	  = pc;


wire commit = 1'b1;											
//			 	 commit_info= [commit, commit_instr,  commit_pre_pc,  commit_pc]
assign  fetch_o_commit_info = {commit, fetch_o_instr, fetch_o_pre_pc, pc};

endmodule