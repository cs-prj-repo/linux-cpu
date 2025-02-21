module pc(
    input wire clk,
    input wire rst,
    input wire regF_stall,
    input wire regF_bubble,
    input wire  [63:0] execute_i_jump_pc,
    input wire         execute_i_need_jump,
    output reg  [63:0] pc
    // input   wire        regD_allow_in,
    // output  reg         pc_o_valid
);

// reg  y_valid;
// wire y_ready_go;


//对于master-slave
//每个master-slave内部要维护一个自己的ready_go，说明自己什么时候可以接受数据了


always @(posedge clk) begin 
    if(rst || regF_bubble) begin
        pc         <= 64'h80000000;
        // pc_o_valid <= 1'b0;
    end
    else if(regF_stall) begin
        //在stall的时时候寄存器值不变化
    end
    else if(execute_i_need_jump) begin
        pc <= execute_i_jump_pc;        
    end
    else begin
        pc <= pc + 64'd4; //pre_pc
    end
    
end
endmodule
