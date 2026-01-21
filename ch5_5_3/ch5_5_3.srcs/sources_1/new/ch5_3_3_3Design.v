//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 06:58:21 PM
// Design Name: 
// Module Name: ch5_5_3Design
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


module ch5_5_3_3Design(
input wire a,b,
output reg [15:0] counter,
input clk, reset
    );

// symbolic state declaration
localparam       no_block       = 3'b000,
                 a_enter_block  = 3'b001,
                 b_enter_block  = 3'b010,
                 ab_enter_block = 3'b011,
                 a_exit_block   = 3'b101,
                 b_exit_block   = 3'b110,
                 ab_exit_block  = 3'b111;
//reg test;              
// signal declaration
reg [2:0] state_reg, state_next;
reg [15:0] counter_next;
always @(posedge clk, posedge reset)   
    if (reset == 1'b1)
        begin
            state_reg <=3'b000;
            counter <= 1'b0;
        end 
     else 
        begin
            state_reg <= state_next;
            counter <= counter_next;
        end
        
        
        
// next state logic and output logic
// this is mealy style. For Moore style, two new states for enter and exit, like enter_state and exit_state. Outputs become one when we are in these two states.  
always @(*)
    begin
      // we asume no transition from no_block state to ab_block state. 
        state_next = state_reg; // initial 
        counter_next = counter; 
        case (state_reg)
            no_block: 
        //ba = 01 → go to A_BLOCKED
        //ba = 10 → go to B_BLOCKED
        //ba = 00 → stay in IDLE
        //ba = 11 → stay in IDLE (ignore)
        // we have to cover all possible inputs, even if physically is not possible, like going to 11 from 00.
                if ({b,a} == 2'b00)
                    begin
                        state_next = no_block;
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = a_enter_block;
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = b_exit_block;
                        //test = 1'b0;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = state_reg;
                    end
                    
                    
        // enter
            a_enter_block:
        //ba = 01 → stay in IDLE
        //ba = 10 → stay in IDLE (ignore) 
        //ba = 00 → go to no_BLOCKED
        //ba = 11 → go to AB_BLOCKED
                 if ({b,a} == 2'b00)
                    begin
                        state_next = no_block;
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = state_reg;
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = state_reg;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = ab_enter_block;
                    end                  
             ab_enter_block:
                 if ({b,a} == 2'b00)
                    begin
                        state_next = state_reg;         
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = a_enter_block;
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = b_enter_block;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = state_reg;
                    end             
            b_enter_block:
                 if ({b,a} == 2'b00)
                    begin
                        state_next = no_block;
                        counter_next = counter + 3'b111; //  correct: counter_next = counter + 1'b1; for testing on circuit, I add to 7.
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = state_reg; // ignore
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = state_reg;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = ab_enter_block;
                    end      
                    
                    
                          
            // exit     
            b_exit_block: 
                if ({b,a} == 2'b00)
                    begin
                        state_next = no_block;
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = state_reg; // ignore
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = state_reg;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = ab_exit_block;
                    end                  
            ab_exit_block: 
                if ({b,a} == 2'b00)
                    begin
                        state_next = state_reg; // ignore
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = a_exit_block; 
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = b_exit_block;
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = state_reg;
                    end         
            a_exit_block: 
                if ({b,a} == 2'b00)
                    begin
                        state_next = no_block;
                        counter_next = counter - 1'b1;
                    end
                else if ({b,a} == 2'b01)
                    begin
                        state_next = state_reg; 
                    end
               else if ({b,a} == 2'b10)
                    begin 
                        state_next = state_reg; // ignore
                    end
               else if ({b,a} == 2'b11)
                    begin 
                        state_next = ab_exit_block;
                    end  
            default: state_next = state_reg;
        endcase
    end
    


endmodule
