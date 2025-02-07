module memory(
    input wire clk,
    input wire rst,
    input wire  [10:0]    regM_i_load_store_info,
    input wire  [63:0]   regM_i_alu_result,
    input wire  [63:0]   regM_i_regdata2,
    output wire [63:0]   memory_o_memdata
);

assign memory_o_memdata = 64'd0;
// 对于riscv指令来说
// 有无条件跳转指令
// 有分支跳转指令               
// 有逻辑运算指令（寄存器与寄存器）————————ALU的结果写回到寄存器里面
// 有逻辑运算指令（寄存器与立即数）————————ALU的结果写回到寄存器里面

// 加载指令（从内存中读数据）—————————————ALU的结果作为读地址
// 访存指令（往内存中写数据）—————————————ALU的结果作为写地址, regdata2作为
endmodule