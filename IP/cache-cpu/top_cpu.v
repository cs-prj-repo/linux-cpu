module top_cpu(
    input wire clk,
    input wire rst
);

// output declaration of module pc
wire [63:0] pc;
wire        pc_valid;
// output declaration of module fetch
wire        fetch_o_ready;
wire        fetch_o_valid;
wire [31:0] fetch_o_instr;
wire [31:0] fetch_o_tmp_instr;

// output declaration of module regD
wire [31:0] regD_o_instr;

pc u_pc(
    .clk           	(clk            ),
    .rst           	(rst            ),
    .fetch_i_ready 	(fetch_o_ready  ),
    .pc            	(pc             ),
    .pc_valid      	(pc_valid       )
);

fetch u_fetch(
    .clk           	(clk            ),
    .rst           	(rst            ),
    .pc            	(pc             ),
    .pc_valid      	(pc_valid       ),
    .fetch_o_ready 	(fetch_o_ready  ),
    .fetch_o_valid 	(fetch_o_valid  ),
    .fetch_o_instr 	(fetch_o_instr  ),
    .fetch_o_tmp_instr(fetch_o_tmp_instr)
);

regD u_regD(
    .clk           	(clk            ),
    .rst           	(rst            ),
    .fetch_i_instr 	(fetch_o_instr  ),
    .regD_o_instr  	(regD_o_instr   )
);


// output declaration of module decode
wire [9:0] decode_o_alu_info;
wire [1:0] decode_o_opcode_info;
wire [63:0] decode_o_regdata1;
wire [63:0] decode_o_regdata2;
wire [63:0] decode_o_imm;
wire [4:0] decode_o_rs1;
wire [4:0] decode_o_rs2;
wire [4:0] decode_o_rd;
wire decode_o_reg_wen;
wire [63:0]write_back_o_data;
wire [4:0] write_back_o_rd;
wire       write_back_o_reg_wen;

decode u_decode(
    .clk                  	(clk                   ),
    .rst                  	(rst                   ),
    .regD_i_instr         	(regD_o_instr          ),
    .write_back_i_data    	(write_back_o_data     ),
    .write_back_i_rd      	(write_back_o_rd       ),
    .write_back_i_reg_wen 	(write_back_o_reg_wen  ),

    .decode_o_alu_info    	(decode_o_alu_info     ),
    .decode_o_opcode_info 	(decode_o_opcode_info  ),
    .decode_o_regdata1    	(decode_o_regdata1     ),
    .decode_o_regdata2    	(decode_o_regdata2     ),
    .decode_o_imm         	(decode_o_imm          ),

    .decode_o_rd          	(decode_o_rd           ),
    .decode_o_reg_wen     	(decode_o_reg_wen      )
);



endmodule