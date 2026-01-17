`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:36:58 PM
// Design Name: 
// Module Name: design_ch3_11_4
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


module design_ch3_11_4(
input wire[12:0] float_in1, float_in2,
output reg gt
    );
wire sign_in1, sign_in2;    
wire[11:0] expMant_in1, expMant_in2;
assign sign_in1     = float_in1[12];
assign expMant_in1  = float_in1[11:0];
assign sign_in2     = float_in2[12];
assign expMant_in2  = float_in2[11:0];

always @*
begin
gt = 0;
// this is simple comparasion, as long as neither is subnormal, infinite, or NaN
if ((sign_in1 < sign_in2) | ((sign_in1 == sign_in2) & ((sign_in1 == 0 & expMant_in1 > expMant_in2) | (sign_in1 == 1 & expMant_in1 < expMant_in2))))
begin
    gt = 1;
end
end
endmodule
