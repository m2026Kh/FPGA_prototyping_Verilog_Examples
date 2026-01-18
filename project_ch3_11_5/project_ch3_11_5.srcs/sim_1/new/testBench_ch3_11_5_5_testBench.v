`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2025 12:35:38 PM
// Design Name: 
// Module Name: testBench_ch3_11_5_5_testBench
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


module testBench_ch3_11_5_5_testBench;
reg [12:0] float_num_test;
wire [7:0] int_num_test;
wire uf_test, of_test; 
ch3_11_5_5 utt2 (.float_num(float_num_test), .int_num_org(int_num_test), .uf(uf_test), .of(of_test));
initial 
    begin
    // test vector  1 - output = 00001010
    float_num_test = 13'b0010010101101; 
    # 200;
    $stop;
    // test vector  2 - output = 00101011
    float_num_test = 13'b0011010101101; 
    # 200;
    $stop;
    // test vector  3 - output = 00000010
    float_num_test = 13'b0001010101101; 
    # 200;
    $stop;   
    // test vector  4 - output = 01010110
    float_num_test = 13'b0011110101101; 
    # 200;
    $stop;  
    // test vector  5 - output = 01111111 , of = 1
    float_num_test = 13'b0100010000000; 
    # 200;
    $stop;   
    // test vector  6
    float_num_test = 13'b0111111111111; 
    # 200;
    $stop;
    // test vector  7
    float_num_test = 13'b0000011111111; 
    # 200;
    $stop;  
    
    // negative values
    // test vector  1
    float_num_test = 13'b1010010101101; 
    # 200;
    $stop;
    // test vector  2
    float_num_test = 13'b1011010101101; 
    # 200;
    $stop;
    // test vector  3
    float_num_test = 13'b1001010101101; 
    # 200;
    $stop;   
    // test vector  4
    float_num_test = 13'b1011110101101; 
    # 200;
    $stop;  
    // test vector  5
    float_num_test = 13'b1100010000000; 
    # 200;
    $stop;   
    // test vector  6
    float_num_test = 13'b1111111111111; 
    # 200;
    $stop;
    // test vector  7
    float_num_test = 13'b1000011111111; 
    # 200;
    $stop;  
    end
endmodule
