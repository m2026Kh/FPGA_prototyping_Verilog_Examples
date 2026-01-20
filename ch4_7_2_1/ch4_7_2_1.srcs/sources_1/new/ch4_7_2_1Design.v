//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 06:35:50 PM
// Design Name: 
// Module Name: ch4_7_2_1Design
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


module ch4_7_2_1Design(
input wire clk, reset,
input wire [3:0] w,
output wire sw, // square wave
output wire [3:0] x,y // I added these two only for debugging 
    );

reg [3:0] w_curr; // current states of the reg
reg [3:0] w_next;    

// registers
always @(posedge clk, posedge reset)
    if (reset)
        begin
            w_curr   <= 4'b0000;
        end
    else 
        begin
            w_curr   <= w_next;
        end

// next state, combinational
always @(*)
begin 
    if (reset == 1'b1)
        begin
            w_next = 4'b0000;
        end
    if (reset == 1'b0 &&(w_curr == 4'b1111))
        begin
            w_next = 4'b0000;
        end 
    else if (reset == 1'b0 && (w_curr < 4'b1111))
        begin
            w_next = w_curr + 1'b1;
        end
 end      

assign sw = w_curr < w ? 1'b1:1'b0 ;
assign x = w_curr; 
assign y = w_next;

endmodule
