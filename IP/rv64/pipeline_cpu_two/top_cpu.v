module top_cpu(
    input wire clk,
    input wire rst
);

wire [63:0] pc_o_bus_info;
pc u_pc(
    .clk(clk),
    .rst(rst),
    .pc_o_bus_info(pc_o_bus_info)
);

wire [95:0]  fetch_o_bus_info;
wire [160:0] fetch_o_commit_info;
fetch u_fetch(
    .pc_i_bus_info(pc_o_bus_info),
    .fetch_o_bus_info(fetch_o_bus_info),
    .fetch_o_commit_info(fetch_o_commit_info)
);

wire [95:0]  regD_o_bus_info;
wire [160:0] regD_o_commit_info;

regD u_regD(
    .clk(clk),               // 时钟信号
    .rst(rst),               // 复位信
    .fetch_i_bus_info(fetch_o_bus_info),
    .fetch_i_commit_info(fetch_o_commit_info),
    
    .regD_o_bus_info(regD_o_bus_info),    
    .regD_o_commit_info(regD_o_commit_info)
);


wire decode_o_bus_info;
decode u_decode(
    .regD_i_bus_info(regD_o_bus_info),
    .decode_o_bus_info(decode_o_bus_info)
);  

endmodule