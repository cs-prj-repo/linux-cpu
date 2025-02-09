module fetch(
	input wire clk,
	input wire rst,
	input wire  [63:0]  pc,
	output wire [31:0]  fetch_o_instr,
	output wire [63:0]  fetch_o_pc,
	output wire [63:0]	fetch_o_pre_pc,

	//下面四个全部是用作commit的，
	output wire [160:0] fetch_o_commit_info
);

import "DPI-C" function longint dpi_mem_read(input longint pc_value, input int len);
localparam cache_size       = 8192;                                     //8192字节，是8KB
localparam addr_size        = 64;                                       //地址是64bit
localparam way_size         = 2;                                        //二路组相连
localparam cache_data       = 16;                                       //cache_line每个数据大小是16zi
localparam num_sets         = cache_size / way_size / cache_data;       //一共256组
localparam index_size       = $clog2(num_sets);                         //256组需要8bit进行索引
localparam block_offset     = $clog2(cache_data);                       //16字节需要4bit进行索引
localparam tag_size         = addr_size - index_size - block_offset;    //64bit地址中剩下的数据全部是tag
localparam cache_line_size  = 1 + tag_size + cache_data * 8;            //181

//  reg  [63:0] pc              =   [tag, index, offset];
//  wire [51:0] tag             =   pc[63:12];
//  wire [7 :0] index           =   pc[11: 4];
//  wire [3 :0] offset          =   pc[3 : 0];

//  reg  [180:0] cache_line     =   [valid, tag, cache_data]
//  wire         valid          =   cache_line[180    ];
//  wire [51 :0] tag            =   cache_line[179:128];
//  wire [127:0] cache_data     =   cache_line[127:  0];

reg [cache_line_size - 1: 0] cache [num_sets-1:0][way_size-1:0]; // [Valid bit, Tag, Data]
reg [31:0] instr;

//pc分解
wire [51:0] pc_tag             =   pc[63:12];
wire [7 :0] pc_index           =   pc[11: 4];
wire [3 :0] pc_offset          =   pc[3 : 0];

always @(posedge clk) begin
    if (rst) begin
        for (integer i = 0; i < 256; i = i + 1) begin
            cache[i][0][180] = 1'b0;
            cache[i][1][180] = 1'b0;
        end

    end 
    else begin
        for (integer i = 0; i <   2; i = i + 1) begin
            //组选择与行匹配
            if(cache[pc_index][i][179:128] == pc_tag) begin
                //cache hit
                if(cache[pc_index][i][180]) begin
                    instr <= pc_offset == 4'd0  ? cache[pc_index][i][31: 0] :             
                             pc_offset == 4'd4  ? cache[pc_index][i][63:32] :
                             pc_offset == 4'd8  ? cache[pc_index][i][95:64] :
                             pc_offset == 4'd12 ? cache[pc_index][i][127:96]: 32'd0;
                end
                //cache miss
                else begin
                    cache[pc_index][i][63 :  0]  <= dpi_mem_read(pc    , 8);
                    cache[pc_index][i][127: 64]  <= dpi_mem_read(pc + 8, 8);
                    cache[pc_index][i][179:128]  <= pc[63:12]; 
                    cache[pc_index][i][180]      <= 1'b1;
                    instr <= pc_offset == 4'd0  ? cache[pc_index][i][31: 0] :             
                             pc_offset == 4'd4  ? cache[pc_index][i][63:32] :
                             pc_offset == 4'd8  ? cache[pc_index][i][95:64] :
                             pc_offset == 4'd12 ? cache[pc_index][i][127:96]: 32'd0;
                end
            end    
        end
    end
end



//fetch进行取指，并进行分支预测
assign fetch_o_instr  = instr;
assign fetch_o_pre_pc = pc + 64'd4; //分支预测
assign fetch_o_pc 	  = pc;
wire    commit = 1'b1;											
//			 	 commit_info= [commit, commit_instr,  commit_pre_pc,  commit_pc]
assign  fetch_o_commit_info = {commit, fetch_o_instr, fetch_o_pre_pc, pc};

endmodule