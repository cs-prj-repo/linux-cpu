
`include "define.v"

module CSR(
	input wire         clk,
	input wire         rst,
	input wire  [2:0]  CTRL_i_csr_flag,
	input wire  [31:0] PCU_i_pc, 
	input wire  [31:0] IDU_i_valA,
	input wire  [31:0] IDU_i_valC,
	output wire [31:0] CSR_o_valR,  //专用于写回寄存器
	output wire [31:0] CSR_o_CSR_valP
);
//只需要支持ecall指令和mret指令
reg [31:0] mstatus; 
reg [31:0] mtvec;
reg [31:0] mcause;
reg [31:0] mepc;

wire [31:0] csr_idx = IDU_i_valC;

wire rv32_csrrw = (CTRL_i_csr_flag == `csr_csrrw);
wire rv32_csrrs = (CTRL_i_csr_flag == `csr_csrrs);
wire rv32_ecall = (CTRL_i_csr_flag == `csr_ecall);
wire rv32_mret  = (CTRL_i_csr_flag == `csr_mret);

wire rw_mstatus = (csr_idx == 32'h300);
wire rw_mtvec   = (csr_idx == 32'h305);
wire rw_mepc    = (csr_idx == 32'h341);
wire rw_mcause  = (csr_idx == 32'h342);


assign CSR_o_valR = (rw_mstatus &(rv32_csrrs | rv32_csrrw)) 	? mstatus : 
                    (rw_mtvec   &(rv32_csrrs | rv32_csrrw)) 	? mtvec   :
					(rw_mepc    &(rv32_csrrs | rv32_csrrw)) 	? mepc    :
					(rw_mcause  &(rv32_csrrs | rv32_csrrw))  	? mcause  : 32'd0;

assign CSR_o_CSR_valP = (rv32_ecall) ? mtvec  :
					    (rv32_mret)  ? mepc   : 32'd0;

always @(posedge clk) begin
	if(rst) begin
		mtvec   <= 32'd0;
		mstatus <= 32'h1800;
		mepc    <= 32'd0;
		mcause  <= 32'd0; 
	end
	else if(rv32_csrrw) begin
		if     (rw_mstatus)	begin  mstatus <= IDU_i_valA; end
		else if(rw_mtvec)  	begin  mtvec   <= IDU_i_valA; end
		else if(rw_mepc)   	begin  mepc    <= IDU_i_valA; end
		else if(rw_mcause) 	begin  mcause  <= IDU_i_valA; end
	end
	else if(rv32_csrrs) begin
		if     (rw_mstatus)	begin  mstatus <= IDU_i_valA | mstatus; end
		else if(rw_mtvec)  	begin  mtvec   <= IDU_i_valA | mtvec; 	end
		else if(rw_mepc)   	begin  mepc    <= IDU_i_valA | mepc; 	end
		else if(rw_mcause) 	begin  mcause  <= IDU_i_valA | mcause; 	end		
	end
	else if(rv32_ecall) begin
		mepc <= PCU_i_pc + 4;
		mcause <= 32'd1;
	end
	else if(rv32_mret) begin
	end
end

endmodule

