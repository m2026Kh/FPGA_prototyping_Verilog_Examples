`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 03:19:02 AM
// Design Name: 
// Module Name: ch6_5_7_3_Sim
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


module ch6_5_7_3_Sim
#( parameter T = 2
);
reg [5:0] n;
reg clk, reset;
reg start;
wire done_tick;
wire [12:0] fn;


ch6_5_7_2_Design uut (.n(n), .clk(clk), .reset(reset), .start(start), .done_tick(done_tick), .fn(fn));

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
    #(2*T);
    reset = 1'b0;
    #(2*T);
    $stop;
    
    start = 1'b1;
    n = 5'b10111;
    #(T);
    start = 1'b0;    
    #(63*T);
    $stop;
    
    start = 1'b1;
    n = 5'b10001;
    #(T);
    start = 1'b0;
    #(63*T);
    $stop;
    
    end

endmodule
