`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2026 03:35:41 PM
// Design Name: 
// Module Name: ch8_7_4_design_rxReceiver
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


module ch8_7_4_design_rxReceiver
#(parameter N_bit = 8, //    number of data bits
            S_count = 16) // number of ticks for the stop bits 
(input wire clk, reset,
input wire tick,
input wire rx,
output wire [N_bit-1:0] d_out,
output reg rx_done_tick
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

always @(posedge clk, posedge reset)
begin
    if (reset == 1)
        begin
            c_tick_reg   <= 4'b0000;
            ds_count_reg <= 4'b0000;
            d_reg        <= {N_bit{1'b0}};
            state_reg    <= 2'b00;
        end
    else 
        begin
            c_tick_reg   <= c_tick_next;
            ds_count_reg <= ds_count_next;
            d_reg        <= d_next;
            state_reg    <= state_next;       
        end
end

always @(*)
begin
rx_done_tick = 1'b0;
state_next  = state_reg;
c_tick_next = c_tick_reg ;
ds_count_next = ds_count_reg;
d_next = d_reg;
case (state_reg)
    idle:
    begin
        if (~rx)
        begin
            state_next = start;
            c_tick_next = 4'b0000; 
        end
    end
    start:
    begin
        if (tick) 
            begin
                if (c_tick_reg == 4'b0111)
                    begin
                        c_tick_next   = 4'b0000; 
                        ds_count_next = 3'b000; 
                        //d_next        = {N_bit{1'b0}};
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
          if (tick) 
            begin
                if (c_tick_reg == 4'b1111)
                    begin
                        c_tick_next   = 4'b0000;  
                        d_next        = {rx, d_reg[N_bit-1:1]}; // this is not a good design. We assumed N_bit is 8. Cannot use N_bit in run time. 
                        if (ds_count_reg == (N_bit-1))
                            begin
                                 //ds_count_next = 4'b0000;
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
      if (tick) 
            begin
                if (c_tick_reg == (S_count-1))
                      begin
                          //ds_count_next = 4'b0000;
                           state_next    = idle;
                           rx_done_tick = 1'b1;                 
                       end
                else
                       begin
                           c_tick_next = c_tick_reg + 4'b0001; 
                        end                      
                    end
            end 
endcase
end
       
assign d_out = d_reg; 
 
endmodule
