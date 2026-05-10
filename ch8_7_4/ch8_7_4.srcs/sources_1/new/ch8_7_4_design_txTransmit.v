`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2026 09:50:59 PM
// Design Name: 
// Module Name: ch8_7_4_design_txTransmit
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


module ch8_7_4_design_txTransmit
#(parameter N_bit = 8, //    number of data bits
            S_count = 16) // number of ticks for the stop bits 
(input wire clk, reset,
input wire tick,
input wire tx_start,
input wire [N_bit-1:0] d_in,
output reg tx_done_tick,
output wire tx
    );
// states
localparam [1:0] idle  = 2'b00,
                 start = 2'b01,
                 data  = 2'b10,
                 stop  = 2'b11;
           
// internal signal declaration 
reg [1:0] state_reg, state_next;
reg [3:0] c_tick_reg, c_tick_next;
reg [2:0] ds_count_reg, ds_count_next;
reg [N_bit-1:0] d_reg, d_next; 
reg tx_reg, tx_next;

always @(posedge clk or posedge reset)
begin
    if (reset == 1)
        begin
            c_tick_reg   <= 4'b0000;
            ds_count_reg <= 3'b000;
            d_reg        <= 0;
            state_reg    <= 2'b00;
            tx_reg       <= 1'b1;
        end
    else 
        begin
            c_tick_reg   <= c_tick_next;
            ds_count_reg <= ds_count_next;
            d_reg        <= d_next;
            state_reg    <= state_next; 
            tx_reg       <= tx_next;      
        end
end

always @(*)
begin
tx_done_tick = 1'b0;
state_next  = state_reg;
d_next = d_reg;
ds_count_next = ds_count_reg;
c_tick_next = c_tick_reg;
case (state_reg)
    idle:
    begin
        tx_next = 1'b1;
        if (tx_start == 1'b1)
        begin
            state_next = start;
            d_next = d_in;
            c_tick_next = 4'b0000; 
        end
         else
            c_tick_next = 4'b0000; 
    end
    start:
    begin
        tx_next = 1'b0;
        if (tick == 1) 
            begin
                if (c_tick_reg == 4'b1111)
                    begin
                        c_tick_next   = 4'b0000; 
                        ds_count_next = 3'b000; 
                        d_next        = d_reg;
                        state_next    = data;
                    end
                 else
                    begin
                        c_tick_next = c_tick_reg + 4'b0001;
                    end
            end
        
    end
    data:
    begin
          tx_next = d_reg[0];
          if (tick == 1) 
            begin
                if (c_tick_reg == 4'b1111)
                    begin
                        c_tick_next   = 4'b0000;  
                        d_next        = d_reg >>1;
                        if (ds_count_reg == N_bit-1)
                            begin
                                // ds_count_next = 3'b000;
                                 state_next    = stop;
                            end
                        else
                            begin
                                ds_count_next = ds_count_reg + 3'b001;
                            end                      
                    end
                 else
                    begin
                        c_tick_next   = c_tick_reg + 4'b0001;
                    end
            end
    end
    stop:
    begin
    tx_next = 1'b1;
      if (tick == 1) 
            begin  
                        if (c_tick_next == S_count-1)
                            begin
                                 //ds_count_next = 4'b0000;
                                 state_next    = idle;
                                 tx_done_tick   = 1'b1;                 
                            end
                        else
                            begin
                                c_tick_next = c_tick_reg + 4'b0001;
                            end                      
                    end
            end  
endcase
end
       
assign tx    = tx_reg;
 
endmodule

