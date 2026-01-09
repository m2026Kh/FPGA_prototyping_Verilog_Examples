//timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2025 12:44:40 AM
// Design Name: 
// Module Name: RTL_Code_ch2_9_2
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


module RTL_Code_ch2_9_2(
input wire[1:0] a,
input wire enable, 
output wire[3:0] e
    );
    // body
    assign e[0] = enable & ~a[0]&~a[1];
    assign e[1] = enable & a[0]&~a[1];
    assign e[2] = enable & ~a[0]&a[1];
    assign e[3] = enable & a[0]&a[1];
    
endmodule
