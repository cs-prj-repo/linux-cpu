`include "define.v"
module IDU
#(WIDTH = 32, REG_WIDTH=5)
(
	input wire        [31:0]  pc_for_debug,
	input wire  			  clk,
	input wire 				  rst,
	input wire  [WIDTH - 1:0] IFU_i_instr,
	input wire  			  CTRL_i_reg_wen,
	input wire 			[2:0] CTRL_i_valC_sel,
	input wire  [WIDTH - 1:0] WBU_i_valW, 
	output wire [WIDTH - 1:0] IDU_o_valA,
	output wire [WIDTH - 1:0] IDU_o_valB,
	output wire [31:0] 		  IDU_o_valC
);
wire [WIDTH - 1:0] 		instr   = IFU_i_instr;
wire [REG_WIDTH - 1:0]  rs1  = instr[19:15];
wire [REG_WIDTH - 1:0]  rs2  = instr[24:20];
wire [REG_WIDTH - 1:0]  rd   = instr[11:7];


REGU u_REGU(
	.pc_for_debug  (pc_for_debug),
	.inst_for_debug(IFU_i_instr),
	.clk           (clk           	),
	.rst           (rst           	),
	.IDU_i_rs1     (rs1     		),
	.IDU_i_rs2     (rs2     		),
	.IDU_i_reg_wen (CTRL_i_reg_wen	),
	.IDU_i_rd      (rd      		),
	.IDU_i_valW    (WBU_i_valW    	),
	.REGU_o_valA   (IDU_o_valA   	),
	.REGU_o_valB   (IDU_o_valB   	)
);


assign IDU_o_valC = (CTRL_i_valC_sel == `valC_U_TYPE)  ?  { instr[31:12] , 12'd0} 	: 
					(CTRL_i_valC_sel == `valC_I_TYPE)  ?  { {20{instr[31]}}, instr[31:20]} 	: 
					(CTRL_i_valC_sel == `valC_I_SHAMT) ?  {  27'd0,instr[24:20]}			:
					(CTRL_i_valC_sel == `valC_S_TYPE)  ?  { {20{instr[31]}}, instr[31:25], instr[11:7]} :
					(CTRL_i_valC_sel == `valC_R_TYPE)  ?  {32'd0 } :
					(CTRL_i_valC_sel == `valC_B_TYPE)  ?  {{{ {20{instr[31]}},  instr[31], instr[7], instr[30:25],  instr[11:8] }  << 1'b1} } :
					(CTRL_i_valC_sel == `valC_J_TYPE)  ? {{ {12{instr[31]}},  instr[31], instr[19:12], instr[20], instr[30:21]}  << 1'b1} : 
					(CTRL_i_valC_sel == `valC_ZERO)    ? 32'd0 : 32'd0;

endmodule //ysyx_23060334_IDU





