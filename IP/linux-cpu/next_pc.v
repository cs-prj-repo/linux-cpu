module next_pc(
    input  wire [63:0] regF_i_pre_pc,
    output wire [63:0] next_pc_o_pc
);

assign next_pc_o_pc = regF_i_pre_pc;
endmodule