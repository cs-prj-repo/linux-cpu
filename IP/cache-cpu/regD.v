module regD(
    input  wire clk,
    input  wire rst,
    input  wire [31:0] fetch_i_instr,
    output reg  [31:0] regD_o_instr
);
always @(posedge clk) begin
    if(rst) begin
        regD_o_instr <= 32'd0;
    end 
    else begin
        regD_o_instr <= fetch_i_instr;
    end
end

endmodule