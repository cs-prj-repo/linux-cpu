module fetch(
    input  wire  [63:0]  pc_i_bus_info,
    output wire  [95:0]  fetch_o_bus_info,
    output wire  [160:0] fetch_o_commit_info
);
import "DPI-C" function     int dpi_instr_mem_read (input longint addr);

wire [63:0] pc              = pc_i_bus_info;
wire [31:0] instr           = dpi_instr_mem_read(pc);
wire [63:0] pre_pc          = pc + 64'd4;

assign fetch_o_bus_info     = {pc, instr};
assign fetch_o_commit_info  = {1'b1, instr, pre_pc, pc}; 
endmodule