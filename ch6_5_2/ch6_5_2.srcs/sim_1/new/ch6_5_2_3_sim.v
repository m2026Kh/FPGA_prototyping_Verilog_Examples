`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 01:36:23 PM
// Design Name: 
// Module Name: ch6_5_2_3_sim
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


module ch6_5_2_3_sim
#(parameter T = 2);

reg [7:0] BCD_in;
reg clk, reset;
reg start;
wire [6:0] binary_out;
wire done_tick, ready;

ch6_5_2_2_design uut (.BCD_in(BCD_in), .clk(clk), .reset(reset), .start(start), .binary_out(binary_out), .done_tick(done_tick), .ready(ready));


always
begin
        clk = 1'b0;
        #(T/2);
        clk = 1'b1;
        #(T/2);
end  
    
initial 
    begin
         reset = 1'b1;
         #(3*T);
         $stop;
         reset = 1'b0;
         
         BCD_in = 8'b10011001;
         start = 1'b1;
         #(T);
         start = 1'b0;
         #(20*T);
         $stop;
         
         BCD_in = 8'b00111001;
         start = 1'b1;
         #(T);
         start = 1'b0;
         #(20*T);
         $stop;
         
         BCD_in = 8'b00010001;
         start = 1'b1;
         #(T);
         start = 1'b0;
         #(20*T);
         $stop;
         
    end

endmodule
