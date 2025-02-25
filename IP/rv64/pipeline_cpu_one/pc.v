module pc(
    input wire clk,
    input wire rst,
    input wire  [63:0] execute_i_jump_pc,
    input wire         execute_i_need_jump,
    output reg  [63:0] pc

);
reg pc_ready;
reg pc_valid;
wire regF_ready_go = 1'b1;
//regF_ready_go=1'b1代表y的工作做完了，可以流向下一个流水段。

//x_to_y_valid = 0, y_allow_in = 0, x和y都不动
//x_to_y_valid = 0, y_allow_in = 1, x不动, y流向下一级
//x_to_y_valid = 1, y_allow_in = 0, x和y都不动, x被y阻塞
//x_to_y_valid = 1, y_allow_in = 1, x和y都流向下一级



always @(posedge clk) begin 
    if(rst) begin
        pc         <= 64'h80000000;
        // pc_o_valid <= 1'b0;
    end
    else if(execute_i_need_jump) begin
        pc <= execute_i_jump_pc;        
    end
    else begin
        pc <= pc + 64'd4; //pre_pc
    end
    
end
endmodule
