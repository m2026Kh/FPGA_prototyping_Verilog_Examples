`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2026 11:39:42 AM
// Design Name: 
// Module Name: ch8_7_4_UartDesignTopLEvel
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


module ch8_7_4_UartDesignTopLEvel
#(parameter N_bit = 8, // data bits
            S_count = 16, // 1 stop bit needs 16 ticks.
            baud = 19200, // buad rate 
            divisor = 325, // 16 times faster in Rx -> clk_rate/(16*baud) = 100M/(16*19200)
            divisor_bits = 9, // ceil(divisor) = 9
            fifo_w = 2 // number of words in fifo: 2^(fifo_w), i.e. fifo_w is the number of address bits in fifo
)
(
input wire clk, reset,
input wire rx,
input wire rd_uart,
input wire [N_bit-1:0] w_data,
input wire wr_uart,
output wire tx,
output wire [N_bit-1:0] r_data,
output wire rx_empty,
output wire tx_full
//output wire rx_done_tick // put it here for debugginf puprpose
    ); 
wire tick;
wire [divisor_bits-1:0] q;
wire rx_done_tick;
wire [N_bit-1:0] d_out;
wire tx_done_tick;
wire not_tx_start;
wire [N_bit-1:0] d_in;


counter #(.N(divisor_bits), .M(divisor)) baud_gen_unit(.clk(clk), .reset(reset), .max_tick(tick), .q());   

fifo #(.B(N_bit), .W(fifo_w)) fifo_rx(.clk(clk), .reset(reset),.rd(rd_uart), .wr(rx_done_tick), .w_data(d_out), .empty(rx_empty), .full(), .r_data(r_data));

ch8_7_4_design_rxReceiver #(.N_bit(N_bit), .S_count(S_count)) rxRec(.clk(clk), .reset(reset), .tick(tick), .rx(rx), .d_out(d_out), .rx_done_tick(rx_done_tick));

fifo #(.B(N_bit), .W(fifo_w)) fifo_tx(.clk(clk), .reset(reset),.rd(tx_done_tick), .wr(wr_uart), .w_data(w_data), .empty(not_tx_start), .full(tx_full), .r_data(d_in));

ch8_7_4_design_txTransmit #(.N_bit(N_bit), .S_count(S_count)) txTransmit (.clk(clk), .reset(reset), .tick(tick), .tx_start(~not_tx_start), .d_in(d_in), .tx_done_tick(tx_done_tick), .tx(tx));


endmodule
