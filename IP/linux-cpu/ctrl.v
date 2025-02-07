
module ctrl(
    input  wire          execute_i_is_jump,

    output wire          ctrl_o_regD_stall,
    output wire          ctrl_o_regE_stall,
    output wire          ctrl_o_regM_stall,
    output wire          ctrl_o_regW_stall,

    output wire          ctrl_o_regD_bubble,
    output wire          ctrl_o_regE_bubble,
    output wire          ctrl_o_regM_bubble,
    output wire          ctrl_o_regW_bubble
);

wire branch_bubble = execute_i_is_jump;
assign ctrl_o_regD_bubble   = branch_bubble;
assign ctrl_o_regE_bubble   = branch_bubble;
endmodule