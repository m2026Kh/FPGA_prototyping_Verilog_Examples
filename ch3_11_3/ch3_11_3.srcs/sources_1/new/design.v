`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 10:15:48 PM
// Design Name: 
// Module Name: design
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


module design_ch3_11_3
(
input wire [11:0] BCD_in,
output reg [11:0] BCD_out
    );
  
// signal  declaration
reg [3:0] in_1st, in_2nd, in_3rd, out_1st, out_2nd, out_3rd;
reg       carryOver_1st, carryOver_2nd;
  
always @*
begin

in_1st = BCD_in[3:0];
in_2nd = BCD_in[7:4];
in_3rd = BCD_in[11:8];

case (in_1st)
4'b1001: 
begin
    out_1st       = 4'b0000;  
    carryOver_1st = 1'b1;
 end
default: 
begin
    out_1st       = in_1st + 1;  
    carryOver_1st = 1'b0;
end
endcase 

out_2nd = in_2nd + carryOver_1st;
case (out_2nd)
4'b1010: 
begin
    out_2nd       = 4'b0000;  
    carryOver_2nd = 1'b1;
end
default: 
begin
    //out_2nd       = out_2nd;  
    carryOver_2nd = 1'b0;
end
endcase 

out_3rd = in_3rd + carryOver_2nd;
case (out_3rd)
4'b1010: 
begin
    out_3rd       = 4'b0000;  
    //carryOver_3rd = 1'b1;
end
//default: 
    //out_3rd       = out_3rd;  
    //carryOver_3rd = 1'b0;
endcase 
BCD_out = {out_3rd,out_2nd,out_1st};
end
endmodule
