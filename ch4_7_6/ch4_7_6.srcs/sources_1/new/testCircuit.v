`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2026 07:17:56 PM
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
//output wire [3:0] d1, d2, d3,
input wire clk, clr, go, //
input wire up,
output wire [6:0] sevenSegDisp,
output wire [3:0] enable
    );

wire [3:0] d1, d2, d3;
ch4_7_6_Design uut11 (.d1(d1), .d2(d2), .d3(d3), .clk(clk), .clr(clr), .go(go),.up(up));    
    
wire [6:0] led0, led1, led2;

hex_to_sevenSeg uut12(.hex(d1), .dp(1'b1), .sevenSeg(led0));
hex_to_sevenSeg uut13(.hex(d2), .dp(1'b1), .sevenSeg(led1));
hex_to_sevenSeg uut14(.hex(d3), .dp(1'b1), .sevenSeg(led2));


sevenSegDisp uut15(

.clk(clk), .reset(clr),
.led0(led0), .led1(led1), .led2(led2), .led3({7{1'b1}}),
 .sevenSegDisp(sevenSegDisp),
 .enable(enable)
);
    
endmodule
