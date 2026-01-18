`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2025 04:28:49 PM
// Design Name: 
// Module Name: testBench_ch3_11_5_2
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


module testBench_ch3_11_5_2;
reg [7:0] integer_test;
wire [12:0] float_out;
// instatitiate the circuit under test
ch3_11_5_1 uut1 (.int_num_org(integer_test), .float_num(float_out));
initial 
    begin
        // test vector 1
        integer_test = 8'b01111111;
        # 200;
        $stop;
        // test vector 2
        integer_test = 8'b01000111;
        # 200;
        $stop;
        // test vector 3
        integer_test = 8'b00111111;
        # 200;
        $stop;
        // test vector 4
        integer_test = 8'b00100101;
        # 200;
        $stop;
        // test vector 5
        integer_test = 8'b00011111;
        # 200;
        $stop;
        // test vector 6
        integer_test = 8'b00010101;
        # 200;
        $stop;
        // test vector 7
        integer_test = 8'b00001111;
        # 200;
        $stop;
        // test vector 8
        integer_test = 8'b00001001;
        # 200;
        $stop;
        // test vector 9
        integer_test = 8'b00000111;
        # 200;
        $stop;
        // test vector 10
        integer_test = 8'b00000101;
        # 200;
        $stop;
        // test vector 11
        integer_test = 8'b00000011;
        # 200;
        $stop;
        // test vector 12
        integer_test = 8'b00000010;
        # 200;
        $stop;
        // test vector 13
        integer_test = 8'b00000001;
        # 200;
        $stop;
        // test vector 14
        integer_test = 8'b00000000;
        # 200;
        $stop;
// negative integers    
        // test vector 1
        integer_test = 8'b11111111;
        # 200;
        $stop;
        // test vector 2
        integer_test = 8'b11000111;
        # 200;
        $stop;
        // test vector 3
        integer_test = 8'b10111111;
        # 200;
        $stop;
        // test vector 4
        integer_test = 8'b10100101;
        # 200;
        $stop;
        // test vector 5
        integer_test = 8'b10011111;
        # 200;
        $stop;
        // test vector 6
        integer_test = 8'b10010101;
        # 200;
        $stop;
        // test vector 7
        integer_test = 8'b10001111;
        # 200;
        $stop;
        // test vector 8
        integer_test = 8'b10001001;
        # 200;
        $stop;
        // test vector 9
        integer_test = 8'b10000111;
        # 200;
        $stop;
        // test vector 10
        integer_test = 8'b10000101;
        # 200;
        $stop;
        // test vector 11
        integer_test = 8'b10000011;
        # 200;
        $stop;
        // test vector 12
        integer_test = 8'b10000010;
        # 200;
        $stop;
        // test vector 13
        integer_test = 8'b10000001;
        # 200;
        $stop;
        // test vector 14
        integer_test = 8'b10000000;
        # 200;
        $stop;
    end
    
endmodule
