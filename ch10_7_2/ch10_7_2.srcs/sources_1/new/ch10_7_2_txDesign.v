`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2026 05:03:42 PM
// Design Name: 
// Module Name: ch10_7_2_txDesign
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


module ch10_7_2_txDesign(
input wire clk, reset,
input wire wr_psa2,
inout wire Ps2d, Ps2c,
input wire [7:0] data_send, 
output reg tx_idle, tx_done_tick
    );


// states
localparam [1:0] idle       = 3'b000,
                 ready_send = 3'b001,
                 start      = 3'b010,
                 send_Data  = 3'b011,
                 stop       = 3'b100;

// signals
reg [2:0] state_reg, state_next;
reg [8:0] data_send_reg, data_send_next;
reg [13:0] C_reg, C_next;
reg [3:0] D_reg, D_next;                


// filter for ps2c 
wire [9:0] filter_next;
reg [9:0] filter_reg;
wire sample_ps2c_next;
reg sample_ps2c_reg;
wire fall_edge_Ps2c;
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
assign filter_next = {Ps2c, filter_reg[9:1]};
assign sample_ps2c_next = (filter_reg == {10{1'b1}})? 1: 
                     (filter_reg == {10{1'b0}}) ? 0:
                     sample_ps2c_reg;

assign fall_edge_Ps2c = sample_ps2c_reg & ~sample_ps2c_next;

wire par;
assign par = ^(^data_send);

reg tri_C, tri_D;
reg Ps2c_out, Ps2d_out;


// FSMD                 
always @(posedge clk)
begin
    if (reset)
        begin
            state_reg         <= idle;
            data_send_reg     <= 0;
            C_reg             <= {14{1'b1}};
            D_reg             <= 0;
        end
     else
        begin
            state_reg         <= state_next;
            data_send_reg     <= data_send_next;
            C_reg             <= C_next;
            D_reg             <= D_next;       
        end
end



always @(*)
begin
state_next = state_reg;
data_send_next = data_send_reg;
C_next = C_reg;
D_next = D_reg;
tri_C = 0;
tri_D = 0;
Ps2c_out = 1'b1;
Ps2d_out = 1'b1;
tx_idle = 1'b0;
tx_done_tick = 1'b0;

case (state_reg)
    idle:
    begin
        tx_idle = 1'b1;
        if (wr_psa2)
           begin
            data_send_next = {par, data_send}; 
            C_next = {14{1'b1}};
            state_next = ready_send;
           end
    end
    ready_send: // request to send
    begin
        tri_C = 1'b1;
        Ps2c_out = 1'b0;
        C_next = C_reg - 1;
        if (C_reg == 1'b0)
            state_next = start;
    end
    
    start: // enable start bit
    begin
        tri_D = 1'b1;
        Ps2d_out = 1'b0;
        if (fall_edge_Ps2c)
        begin
            state_next = send_Data;
            D_next = 8;
        end
    end
    
    send_Data: // 8 data bits and 1 parity bit
    begin
        tri_D = 1'b1;
        Ps2d_out = data_send_reg[0];
        if (fall_edge_Ps2c)
        begin
            data_send_next = {1'b0, data_send_reg[8:1]};
            if (D_reg == 0)
                state_next = stop;
            else
                D_next = D_reg - 1; 
                // state_next = send_Data;
        end
    end
    
    stop:
    begin
       // tri_D = 1'b1;
       // Ps2d_out = 1'b0;
        if (fall_edge_Ps2c)
        begin
            tx_done_tick = 1'b1;
            state_next = idle;
        end
        //else
            //state_next = stop;
    end
endcase
end


assign Ps2d = (tri_D) ? Ps2d_out : 1'bz;
assign Ps2c = (tri_C) ? Ps2c_out : 1'bz;          
    
    
endmodule
