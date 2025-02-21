module icache(
    input wire 		     clk,
	input wire 		     rst,
    input wire           bubble,
    input wire           stall,
	input wire [63:0]    pc,
    output reg [31:0]    icache_o_instr
);

//


wire [127:0] memory_data = {dpi_instr_mem_read(pc+12), dpi_instr_mem_read(pc+8), 
                            dpi_instr_mem_read(pc+4),  dpi_instr_mem_read(pc)};
endmodule