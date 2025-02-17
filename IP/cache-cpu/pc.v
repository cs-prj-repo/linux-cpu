module pc(
    input wire        clk,
    input wire        rst,
    input wire        fetch_i_ready, 
    output reg [63:0] pc,
    output reg        pc_valid
);
reg need_initial_valid;
always @(posedge clk) begin
    if (rst) begin
        pc                 <= 64'd0;
        pc_valid           <= 1'b0;    // 复位时标记无效
        need_initial_valid <= 1'b1;  // 标记需要首次激活valid
    end else begin
        // 优先级1：握手成功时更新PC
        if (pc_valid && fetch_i_ready) begin
            pc <= pc + 64'd4;        // 递增PC
            // valid保持为1（新PC立即可用）
        end
        // 优先级2：初始化后首次激活valid
        else if (need_initial_valid) begin
			pc 				 <= 64'h80000000;
            pc_valid         <= 1'b1; // 声明初始PC=0有效
            need_initial_valid <= 1'b0;
        end
    end
end

endmodule