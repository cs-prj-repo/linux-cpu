module pc(
    input wire clk,
    input wire rst,
    input wire [63:0]  execute_i_jump_pc,
    input wire         execute_i_need_jump,
    input  wire [63:0] fetch_i_pre_pc,
    output reg  [63:0] pc
);
wire inst_jal       = execute_i_jump_info[2];
wire inst_jalr      = execute_i_jump_info[1];
wire inst_branch    = execute_i_jump_info[0];

always @(posedge clk) begin 
    if(rst) begin
        pc <= 64'h80000000;
    end
end
endmodule