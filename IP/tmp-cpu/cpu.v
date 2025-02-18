module stallble_pipeline(
    parameter WIDTH = 100
)

(
    input clk,
    input rst,
    input validin,
    input [WIDTH - 1: 0] datain,
    input                out_allow,
    output               validout,
    output [WIDTH-1 : 0] dataout
);
reg             pipe1_valid;
reg [WIDTH-1:0] pipe1_data;
reg             pipe2_valid;
reg [WIDTH-1:0] pipe2_data;
reg             pipe3_valid;
reg [WIDTH-1:0] pipe3_data;


wire pipe1_allowin;
wire pipe1_ready_go;
wire pipe1_to_pipe2_valid;


endmodule
