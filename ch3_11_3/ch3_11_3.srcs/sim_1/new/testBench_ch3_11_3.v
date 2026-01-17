`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 09:11:34 PM
// Design Name: 
// Module Name: testBench_ch3_11_3
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


module testBench_ch3_11_3;
// signal declaration 
reg [11:0] BCD_in_test;
wire [11:0] BCD_out_test;

design_ch3_11_3 utt1 (.BCD_in(BCD_in_test), .BCD_out(BCD_out_test));

initial 
begin
BCD_in_test = 12'b000000000000;
# 200;
$stop;
BCD_in_test = 12'b000000000001;
# 200;
$stop;
BCD_in_test = 12'b100110010001;
# 200;
$stop;
BCD_in_test = 12'b100010011001;
# 200;
$stop;
BCD_in_test = 12'b010110011001;
# 200;
$stop;
BCD_in_test = 12'b011110010110;
# 200;
$stop;
BCD_in_test = 12'b100110011001;
# 200;
$stop;
end

endmodule
