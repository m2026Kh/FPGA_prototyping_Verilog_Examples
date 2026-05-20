`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 09:05:01 PM
// Design Name: 
// Module Name: FPGA_codeScan_FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FPGA_codeScan_FIFO
#(
    parameter B=8,  // FIFO - number of bits in a word
              W=4   // FIFO - number of address bits
)
(
input wire ps2d,
input wire ps2c,
input wire rx_en, clk, reset,
input wire rd_ps2, 
output wire empty,
output [B-1:0] r_data_ps2
    );


wire [B-1:0] data_out_fromps2;
wire code_tick, full;
reg wr_ps2;

// instantiate module
Ps2Rx_codeScan Ps2Rx_codeScan_unit(.ps2d(ps2d),.ps2c(ps2c),.rx_en(rx_en), .clk(clk), .reset(reset), .data_out(data_out_fromps2), .code_tick(code_tick));

// instantiate module
// see 8_7_4 for FIFO
fifo
 #(.B(B), .W(W)) fifo_ps2Rx(.clk(clk), .reset(reset),.rd(rd_ps2), .wr(wr_ps2), .w_data(data_out_fromps2), .empty(empty), .full(full), .r_data(r_data_ps2));

//assign wr_ps2 = code_tick & ~full;

always @(posedge clk)
begin
    wr_ps2 <= code_tick & ~full;
end

endmodule
