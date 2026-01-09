`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2025 09:48:22 PM
// Design Name: 
// Module Name: design_3To8
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


module design_3To8(
input wire[2:0] a_3,
input wire enable_3, 
output wire[7:0] e_3
    );
 // internal signal declaration 
 wire[3:0] tmp_e;
RTL_Code_ch2_9_2 utt_2 (.enable(enable_3), .a(a_3[1:0]), .e(tmp_e));
    assign e_3[0] = ~a_3[2] & tmp_e[0];
    assign e_3[1] = ~a_3[2] & tmp_e[1];
    assign e_3[2] = ~a_3[2] & tmp_e[2];
    assign e_3[3] = ~a_3[2] & tmp_e[3];
    assign e_3[4] = a_3[2]  & tmp_e[0];
    assign e_3[5] = a_3[2]  & tmp_e[1];
    assign e_3[6] = a_3[2]  & tmp_e[2];
    assign e_3[7] = a_3[2]  & tmp_e[3];

endmodule
