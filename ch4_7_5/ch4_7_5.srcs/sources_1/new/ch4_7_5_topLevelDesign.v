`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2026 01:31:34 AM
// Design Name: 
// Module Name: ch4_7_5_topLevelDesign
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


module ch4_7_5_topLevelDesign
#(parameter digit_width = 10,  // digit width - each digit is shown by 4 bits
            num_bit_counter = 28,     //number of bits in counter
            M=200000000, // mod-M
            n_bit = 4  // log2(bit_width)
)
(
input clk, reset, en, dir,
output wire [6:0] sevenSegDisp,
output wire [3:0] enable
    );

wire [39:0] input_num ;
assign input_num = {4'h0,4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8,4'h9};
//assign input_num = {4'b0000,4'b0001,4'b0010,4'b0011,4'b0100,4'b0101,4'b0110,4'b0111,4'b1000,4'b0101};

ch4_7_5_design #(.digit_width(digit_width), .num_bit_counter(num_bit_counter), .M(M), .n_bit(n_bit)) ch4_7_5_designModule(.clk(clk), .reset(reset), .input_num(input_num), .output_num(output_num), .en(en), .dir(dir));
wire [15:0] output_num;

 // see ch3_11_3  for  hex_to_sevenSeg 
hex_to_sevenSeg uut12(.hex(output_num[3:0]), .dp(1'b1), .sevenSeg(led0));
hex_to_sevenSeg uut13(.hex(output_num[7:4]), .dp(1'b1), .sevenSeg(led1));
hex_to_sevenSeg uut14(.hex(output_num[11:8]), .dp(1'b1), .sevenSeg(led2));
hex_to_sevenSeg uut15(.hex(output_num[15:12]), .dp(1'b1), .sevenSeg(led3));

wire [6:0] led0, led1, led2, led3;
 // see ch3_11_3 for sevenSegDisp
sevenSegDisp uut16(.clk(clk), .reset(reset),.led0(led0), .led1(led1), .led2(led2), .led3(led3),.sevenSegDisp(sevenSegDisp),.enable(enable));



    
    
    
endmodule
