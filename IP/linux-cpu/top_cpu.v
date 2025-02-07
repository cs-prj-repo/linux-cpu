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
    .clk               	(clk                ),
    .rst               	(rst                ),
    .execute_i_pre_pc  	(execute_i_pre_pc   ),
    .execute_i_is_jump 	(execute_i_is_jump  ),
    .fetch_i_pre_pc    	(fetch_i_pre_pc     ),
    .pc                	(pc                 )
);



endmodule