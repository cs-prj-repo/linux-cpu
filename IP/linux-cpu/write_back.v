
module write_back(      
       input [9:0]   opcode_info_i,
       input [31:0]  regW_i_alu_result,
       input [31:0]  regW_i_mem_rdata,
       output[4 :0]  wb_rd_id_o,
       output[31:0]  wb_rd_write_data_o  
);


wire    op_load = opcode_info_i[4];

assign  wb_rd_write_data_o = op_load ? mem_read_data_i : alu_result_i;

assign  wb_rd_write_en_o   = rd_write_en_i;
assign  wb_rd_id_o         = rd_id_i;
endmodule
