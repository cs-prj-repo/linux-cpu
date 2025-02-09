module pc(
    input wire clk,
    input wire rst,
    input wire regF_stall,
    input wire regF_bubble,
    input wire  [63:0] execute_i_jump_pc,
    input wire         execute_i_need_jump,
    input  wire [63:0] fetch_i_pre_pc,
    output reg  [63:0] pc
);

initial begin
    
end
always @(posedge clk) begin 
    if(rst || regF_bubble) begin
        pc <= 64'h80000000;
    end
    else if(regF_stall) begin
        //在stall的时时候寄存器值不变化
    end
    else if(execute_i_need_jump) begin
        pc <= execute_i_jump_pc;        
    end
    else begin
        pc <= fetch_i_pre_pc;
    end
    
end
endmodule