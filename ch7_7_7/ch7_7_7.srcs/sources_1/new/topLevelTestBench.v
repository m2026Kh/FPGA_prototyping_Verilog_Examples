`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 09:29:45 PM
// Design Name: 
// Module Name: topLevelTestBench
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


module topLevelTestBench();
localparam  T = 20;
localparam  B = 8;
wire clk, reset;
wire rd, wr;
wire [B-1:0] w_data;
wire empty, full;
wire [B-1:0] r_data; 


// uut instantiation

fifo #(.B(B), .W(2)) uut (.rd(rd), .wr(wr), .clk(clk), .reset(reset), .w_data(w_data), .empty(empty), .full(full), .r_data(r_data));

ch7_7_7_testVectorGen  #(.B(B), .M(2), .T(T)) bin_gen_uut (.rd(rd), .wr(wr), .clk(clk), .reset(reset),.w_data(w_data));

ch7_7_7_monitor #(.B(B), .M(2), .T(T)) monitor_uut (.rd(rd), .wr(wr), .clk(clk), .reset(reset), .w_data(w_data), .empty(empty), .full(full), .r_data(r_data));


endmodule
