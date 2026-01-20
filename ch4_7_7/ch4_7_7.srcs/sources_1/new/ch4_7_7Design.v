//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2025 04:11:40 PM
// Design Name: 
// Module Name: ch4_7_7Design
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


module ch4_7_7Design
#(parameter W = 4, // each word has 8 bits 
  parameter B = 8 // number of address bits, i.e. 2^4 words can be stored in stack
)
(
input wire pop, push,
input wire [B-1:0] push_word,
input wire clk, reset,
output reg [B-1:0] pop_word,
output wire full, empty
//input reg [B-1:0] stack_Array [2**B-1:0]; // stack 
    );

reg [B-1:0] stack_Array [2**W-1:0]; // stack    
reg [W-1:0] pop_curr_add, push_curr_add;
reg [W-1:0] pop_next_add, push_next_add;


// registers
always @(posedge clk, posedge reset)
    begin
        if (reset == 1'b1)
            begin
                pop_curr_add <= 0;
                push_curr_add <= 0;
            end
        else
            begin
                pop_curr_add <=  pop_next_add;
                push_curr_add <= push_next_add;
            end   
    end

// next state
assign full = (push_curr_add == 4'b1111) ? 1'b1: 1'b0;
assign empty = (pop_curr_add == 0) ? 1'b1: 1'b0; 

always @(*)
    begin
        push_next_add = push_curr_add;
        pop_next_add = pop_curr_add;
        case ({push, pop})
            2'b00: // nothing
                begin
                    push_next_add = push_curr_add;
                    pop_next_add = pop_curr_add;
                end
            2'b10: // push
                begin
                    if (full == 1'b0)
                        begin
                            push_next_add = push_curr_add + 1;
                            pop_next_add = push_curr_add + 1;
                        end 
                end
            2'b01: // pop
                begin
                    if (empty == 1'b0)
                        begin
                            push_next_add = pop_curr_add - 1;
                            pop_next_add = pop_curr_add - 1;
                        end    
                end      
            2'b11: // push and pop at the same time -- this case can be removed, as we initialized them at the begining. But, let's have it for clarity
                begin
                    push_next_add = push_curr_add;
                    pop_next_add = pop_curr_add;  
                end 
        endcase            
    end
    
always @(posedge clk) 
    begin
        if (full == 1'b0 && push == 1'b1)
            begin
                stack_Array[push_curr_add] <= push_word;
            end
        if (empty == 1'b0 && pop == 1'b1)
            begin
                pop_word <=  stack_Array[pop_curr_add];
            end
    end
endmodule
