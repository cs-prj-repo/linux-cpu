module pc(
    input wire clk,
    input wire rst,

    input  wire        regD_i_
    
    output wire [63:0] pc_o_bus
);



reg [63:0] pc;
always @(posedge clk) begin 
    if(rst) begin
        pc         <= 64'h80000000;       
    end
    else begin
        pc <= pc + 64'd4; //pre_pc
    end
    
end
endmodule