`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2026 01:07:44 AM
// Design Name: 
// Module Name: ch6_5_4Sim
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


module ch6_5_4Sim;

reg [7:0] BCD_in;
reg clk, reset;
reg start;

wire [3:0] BCD_out_0, BCD_out_1, BCD_out_2, BCD_out_3;
wire done_tick, ready;
wire overflow;

ch6_5_4Design uut (.BCD_in(BCD_in), .clk(clk), .reset(reset), .start(start), .BCD_out_0(BCD_out_0), .BCD_out_1(BCD_out_1), .BCD_out_2(BCD_out_2), .BCD_out_3(BCD_out_3),.done_tick(done_tick), .ready(ready), .overflow(overflow));

localparam [1:0] T = 2;
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
    start = 1'b0;
    #(T);
    reset = 1'b0;
    BCD_in = 8'b00010001;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;
    
    BCD_in = 8'b00100000;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;
    
    BCD_in = 8'b00000000;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;
    
    
    BCD_in = 8'b00000001;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;


    BCD_in = 8'b00000010;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;  

    BCD_in = 8'b00100001;
    start = 1'b1;
    #(T)
    start = 1'b0;
    #(100*T);
    $stop;  

end

endmodule
