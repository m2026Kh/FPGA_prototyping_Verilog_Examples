`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2025 10:11:13 PM
// Design Name: 
// Module Name: test_3To8
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


module test_3To8;
// signal declaration 
reg [2:0] test_a ;
reg test_en ;
wire [7:0] test_e ;
    // instantiate the circuit under test
    design_3To8 utt_3 (.enable_3(test_en), .a_3(test_a), .e_3(test_e));
    // test vector generation 
    initial 
    begin 
    // TV1
    test_en = 1'b1;
    test_a = 3'b000;
    # 200;
    $stop;
    //TV2
    test_en = 1'b1;
    test_a = 3'b001;
    # 200;
    $stop;
    //TV3
    test_en = 1'b1;
    test_a = 3'b010;
    # 200;
    $stop;
    //TV4
    test_en = 1'b1;
    test_a = 3'b011;
    # 200;
    $stop;
    // TV5
    test_en = 1'b1;
    test_a = 3'b100;
    # 200;
    $stop;
    //TV6
    test_en = 1'b1;
    test_a = 3'b101;
    # 200;
    $stop;
    //TV7
    test_en = 1'b1;
    test_a = 3'b110;
    # 200;
    $stop;
    //TV8
    test_en = 1'b1;
    test_a = 3'b111;
    # 200;  
    $stop;
    //TV5
    test_en = 1'b0;
    test_a = 3'b111;
    # 200;
    $stop;
    end 
    
endmodule

