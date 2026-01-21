`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2026 01:32:02 AM
// Design Name: 
// Module Name: testCircuit
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


module testCircuit(
input wire [5:0] n,
input wire clk, reset,
input wire start,
output wire done_tick,
output wire [7:0] sevenSegDisp,
output wire [3:0] enable
    );

wire [12:0] fn;    
ch6_5_7_2_Design uut1 (.n(n), .clk(clk), .reset(reset), .start(start), .done_tick(done_tick), .fn(fn));    

wire [7:0] led0, led1, led2, led3;
//fn is in hex format in 7Seg display
hex_to_sevenSeg uut12(.hex(fn[3:0]), .dp(1'b1), .sevenSeg(led0));
hex_to_sevenSeg uut13(.hex(fn[7:4]), .dp(1'b1), .sevenSeg(led1));
hex_to_sevenSeg uut14(.hex(fn[11:8]), .dp(1'b1), .sevenSeg(led2));
hex_to_sevenSeg uut15(.hex(fn[12]),   .dp(1'b1), .sevenSeg(led3));

sevenSegDisp uut16(
.clk(clk), .reset(reset),
.led0(led0), .led1(led1), .led2(led2), .led3(led3),
 .sevenSegDisp(sevenSegDisp),
 .enable(enable)
);

    
endmodule
