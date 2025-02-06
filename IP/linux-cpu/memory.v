module memory(
    input wire  [7:0]    load_store_i_info,
    input wire  [31:0]   regM_i_mem_addr,
    input wire  [31:0]   regM_i_mem_wdata,
    output wire [31:0]   memory_o_mem_rdata
);
// 

// 对于riscv指令来说
// 有无条件跳转指令
// 有分支跳转指令               
// 有逻辑运算指令（寄存器与寄存器）————————ALU的结果写回到寄存器里面
// 有逻辑运算指令（寄存器与立即数）————————ALU的结果写回到寄存器里面

// 加载指令（从内存中读数据）—————————————ALU的结果作为读地址
// 访存指令（往内存中写数据）—————————————ALU的结果作为写地址



endmodule