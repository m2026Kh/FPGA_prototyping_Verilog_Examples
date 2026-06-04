`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2026 02:07:41 AM
// Design Name: 
// Module Name: ch10_7_2_mouseInterface
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


module ch10_7_2_mouseInterface(
input wire clk, reset,
output reg done_tick,
output wire [8:0] xVal, yVal,
output wire [2:0] botton,
inout wire Ps2d, Ps2c,
input wire disable_mode, stream_mode 
    );
    
    
reg wr_psa2;
wire tx_done_tick;
wire rx_done_tick;
wire [7:0] data_out;
reg [7:0] data_send;
    
ch10_7_2_Tx_Rx TxRxUnit(
.clk(clk), .reset(reset), 
.Ps2d(Ps2d), .Ps2c(Ps2c),
.data_out(data_out),
.data_send(data_send), 
.tx_done_tick(tx_done_tick), .rx_done_tick(rx_done_tick),
.wr_psa2(wr_psa2)
    );
    
    
// states
localparam [3:0] idle       = 4'b1010, 
                 init1_FF   = 4'b0000,  // enable wr_psa2
                 init2_FF   = 4'b0001,  // send FF
                 init3_FF   = 4'b0010,  // receive FE
                 init1_F4   = 4'b0011,  // enable wr_psa2
                 init2_F4   = 4'b0100,  // send F4
                 init3_F4   = 4'b0101,  // receive FE
                 packet1    = 4'b0110,  // receive packet 1 
                 packet2    = 4'b0111,  // receive packet 2 
                 packet3    = 4'b1000,  // receive packet 3
                 done       = 4'b1001; 

// FSMD
reg [3:0] state_reg, state_next;
reg [8:0] xVal_next, xVal_reg, yVal_next, yVal_reg;
reg [2:0] botton_next, botton_reg;
always @(posedge clk)
begin
    if (reset)
        begin
            state_reg <= idle;
            xVal_reg  <= 0;
            yVal_reg  <= 0;
            botton_reg <= 0;
        end
    else
        begin
            state_reg <= state_next;
            xVal_reg  <= xVal_next;
            yVal_reg  <= yVal_next;
            botton_reg <= botton_next;
        end
end

// there is one limitation. if stream_mode enabled between init1_FF till init3_FF, it does not apply. It is ok for now.

// state reg and data path
always @(*)
begin
state_next = state_reg;
xVal_next = xVal_reg;
yVal_next = yVal_reg;
botton_next = botton_reg;
done_tick = 1'b0;
wr_psa2 = 1'b0;
data_send = 8'h00;

case (state_reg)
    idle: 
        begin
        state_next = state_reg;
        if (disable_mode == 1'b1)
            begin
                state_next = init1_FF;
            end
        else if (stream_mode == 1'b1)
            begin
                state_next = init1_F4;
            end         
        end   
            
    init1_FF: 
    begin
         wr_psa2 = 1'b1; // enable it to let host sends F4 to the Ps2 device
         state_next = init2_FF;
         data_send = 8'hFF;
    end

    init2_FF: // send FF
    begin
        if (tx_done_tick)
            begin
                state_next = init3_FF;
            end
    end

    init3_FF: // receive FE
    begin
        if (rx_done_tick)
            begin
                state_next = idle;
            end
    end


    init1_F4: 
    begin
         wr_psa2 = 1'b1; // enable it to let host sends F4 to the Ps2 device
         state_next = init2_F4;
         data_send = 8'hF4;
    end

    init2_F4: // send F4
    begin
        if (tx_done_tick)
            begin
                state_next = init3_F4;
            end
    end

    init3_F4: // receive FE
    begin
        if (rx_done_tick)
            begin
                state_next = packet1;
            end
    end




    packet1:
    begin
        if (disable_mode == 1'b1)
        begin
            state_next = init1_FF;
        end
        else if (rx_done_tick)
        begin
            xVal_next[8] = data_out[4];
            yVal_next[8] = data_out[5];
            botton_next  = data_out[2:0];
            state_next = packet2;
        end
    end
    
    packet2:
    begin
        if (disable_mode == 1'b1)
        begin
            state_next = init1_FF;
        end
        else if (rx_done_tick)
        begin
            xVal_next[7:0] = data_out;
            state_next = packet3;
        end
    end

    packet3:
    begin
        if (disable_mode == 1'b1)
        begin
            state_next = init1_FF;
        end
        else if (rx_done_tick)
        begin
            yVal_next[7:0] = data_out;
            state_next = done;
        end
    end    

    done:
    begin
        if (disable_mode == 1'b1)
        begin
            state_next = init1_FF;
        end
        else
        begin
            done_tick = 1'b1;
            state_next = packet1; // send next info of the mouse
        end
    end  
          
endcase    
end

assign xVal = xVal_reg;
assign yVal = yVal_reg;
assign botton = botton_reg;


        
endmodule
