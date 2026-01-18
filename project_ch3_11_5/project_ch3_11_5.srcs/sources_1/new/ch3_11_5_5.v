`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2025 12:50:20 AM
// Design Name: 
// Module Name: ch3_11_5_5
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


module ch3_11_5_5(
input wire [12:0] float_num,
output reg [7:0] int_num_org,
output reg uf, of
    );
// sign of float declaration
wire float_sign; 
assign float_sign = float_num[12];
// exponent of floating number
wire [3:0] float_exp; 
assign float_exp = float_num[11:8];
// mantissa of floating number.
wire [7:0] float_mantissa; 
assign float_mantissa = float_num[7:0];

// I have to define int_num for two's complement calcuation later on 
reg [7:0] int_num;
always @*
    begin
    // initial values. why? see below:
    // Make sure that all branches of the if and case statements are included.
    // Make sure that the outputs are assigned in all branches.
    // One way to satisfy the two previous guidelines is to assign default values for outputs in the beginning of the always block.
        uf = 1'b0;
        of = 1'b0;
        int_num[7:0] = 8'b00000000;
        // blocking statements for combinational statements, i.e. using "=", not "<="  
        if (float_exp >= 8)
            begin
                of = 1'b1;
                int_num = 8'b01111111;
            end
         else if (float_exp == 0)
            begin
                uf = 1'b1;
                int_num = 8'b00000000;
            end
          else
            begin 
               // int_num[6:(7-float_exp)] = float_num[7:(8-float_exp)]; -> this is wrong. bit selection should be constant, not variable (run-time). Use bit shift which can be variable? why? see the notes in the book.
                 int_num =  float_mantissa >> (8-float_exp); // I already noted that int_num has 7 bits and float_mantissa has 8 bits
            end 
          int_num_org = (float_sign) ? {1'b1,~(int_num[6:0] - 1'b1)} : int_num;
    end
endmodule
