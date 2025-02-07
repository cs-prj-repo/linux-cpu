module regW(
    input wire        clk,                    // 时钟信号
    input wire        rst,                    // 复位信号
    input wire        regW_bubble,
    input wire        regW_stall,
    

    input wire  [4:0]  regM_i_rd,
    input wire         regM_i_reg_wen,
    input wire [63:0]  memory_i_memdata,
    input wire [11:0]  regM_i_opcode_info,
    input wire [63:0]  regM_i_alu_result,

    input wire        regM_i_commit,          // 来自regM的提交标志
    input wire [63:0] regM_i_commit_pre_pc,   // 来自regM的提交前的PC
    input wire [31:0] regM_i_commit_instr,    // 来自regM的提交时的指令
    input wire [63:0] regM_i_commit_pc,       // 来自regM的提交PC


    output reg  [4:0]       regW_o_rd,
    output reg              regW_o_reg_wen,
    output reg   [63:0]     regW_o_memdata,
    output reg   [11:0]     regW_o_opcode_info,
    output reg   [63:0]     regW_o_alu_result,

    output reg        regW_o_commit,          // 输出提交标志
    output reg [63:0] regW_o_commit_pre_pc,   // 输出提交前的PC
    output reg [31:0] regW_o_commit_instr,    // 输出提交时的指令
    output reg [63:0] regW_o_commit_pc        // 输出提交PC
);

    always @(posedge clk) begin
        if(rst || regW_bubble) begin
            regW_o_commit <= 1'd0;               // 清零输出提交标志
            regW_o_commit_pre_pc <= 64'd0;       // 清零输出提交前的PC
            regW_o_commit_instr <= 32'd0;        // 清零输出提交时的指令
            regW_o_commit_pc <= 64'd0;           // 清零输出提交PC

            regW_o_rd <= 5'd0;                   // 清零目标寄存器rd
            regW_o_reg_wen <= 1'b0;              // 清零寄存器写使能信号
            regW_o_memdata <= 64'd0;             // 清零内存数据
            regW_o_opcode_info <= 12'd0;         // 清零opcode信息
            regW_o_alu_result <= 64'd0;          // 清零alu_result
        end else begin
            regW_o_rd <= regM_i_rd;              // 更新目标寄存器rd
            regW_o_reg_wen <= regM_i_reg_wen;    // 更新寄存器写使能信号
            regW_o_memdata <= memory_i_memdata;  // 更新内存数据
            regW_o_opcode_info <= regM_i_opcode_info; // 更新opcode信息
            regW_o_alu_result <= regM_i_alu_result;  // 更新alu_result

            regW_o_commit <= regM_i_commit;              // 更新输出提交标志
            regW_o_commit_pre_pc <= regM_i_commit_pre_pc;// 更新输出提交前的PC
            regW_o_commit_instr <= regM_i_commit_instr;  // 更新输出提交时的指令
            regW_o_commit_pc <= regM_i_commit_pc;        // 更新输出提交PC
        end
    end

endmodule
