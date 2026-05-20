`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 07:50:39 PM
// Design Name: 
// Module Name: Ps2Rx_codeScan
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


module Ps2Rx_codeScan(
input wire ps2d,
input wire ps2c,
output wire [7:0] data_out,
input wire rx_en, clk, reset,
output reg code_tick 
    );

wire rx_done_tick;
    
// instantiate module    
ch9_6_5_Ps2Rx Ps2Rx(.ps2d(ps2d),.ps2c(ps2c),.rx_en(rx_en), .clk(clk), .reset(reset), .data_out(data_out),.rx_done_tick(rx_done_tick));

localparam [0:0] wait_state = 1'b0,
                 code_state = 1'b1;
           
reg state_reg,state_next;
always @(posedge clk)
begin
    if (reset)
        state_reg <= wait_state;
    else
        state_reg <= state_next;
end

always @(*)
begin
state_next = state_reg;
code_tick = 1'b0;
    case (state_reg)
    
    wait_state:
        if (rx_done_tick == 1'b1 & data_out == 8'hf0) // rx_done_tick is 1'b1 when it has 8 bits. First byte is for F0, in wait_state. Second byte is for make code in code_state. SO, that is wht we have rx_done_tick conditions in both states. We wait untill we have 1 byte in data_out. 
        begin
            state_next = code_state;
        end

    code_state:
        if (rx_done_tick == 1'b1)
        begin
            state_next = wait_state;
            code_tick = 1'b1;
        end

     endcase
end

        
endmodule
