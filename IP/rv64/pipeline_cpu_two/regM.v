module regM(
    input wire clk,
    input wire rst,
    input wire  regE_i_bus_info,
    input wire  regE_i_commit_info,

    output reg  regM_o_bus_info,
    output reg  regM_o_commit_info
);
always @(posedge clk) begin
    if(rst) begin
        
    end
    else begin
        
    end
end
endmodule