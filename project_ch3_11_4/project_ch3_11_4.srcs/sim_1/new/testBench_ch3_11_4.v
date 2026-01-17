`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2025 10:17:33 PM
// Design Name: 
// Module Name: testBench_ch3_11_4
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


module testBench_ch3_11_4;
reg [12:0] float_in1_test, float_in2_test;
wire gt_test;

design_ch3_11_4 uut1 (.float_in1(float_in1_test), .float_in2(float_in2_test), .gt(gt_test));

initial 
begin
    float_in1_test = 13'b0000110000000;
    float_in2_test = 13'b1110011000000;
    # 200;
    $stop;
    float_in1_test = 13'b1000110000000;
    float_in2_test = 13'b0110011000000;
    # 200;
    $stop;    
    float_in1_test = 13'b0000110000000;
    float_in2_test = 13'b0110011000000;
    # 200;
    $stop;
    float_in1_test = 13'b1000110000000;
    float_in2_test = 13'b1110011000000;
    # 200;
    $stop;
    float_in1_test = 13'b0110110000000;
    float_in2_test = 13'b0000111000000;
    # 200;
    $stop;
    float_in1_test = 13'b1110110000000;
    float_in2_test = 13'b1000111000000;
    # 200;
    $stop;
end
 
endmodule
