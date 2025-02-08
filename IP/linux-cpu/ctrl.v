
module ctrl(
    input  wire          execute_i_need_jump,

    output wire          regD_stall,
    output wire          regE_stall,
    output wire          regM_stall,
    output wire          regW_stall,

    output wire          regD_bubble,
    output wire          regE_bubble,
    output wire          regM_bubble,
    output wire          regW_bubble
);

wire branch_bubble = execute_i_need_jump;
assign regD_bubble   = branch_bubble;
assign regE_bubble   = branch_bubble;
endmodule