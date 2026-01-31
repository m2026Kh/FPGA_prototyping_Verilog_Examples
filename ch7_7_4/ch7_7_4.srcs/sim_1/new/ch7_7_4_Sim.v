`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2026 03:24:32 PM
// Design Name: 
// Module Name: ch7_7_4_Sim
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


module ch7_7_4_Sim;
reg clk, reset, start;
reg [4:0] i;
wire [19:0] fib_out;
wire done_tick, ready;

ch7_7_4_Design uut (.clk(clk), .reset(reset), .start(start), .i(i), .fib_out(fib_out), .done_tick(done_tick), .ready(ready));
localparam T = 2;

always 
    begin
        clk = 0;
        #(T/2);
        clk = 1;
        #(T/2);
    end

initial 
begin
    reset = 1'b1;
    #(5*T);
    reset = 1'b0;
    #(5*T);
    $stop;
    start = 1'b1;
    i = 5'b01001;
    wait(done_tick == 1);
    $stop;
    #(T);
    start = 1'b0;
    #(T);
    start = 1'b1;
    i = 5'b00011;
    wait(done_tick == 1);
    #(T);
    $stop;    
end

endmodule
