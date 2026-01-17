`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2026 11:31:56 AM
// Design Name: 
// Module Name: testBecnh
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
input wire clk,rest, 
input wire [11:0] BCD_in,
output wire [6:0] sevenSegDisp,
output wire [3:0] enable
    );



wire [11:0] BCD_out; 
design_ch3_11_3 uut1(.BCD_in(BCD_in), .BCD_out(BCD_out));

wire [6:0] led0,led1,led2;

hex_to_sevenSeg uut2(.hex(BCD_out[3:0]),.dp(1),.sevenSeg(led0));
hex_to_sevenSeg uut3(.hex(BCD_out[7:4]),.dp(1),.sevenSeg(led1));
hex_to_sevenSeg uut4(.hex(BCD_out[11:8]),.dp(1),.sevenSeg(led2));


sevenSegDisp uut5 (.clk(clk), .reset(reset),.led0(led0), .led1(led1), .led2(led2), .led3(7'b1111111),.sevenSegDisp(sevenSegDisp),.enable(enable));


endmodule
