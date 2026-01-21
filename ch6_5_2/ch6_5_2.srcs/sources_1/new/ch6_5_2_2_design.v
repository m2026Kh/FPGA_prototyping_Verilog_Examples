`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 04:08:00 PM
// Design Name: 
// Module Name: ch6_5_2_2_design
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


// algortihm: 
// 1. Shift the entire BCD register right one position and shift in the LSB of the BCD register to the MSB of the input binary
// 2. For each 4-bit BCD digit in a BCD shift register, check whether the digit is greater than 4. If this is the case, subtract 3 from the digit.
// 3. Repeat steps 1 and 2 until all input bits are used.

module ch6_5_2_2_design(
input wire [7:0] BCD_in,
input wire clk, reset,
input wire start,
output wire [6:0] binary_out,
output reg done_tick, ready
    );

// states
localparam [1:0] idle = 2'b00,
                 op   = 2'b01,
                 done = 2'b10;
                 
localparam [2:0] zero  = 3'b000,
                 seven = 3'b111;


reg [2:0] counter_reg;
wire [2:0] counter_next;
reg counter_start, counter_done, counter_dec;
assign counter_next = (counter_start) ? seven : 
                      (counter_done)  ? zero : 
                      (counter_dec)   ? counter_reg - 1'b1 : 
                                        counter_reg;
                      

reg [1:0] state_reg, state_next;

// _next will take care of shift. _tmp will take care of subtraction
reg [3:0] BCD_1_reg, BCD_0_reg;
wire [3:0] BCD_1_next, BCD_0_next;
reg [3:0] BCD_1_tmp, BCD_0_tmp;

//reg start_tick;
assign BCD_1_next = (start) ? BCD_in[7:4] : 
                    ( BCD_1_tmp > 3'b100) ?  BCD_1_tmp - 2'b11 : BCD_1_tmp;
assign BCD_0_next = (start) ? BCD_in[3:0] : 
                    ( BCD_0_tmp > 3'b100) ?  BCD_0_tmp - 2'b11 : BCD_0_tmp;

// output reg
reg [6:0] b_out_reg, b_out_next;
assign binary_out = b_out_reg;


always @(posedge clk, posedge reset)
    begin
        if (reset)  
            begin
                state_reg <= idle;
                counter_reg <= seven;
                BCD_1_reg <= BCD_in[7:4];
                BCD_0_reg <= BCD_in[3:0];
                b_out_reg <= {6{1'b0}};
            end
          else
            begin
                state_reg <= state_next;
                counter_reg <= counter_next;
                BCD_1_reg <= BCD_1_next;
                BCD_0_reg <= BCD_0_next;
                b_out_reg <= b_out_next;
            end
     end

always @(*)
    begin    
        state_next = state_reg;
        counter_start = 1'b0;
        counter_done  = 1'b0;
        counter_dec   = 1'b0;
        
        BCD_1_tmp = BCD_1_reg;
        BCD_0_tmp = BCD_0_reg;
        
        b_out_next = b_out_reg;
        
        //start_tick = 1'b0;
        done_tick = 1'b0;
       
        case(state_reg)
            idle:
                begin
                ready = 1'b1;
                    if (start) 
                        begin
                            state_next = op;
                            counter_start = 1'b1;
                            //start_tick = 1'b1;
                        end
                end
                
            op:
                begin
                    counter_dec = 1'b1;
                    if (counter_reg == 1'b0)
                        begin
                            state_next = done;
                        end  
                    else 
                        begin
                            b_out_next = {BCD_0_reg[0], b_out_reg[6:1]};
                            BCD_1_tmp = BCD_1_reg >> 1;    
                            BCD_0_tmp = {BCD_1_reg[0],BCD_0_reg[3:1]};
                        end
                       
                end
           
           done:  
                begin
                    counter_done = 1'b1;
                    done_tick    = 1'b1;
                    state_next   = idle;
                end
        endcase
    end
    



endmodule
