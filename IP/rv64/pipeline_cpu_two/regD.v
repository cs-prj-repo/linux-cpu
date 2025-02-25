module regD(
    input  wire          clk,               // 时钟信号
    input  wire          rst,               // 复位信
    input  wire [95:0]   fetch_i_bus_info,
    input  wire [160:0]  fetch_i_commit_info,
    
    output wire [95:0]   regD_o_bus_info,    
    output wire [160:0]  regD_o_commit_info
);
always @(posedge clk) begin
    if(rst) begin

    end
    else begin
        regD_o_bus_info     <= fetch_i_bus_info;
        regD_o_commit_info  <=  fetch_i_commit_info;            
    end
end

//sw rs2,offset(rs1),  M[x[rs1] + sext(offset)] = x[rs2][31:0]
//sw  a1  0x0(ra)       M[R(ra)+0] = R[a1]
//lw a4,  0x0(ra)       R[a4] = M[R(ra]  + 0]


endmodule