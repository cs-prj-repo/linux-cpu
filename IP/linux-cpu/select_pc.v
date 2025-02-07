module select_pc(
    input wire clk,
    input wire rst,
    input  wire [63:0] regF_i_pre_pc,
    output wire [63:0] select_pc_o_pc
);
assign select_pc_o_pc = regF_i_pre_pc;
endmodule