module regW(
    input wire        clk,                    // 时钟信号
    input wire        rst,                    // 复位信号

    input wire  [160:0]     regM_i_commit_info,
    input wire  [4:0]       regM_i_rd,
    input wire   [63:0]     regM_i_pc,
    input wire              regM_i_reg_wen,
    input wire [63:0]       memory_i_memdata,
    input wire [11:0]       regM_i_opcode_info,
    input wire [63:0]       regM_i_alu_result,

    output reg  [4:0]       regW_o_rd,
    output reg              regW_o_reg_wen,
    output reg  [63:0]      regW_o_memdata,
    output reg  [11:0]      regW_o_opcode_info,
    output reg  [63:0]      regW_o_alu_result,
    output reg  [63:0]      regW_o_pc,
    output reg  [160:0]     regW_o_commit_info
);
reg regW_ready;
reg regW_valid;

wire regW_ready_go = 1'b1;


    always @(posedge clk) begin
        if(rst ) begin
            regW_o_rd           <= 5'd0;          // 清零目标寄存器rd
            regW_o_reg_wen      <= 1'b0;          // 清零寄存器写使能信号
            regW_o_memdata      <= 64'd0;         // 清零内存数据
            regW_o_opcode_info  <= 12'd0;         // 清零opcode信息
            regW_o_alu_result   <= 64'd0;         // 清零alu_result
            regW_o_commit_info  <= 161'd0;        // 清零commit_info
            regW_o_pc           <= 64'd0;         // 清零pc
        end 
        else begin
            regW_o_rd           <= regM_i_rd;           // 更新目标寄存器rd
            regW_o_reg_wen      <= regM_i_reg_wen;      // 更新寄存器写使能信号
            regW_o_memdata      <= memory_i_memdata;    // 更新内存数据
            regW_o_opcode_info  <= regM_i_opcode_info;  // 更新opcode信息
            regW_o_alu_result   <= regM_i_alu_result;   // 更新alu_result
            regW_o_commit_info  <= regM_i_commit_info;  // 更新commit_info
            regW_o_pc           <= regM_i_pc;           // 更新pc
        end
    end

endmodule