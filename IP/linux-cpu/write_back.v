module write_back(      
       input  wire [11:0]   regW_i_opcode_info,
       input  wire [63:0]   regW_i_alu_result,
       input  wire [63:0]   regW_i_memdata,
       input  wire [4:0]    regW_i_rd,
       input  wire          regW_i_reg_wen,


       output wire [4:0]    write_back_o_rd,
       output wire [63:0]   write_back_o_data,
       output wire          write_back_o_reg_wen
);

assign write_back_o_rd      = regW_i_rd;
assign write_back_o_data    = regW_i_alu_result;
assign write_back_o_reg_wen = regW_i_reg_wen;
endmodule
