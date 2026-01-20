`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 05:06:34 PM
// Design Name: 
// Module Name: ch4_7_1Sim
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


module ch4_7_1Sim;
reg clk, reset;
reg [N-1:0] m, n;
wire sw;

localparam N = 4;
localparam T = 2; // this is just simulation. no need to have excat T
// instan
ch4_7_1_Design uut (.clk (clk), .reset(reset), .m(m), .n(n), .sw(sw));

always 
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end

initial 
    begin
        reset = 1'b1;
        #(2*T);
        reset = 1'b0;
        m = 4'b1000;
        n = 4'b010; 
        #(100*T);
        $stop;
    end
endmodule
