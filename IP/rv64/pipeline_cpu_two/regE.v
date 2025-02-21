module regE(
    input wire clk,
    input wire rst,
    input wire regD_i_bus_info,
    input wire regD_i_commit_info,

    output reg regE_o_bus_info,
    output reg regE_o_commit_info
);
always @(posedge clk) begin
    if(rst) begin
        
    end 
    else begin
        
    end   
end

endmodule