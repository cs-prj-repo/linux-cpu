module regM(
    input wire        clk,                    // 时钟信号
    input wire        rst,                    // 复位信号
    input wire        regM_bubble,
    input wire        regM_stall,
    

    input wire  [63:0] regE_i_pc,

    input wire  [10:0] regE_i_load_store_info,
    input wire  [11:0] regE_i_opcode_info,
    input wire  [63:0] regE_i_regdata2,
    input wire  [63:0] execute_i_alu_result,

    input wire  [4:0]  regE_i_rd,
    input wire         regE_i_reg_wen,
    input wire  [160:0] regE_i_commit_info,


    output reg   [10:0] regM_o_load_store_info,
    output reg   [11:0] regM_o_opcode_info,

    output reg   [63:0] regM_o_regdata2,
    output reg   [63:0] regM_o_alu_result,

    output reg  [63:0]  regM_o_pc,
    output reg  [4:0]   regM_o_rd,
    output reg          regM_o_reg_wen,
    output wire  [160:0] regE_i_commit_info
);

    always @(posedge clk) begin
        if(rst || regM_bubble) begin
            regM_o_load_store_info <= 11'd0;                    // 清零输出load/store信息
            regM_o_opcode_info <= 12'd0;                        // 清零输出opcode信息
            regM_o_regdata2 <= 64'd0;                           // 清零输出regdata2
            regM_o_alu_result <= 64'd0;                         // 清零输出alu_result
            regM_o_rd <= 5'd0;                                  // 清零输出目标寄存器rd
            regM_o_reg_wen <= 1'b0;                             // 清零输出reg_wen
        end 
        else begin
            regM_o_rd <= regE_i_rd;                             // 更新目标寄存器rd
            regM_o_reg_wen <= regE_i_reg_wen;                   // 更新寄存器写使能信号
            regM_o_alu_result <= execute_i_alu_result;          // 更新alu_result
            regM_o_load_store_info <= regE_i_load_store_info; // 更新load/store信息
            regM_o_opcode_info <= regE_i_opcode_info;         // 更新opcode信息
            regM_o_regdata2 <= regE_i_regdata2;               // 更新regdata2
        end
    end

endmodule
