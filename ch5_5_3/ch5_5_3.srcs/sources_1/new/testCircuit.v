//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2026 01:11:41 AM
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
input wire a,b,
input wire clk, reset,
output wire [6:0] sevenSegDisp,
output wire [3:0] enable
    );

wire [15:0] counter;
ch5_5_3_3Design uut1 (.a(a), .b(b), .counter(counter), .clk(clk), .reset(reset));   

wire [7:0] sevenSeg0,sevenSeg1,sevenSeg2,sevenSeg3;
// 7Seg Led shows counter value in hex, 0 to F
hex_to_sevenSeg uut2 (.hex(counter[3:0]),   .dp(1'b0), .sevenSeg(sevenSeg0));
hex_to_sevenSeg uut3 (.hex(counter[7:4]),   .dp(1'b0), .sevenSeg(sevenSeg1));
hex_to_sevenSeg uut4 (.hex(counter[11:8]),  .dp(1'b0), .sevenSeg(sevenSeg2));
hex_to_sevenSeg uut5 (.hex(counter[15:12]), .dp(1'b0), .sevenSeg(sevenSeg3));

sevenSegDisp uut6 (.clk(clk), .reset(reset), .led0(sevenSeg0), .led1(sevenSeg1), .led2(sevenSeg2), 
.led3(sevenSeg3),.sevenSegDisp(sevenSegDisp), .enable(enable));

endmodule