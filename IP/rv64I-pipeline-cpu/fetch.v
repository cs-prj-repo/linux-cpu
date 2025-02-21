module fetch(
    input wire clk,
    input wire rst,
    input wire fetch_stall,
    input wire fetch_bubble,
    input  wire  [63:0]  pc,
    output wire  [63:0]  fetch_o_pc,
    output wire  [31:0]  fetch_o_instr,
    output wire  [63:0]  fetch_o_pre_pc,
    output wire  [160:0] fetch_o_commit_info
);

import "DPI-C" function     int dpi_instr_mem_read (input longint addr);

assign fetch_o_pc           = pc;
assign fetch_o_instr        =  dpi_instr_mem_read(pc);
assign fetch_o_pre_pc       =  fetch_o_pc + 64'd4;
assign fetch_o_commit_info  = {1'b1, fetch_o_instr, fetch_o_pre_pc, fetch_o_pc};
endmodule