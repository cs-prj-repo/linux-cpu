module write_back(      
       input  wire [11:0]   regW_i_opcode_info,
       input  wire [63:0]   regW_i_alu_result,
       input  wire [63:0]   regW_i_memdata,

       output wire [4:0]    write_back_o_rd,
       output wire [63:0]   write_back_o_data,
       output wire          write_back_o_reg_wen
);

assign write_back_o_rd      = 5'd0;
assign write_back_o_data    = 64'd0;
assign write_back_o_reg_wen = 1'd0;

endmodule
