module regD(
    input wire        clk,               // 时钟信号
    input wire        rst,               // 复位信号
    input wire        regD_bubble,
    input wire        regD_stall,

    input wire [63:0]  fetch_i_pc,    
    input wire [31:0]  fetch_i_instr,     // 输入指令
    input wire [160:0] fetch_i_commit_info,

    output reg [63:0]  regD_o_pc,
    output reg [31:0]  regD_o_instr,      // 输出指令
    output reg [160:0] regD_o_commit_info
);

    always @(posedge clk) begin
        if(rst || regD_bubble) begin
            regD_o_pc               <= 64'd0;
            regD_o_instr            <= 32'd0;    // 清零输出指令
            regD_o_commit           <= 1'd0;     // 清零输出提交标志
            regD_o_commit_pc        <= 64'd0;    // 清零输出提交PC
            regD_o_commit_instr     <= 32'd0;    // 清零输出提交时的指令
            regD_o_commit_pre_pc    <= 64'd0;   // 清零输出提交前的PC
        end 
        else begin
            regD_o_pc       <= fetch_i_pc;
            regD_o_instr    <= fetch_i_instr;          // 更新输出指令
            regD_o_commit   <= fetch_i_commit;        // 更新输出提交标志
            regD_o_commit_pc <= fetch_i_commit_pc;  // 更新输出提交PC
            regD_o_commit_instr <= fetch_i_commit_instr; // 更新输出提交时的指令
            regD_o_commit_pre_pc <= fetch_i_commit_pre_pc; // 更新输出提交前的PC
        end
    end

endmodule