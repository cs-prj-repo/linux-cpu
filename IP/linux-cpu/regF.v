module regF(
    input wire clk,
    input wire rst,
    input wire [63:0] fetch_i_pre_pc,  // 输入PC地址
    output reg [63:0] regF_o_pre_pc    // 输出保存的PC地址
);
always @(posedge clk) begin
    if(rst) begin
        regF_o_pre_pc <= 64'h80000000;  // 在复位时将输出设置为0
    end else begin
        regF_o_pre_pc <= fetch_i_pre_pc;  // 正常工作时更新输出
    end
end
endmodule