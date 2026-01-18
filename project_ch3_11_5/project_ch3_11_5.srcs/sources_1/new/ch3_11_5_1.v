`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2025 02:07:43 PM
// Design Name: 
// Module Name: ch3_11_5_1
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


module ch3_11_5_1
#(parameter int_W = 8,
  parameter float_exp = 4,
  parameter float_mantisa = 8)
(
input wire [int_W-1:0] int_num_org,
output reg [float_exp + float_mantisa:0] float_num // it also has a sign bit
    );
// sign of integer declaration 
wire sign_int;  
wire [int_W-1:0] int_num;
assign sign_int = int_num_org[int_W-1];
assign int_num = (sign_int)? (~int_num_org + 8'b00000001) : int_num_org;
localparam float_W = float_exp + float_mantisa;
always @*
    begin 
    // based on floating width of 13
    float_num[7:0] = 8'b00000000; // initial value. why? see below: 
    // Make sure that all branches of the if and case statements are included.
    // Make sure that the outputs are assigned in all branches.
    // One way to satisfy the two previous guidelines is to assign default values for outputs in the beginning of the always block.
    float_num[float_W] = sign_int;
    // priority encoder - based on integer width of 8 and floating width of 13
    // blocking statements for combinational statements 
    if (int_num[6]) 
        begin 
            float_num[11:8] = 4'b0111;
            float_num[7:1] = int_num[6:0];
        end
    else if (int_num[5]) 
        begin 
            float_num[11:8] = 4'b0110;
            float_num[7:1] = int_num[6:0] << 1;
        end
    else if (int_num[4]) 
        begin 
            float_num[11:8] = 4'b0101;
            float_num[7:1] = int_num[6:0] << 2;
        end
    else if (int_num[3]) 
        begin 
            float_num[11:8] = 4'b0100;
            float_num[7:1] = int_num[6:0] << 3;
        end
    else if (int_num[2]) 
        begin 
            float_num[11:8] = 4'b0011;
            float_num[7:1] = int_num[6:0] << 4;
        end
    else if (int_num[1]) 
        begin 
            float_num[11:8] = 4'b0010;
            float_num[7:1] = int_num[6:0] << 5;
        end
    else if (int_num[0]) 
        begin 
            float_num[11:8] = 4'b0001;
            float_num[7:1] = int_num[6:0] << 6;
        end
    else if (~int_num[0]) 
        begin 
            float_num[11:8] = 4'b0000;
            //float_num[7:1] = int_num[6:0] << 7; initial value is kept for this case
        end
    end
endmodule
