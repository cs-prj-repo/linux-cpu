module regE(
    input wire        clk,                    // 时钟信号
    input wire        rst,                    // 复位信号
    
    input wire        regD_i_commit,          // 来自regD的提交标志
    input wire [63:0] regD_i_commit_pre_pc,   // 来自regD的提交前的PC
    input wire [31:0] regD_i_commit_instr,    // 来自regD的提交时的指令
    input wire [63:0] regD_i_commit_pc,       // 来自regD的提交PC

    output reg        regE_o_commit,          // 输出提交标志
    output reg [63:0] regE_o_commit_pre_pc,   // 输出提交前的PC
    output reg [31:0] regE_o_commit_instr,    // 输出提交时的指令
    output reg [63:0] regE_o_commit_pc        // 输出提交PC
);

    always @(posedge clk) begin
        if(rst) begin
            regE_o_commit <= 1'd0;               // 清零输出提交标志
            regE_o_commit_pre_pc <= 64'd0;       // 清零输出提交前的PC
            regE_o_commit_instr <= 32'd0;        // 清零输出提交时的指令
            regE_o_commit_pc <= 64'd0;           // 清零输出提交PC
        end else begin
            regE_o_commit <= regD_i_commit;              // 更新输出提交标志
            regE_o_commit_pre_pc <= regD_i_commit_pre_pc;// 更新输出提交前的PC
            regE_o_commit_instr <= regD_i_commit_instr;  // 更新输出提交时的指令
            regE_o_commit_pc <= regD_i_commit_pc;        // 更新输出提交PC
        end
    end

endmodule