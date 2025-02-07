module pc(
    input wire clk,
    input wire rst,
    input  wire [63:0] execute_i_pre_pc,
    input  wire        execute_i_is_jump,
    input  wire [63:0] fetch_i_pre_pc,
    output reg  [63:0] pc
);
always @(posedge clk) begin 
    if(rst) begin
        pc <= 64'h80000000;
    end
    else if(execute_i_is_jump) begin
        pc <= execute_i_pre_pc;
    end
    else begin
        pc <= fetch_i_pre_pc;
    end
end
endmodule