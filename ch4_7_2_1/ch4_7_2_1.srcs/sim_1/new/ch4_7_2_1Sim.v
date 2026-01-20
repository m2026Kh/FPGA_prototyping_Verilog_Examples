`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 07:14:29 PM
// Design Name: 
// Module Name: ch4_7_2_1Sim
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


module ch4_7_2_1Sim;
reg clk, reset;
reg [3:0] w;
wire sw;
wire [3:0] curr,next;

ch4_7_2_1Design uut (.clk(clk), .reset(reset), .w(w), .sw(sw), .x(curr), .y(next));
localparam T = 2;

always 
    begin
        clk = 1'b0;
        #(T/2);
        clk = 1'b1;
        #(T/2);
    end


initial 
    begin
        // test reset
        reset = 1'b1;
        #(T/2);
        reset = 1'b0;
   end
  
initial
    begin        
       //  test with w
       w = 4'b1000;
       @(negedge reset);
       #(16*T);
       $stop;
       w = 4'b1110;
       #(16*T);
       $stop;
       w = 4'b0001;
       #(16*T);
       $stop;       
    end
    
endmodule
