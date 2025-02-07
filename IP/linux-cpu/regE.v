module regE(
    input wire         clk,                    // 时钟信号
    input wire         rst,                    // 复位信号
    input wire        regE_bubble,
    input wire        regE_stall,

    

    // 来自 regD 的提交信号
    input wire         regD_i_commit,          // 提交标志
    input wire [63:0]  regD_i_commit_pre_pc,   // 提交前的PC
    input wire [31:0]  regD_i_commit_instr,    // 提交时的指令
    input wire [63:0]  regD_i_commit_pc,       // 提交PC

    // 来自 Decode 阶段的数据
    input wire  [63:0] regD_i_pc,              // 当前指令的PC
    input wire  [63:0] decode_i_imm,           // 立即数
    input wire  [63:0] decode_i_regdata1,      // 寄存器数据1
    input wire  [63:0] decode_i_regdata2,      // 寄存器数据2

    input wire  [4:0]  decode_i_rd,            // 目标寄存器地址
    input wire         decode_i_reg_wen,       // 寄存器写使能

    // 控制信号
    input wire   [27:0] decode_i_alu_info,          // ALU操作信息
    input wire   [10:0] decode_i_load_store_info,   // 访存操作信息
    input wire   [11:0] decode_i_opcode_info,       // 操作码信息
    input wire   [5:0]  decode_i_branch_info,       // 分支信息


    // 输出到下一级的信号
    output reg         regE_o_commit,          // 提交标志
    output reg [63:0]  regE_o_commit_pre_pc,   // 提交前的PC
    output reg [31:0]  regE_o_commit_instr,    // 提交时的指令
    output reg [63:0]  regE_o_commit_pc,       // 提交PC
    
    output reg [63:0]  regE_o_regdata1,        // 寄存器数据1
    output reg [63:0]  regE_o_regdata2,        // 寄存器数据2
    output reg [63:0]  regE_o_imm,             // 立即数
    output reg [63:0]  regE_o_pc,              // 当前指令的PC

    output reg [4:0]   regE_o_rd,              // 目标寄存器地址
    output reg         regE_o_reg_wen,         // 寄存器写使能

    output reg  [27:0] regE_o_alu_info,        // ALU操作信息
    output reg  [10:0] regE_o_load_store_info, // 访存操作信息
    output reg  [11:0] regE_o_opcode_info,     // 操作码信息
    output reg  [5:0]  regE_o_branch_info      // 分支信息
);

// 时序逻辑：控制寄存器的更新，使用时钟信号 clk
always @(posedge clk or posedge rst) begin
    if (rst || regE_bubble) begin
        // 复位所有输出信号
        regE_o_commit           <= 1'd0;       // 提交标志
        regE_o_commit_pre_pc    <= 64'd0;      // 提交前的PC
        regE_o_commit_instr     <= 32'd0;      // 提交时的指令
        regE_o_commit_pc        <= 64'd0;      // 提交PC
        
        regE_o_regdata1         <= 64'd0;      // 寄存器数据1
        regE_o_regdata2         <= 64'd0;      // 寄存器数据2
        regE_o_rd               <= 5'd0;       // 目标寄存器
        regE_o_reg_wen          <= 1'd0;       // 写使能
        
        regE_o_alu_info         <= 28'd0;       // ALU操作
        regE_o_load_store_info  <= 11'd0;       // 访存操作
        regE_o_opcode_info      <= 12'd0;       // 操作码
        regE_o_branch_info      <= 6'd0;        // 分支信息
        regE_o_pc               <= 64'd0;      // 当前PC
    end 
    else begin
        regE_o_pc               <= regD_i_pc;          // 更新当前PC
        
        // 更新所有输出信号
        regE_o_commit           <= regD_i_commit;            // 提交标志
        regE_o_commit_pre_pc    <= regD_i_commit_pre_pc;     // 提交前的PC
        regE_o_commit_instr     <= regD_i_commit_instr;      // 提交时的指令
        regE_o_commit_pc        <= regD_i_commit_pc;         // 提交PC
        
        regE_o_regdata1         <= decode_i_regdata1;        // 寄存器数据1
        regE_o_regdata2         <= decode_i_regdata2;        // 寄存器数据2
        regE_o_imm              <= decode_i_imm;             // 更新立即数
        regE_o_rd               <= decode_i_rd;              // 目标寄存器
        regE_o_reg_wen          <= decode_i_reg_wen;         // 写使能
        
        regE_o_alu_info         <= decode_i_alu_info;        // ALU操作
        regE_o_load_store_info  <= decode_i_load_store_info; // 访存操作
        regE_o_opcode_info      <= decode_i_opcode_info;     // 操作码
        regE_o_branch_info      <= decode_i_branch_info;     // 分支信息
    end
end
endmodule
