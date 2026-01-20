`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2025 12:49:00 PM
// Design Name: 
// Module Name: ch4_7_6_1_Sim
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


module ch4_7_6_1_Sim;
wire [3:0] d1, d2, d3;
reg clk, clr, go, up; // assume clk is 50Mhz
wire [3:0] d1_d_next, d2_d_next, d3_d_next; // for debugging
wire [22:0] counter_curr_w;



ch4_7_6_Design uut (.up(up), .d1(d1), .d2(d2), .d3(d3), .clk(clk), .clr(clr), .go(go), .d1_d_next(d1_d_next), .d2_d_next(d2_d_next), .d3_d_next(d3_d_next), .counter_curr_w(counter_curr_w));

localparam  T = 20; // 50MHz clk, T = 20 ns, timescale = 1ns

always 
 begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
 end
 
 initial
    begin
        // initial 
         clr = 1'b0;
         go = 1'b1;
         up = 1'b1;
         // clear 
         #(T);
         clr = 1'b1;
         #(3*T);
         $stop;
         clr = 1'b0;
         #(1000000*T);
         $stop;
         clr = 1'b1;
         #(3*T);
         clr = 1'b0;
         go = 1'b1;
         #(10000*T);    
         $stop;
         go = 1'b0; 
         #(1000000*T);  
         go = 1'b1;  
         #(1000000*T); 
         $stop;   
 
         // initial 
         clr = 1'b0;
         go = 1'b1;
         up = 1'b0;
         // clear 
         #(T);
         clr = 1'b1;
         #(3*T);
         $stop;
         clr = 1'b0;
         #(1000000*T);
         $stop;
         clr = 1'b1;
         #(3*T);
         clr = 1'b0;
         go = 1'b1;
         #(10000*T);    
         $stop;
         go = 1'b0; 
         #(1000000*T);  
         go = 1'b1;  
         #(1000000*T); 
         $stop;        
         
         
                  
    end 

endmodule
