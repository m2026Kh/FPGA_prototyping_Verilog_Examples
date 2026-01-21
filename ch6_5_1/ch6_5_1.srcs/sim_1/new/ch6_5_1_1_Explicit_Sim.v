`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 01:51:57 AM
// Design Name: 
// Module Name: ch6_5_1_1_Sim
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


module ch6_5_1_1_Explicit_Sim;
reg si;
wire so,so_tick;
reg clk, reset;

ch6_5_1_1_Design_explicit uut2 (.si(si), .so(so), .so_tick(so_tick), .clk(clk), .reset(reset));
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
        $stop;
        reset = 1'b1;
        si = 0;
        #(2*T);
        //$stop;
        reset = 1'b0;
        si = 0;
        #(2*T)
        //$stop;
        si = 1;
        #(T);
        //$stop;
        si = 0;
        #(T);
        //$stop;
        si = 0;
        #(T);
        //$stop;
        si = 1;
        #(T);
        //$stop;
        si = 0;
        #(T);
        $stop;
        si = 1;
        #(T);
        $stop;
        si = 1;
        #(10*T);
        $stop;
        
        si = 0;
        #(2*T);
        si = 1;
        #(T);
        si = 0;
        #(T);
        si = 1;
        #(T);
        si = 0;
        #(T);
        si = 0;
        #(T);
        si = 0;
        #(3*T);
        $stop;

    end
endmodule
