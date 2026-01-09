`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2025 01:09:32 AM
// Design Name: 
// Module Name: testBench_ch2_9_2
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


module testBench_ch2_9_2;
// signal declaration 
reg [1:0] test_a ;
reg test_en ;
wire [3:0] test_e ;
    // instantiate the circuit under test
    RTL_Code_ch2_9_2 utt_1 (.enable(test_en), .a(test_a), .e(test_e));
    // test vector generation 
    initial 
    begin 
    // TV1
    test_en = 1'b1;
    test_a = 2'b00;
    # 200;
    $stop;
    //TV2
    test_en = 1'b1;
    test_a = 2'b01;
    # 200;
    $stop;
    //TV3
    test_en = 1'b1;
    test_a = 2'b10;
    # 200;
    $stop;
    //TV4
    test_en = 1'b1;
    test_a = 2'b11;
    # 200;
    $stop;
    //TV5
    test_en = 1'b0;
    test_a = 2'b11;
    # 200;
    $stop;
    end 
    
endmodule
