module memory(
    input wire clk,
    input wire rst,
    input wire  [10:0]   regM_i_load_store_info,
    input wire  [63:0]   regM_i_alu_result,
    input wire  [63:0]   regM_i_regdata2,
    output wire [63:0]   memory_o_memdata
);
assign memory_o_memdata = 63'd0;
endmodule