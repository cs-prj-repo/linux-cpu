module regD(
    input wire         clk,               // 时钟信号
    input wire         rst,               // 复位信号
    input wire         fetch_i_commit_info,
    input wire         fetch_i_bus_info,

    output reg         regD_o_bus_info,
    output reg         regD_o_commit_info
);
always @(posedge clk) begin
    if(rst) begin
        
    end
    else begin
            
    end
end

endmodule