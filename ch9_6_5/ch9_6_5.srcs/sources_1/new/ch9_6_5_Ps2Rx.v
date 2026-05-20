`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2026 12:26:27 PM
// Design Name: 
// Module Name: ch9_6_5_Ps2Rx
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


module ch9_6_5_Ps2Rx(
input wire ps2d,
input wire ps2c,
input wire rx_en, clk, reset, 
output wire [7:0] data_out,
output reg rx_done_tick
    );
    
localparam [3:0] packetSize = 11;

localparam [1:0] idle = 2'b00,
                 data = 2'b01,
                 load = 2'b10;

reg [10:0] out_reg, out_next;
reg [3:0] n_reg, n_next;
reg [1:0] state_reg, state_next;

// filter for ps2c 
wire [9:0] filter_next;
reg [9:0] filter_reg;
wire sample_ps2c_next;
reg sample_ps2c_reg;
wire fall_edge;
always @(posedge clk)
begin
    if (reset)
    begin
        filter_reg <= 0;
        sample_ps2c_reg <=0;
    end
    else
    begin
        filter_reg <= filter_next;
        sample_ps2c_reg <= sample_ps2c_next;
    end
end
assign filter_next = {ps2c, filter_reg[9:1]};
assign sample_ps2c_next = (filter_reg == {10{1'b1}})? 1: 
                     (filter_reg == {10{1'b0}}) ? 0:
                     sample_ps2c_reg;

assign fall_edge = sample_ps2c_reg & ~sample_ps2c_next;

// ------------------------

always @(posedge clk)
begin
    if (reset)
        begin
            out_reg <= 0;
            n_reg   <= 0; 
            state_reg <= idle;
        end
     else 
        begin
            out_reg <= out_next;
            n_reg <= n_next;
            state_reg <= state_next;
        end
end

always @(*)
begin
rx_done_tick = 1'b0;
state_next = state_reg;
out_next = out_reg;
n_next = n_reg;

case (state_reg)
    idle:
    begin
    if (rx_en)
        state_next = data;
//    else
//        state_next = state_reg;
    end
    
    
    data:
    begin
    if (fall_edge)
        begin
            out_next = {ps2d,out_reg[10:1]};
            n_next = n_reg+1;
            if (n_reg == packetSize - 1 )
                state_next = load;
//            else
//                state_next = state_reg;        
        end   
//    else
//        begin
//            state_next = state_reg;
//            n_next = n_reg;
//        end
    end
    
    load:
    begin
        state_next = idle;
        n_next = 0;  
        rx_done_tick = 1'b1;
    end
endcase

end
assign data_out = out_reg[8:1]; // we fetch this once rx_done_tick is 1. Then, we are sure out_reg are properly filled with data in

    
    
endmodule
