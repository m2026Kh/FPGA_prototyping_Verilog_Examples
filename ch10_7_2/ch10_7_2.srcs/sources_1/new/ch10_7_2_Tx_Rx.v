`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2026 10:11:07 PM
// Design Name: 
// Module Name: ch10_7_2_Tx_Rx
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


module ch10_7_2_Tx_Rx(
input wire clk, reset, 
inout wire Ps2d, Ps2c,
output wire [7:0] data_out,
input wire [7:0] data_send, 
output wire tx_done_tick, rx_done_tick,
input wire wr_psa2
    );
    
    
    
wire rx_en;  
wire tx_idle; 
assign rx_en = tx_idle;    

// instantiate Ps2 modules 
    
// see ch9_6_5_Ps2Rx for Ps2Rx design
ch9_6_5_Ps2Rx Ps2Rx(
.ps2d(Ps2d),
 .ps2c(Ps2c),
 .rx_en(rx_en), .clk(clk), .reset(reset), 
.data_out(data_out),
.rx_done_tick(rx_done_tick)
);


ch10_7_2_txDesign Ps2Tx(.clk(clk), .reset(reset),.wr_psa2(wr_psa2), .Ps2d(Ps2d), .Ps2c(Ps2c), .data_send(data_send), 
.tx_idle(tx_idle), .tx_done_tick(tx_done_tick));

    
endmodule
