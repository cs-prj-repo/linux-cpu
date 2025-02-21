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
wire [95 :0] fetch_o_bus_info;
wire [160:0] fetch_o_commit_info;

fetch u_fetch(
    .pc_i_bus_info      (pc_o_bus_info),
    .fetch_o_bus_info   (fetch_o_bus_info),
    .fetch_o_commit_info(fetch_o_commit_info)
);

regD

endmodule