//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2025 02:41:11 AM
// Design Name: 
// Module Name: ch4_7_6_Design
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


module ch4_7_6_Design
#( parameter N = 24, // N=23 , max_C = 500 for simulation
   parameter max_C = 10000000 //10000000
)
(
output wire [3:0] d1, d2, d3,
input wire clk, clr, go, //
input wire up
// output wire [3:0] d1_d_next, d2_d_next, d3_d_next,   // for debugging
// output wire [N-1:0] counter_curr_w // for debugging
    );
// define registers
reg [3:0] d1_reg, d2_reg, d3_reg;
wire [3:0] d1_next, d2_next, d3_next;
reg [N-1:0] counter_curr, counter_next;
reg next_digit_enabled;


// registers 
always @(posedge clk)
    begin
        counter_curr <= counter_next;
        d1_reg <= d1_next;
        d2_reg <= d2_next;
        d3_reg <= d3_next;
    end

// next state for counter
always @(*)
   begin 
        next_digit_enabled = 1'b0;
        if (go == 1'b0)
            begin
                counter_next = counter_curr;
            end
        else 
           begin
            if (counter_curr != max_C)
                begin
                    counter_next = counter_curr+1'b1;
                end
           else if (counter_curr == max_C)
                begin
                    counter_next = 0;
                    next_digit_enabled = 1'b1;
                end
           else // taking care of when counter_curr is x/z.
                begin
                    counter_next = 0;
                end
           end
   end

// next state for d1,d2,d3 
assign d1_next = (clr == 1'b1) ? 4'b0000: 
                 (next_digit_enabled == 1'b0) ? d1_reg : 
                 (up == 1'b1 && d1_reg == 4'b1001)? 4'b0000 :
                 (up == 1'b1 && d1_reg != 4'b1001)? d1_reg + 1'b1 :
                 (up == 1'b0 && d1_reg != 4'b0000)? d1_reg - 1'b1 : 
                                                    4'b1001;
                 

assign d2_next = (clr == 1'b1) ? 4'b0000: 
                 (next_digit_enabled == 1'b0) ? d2_reg : 
                 (up == 1'b1 && d1_reg != 4'b1001) ? d2_reg: 
                 (up == 1'b1 && d1_reg == 4'b1001 && d2_reg != 4'b1001) ? d2_reg + 1'b1 : 
                 (up == 1'b1 && d1_reg == 4'b1001 && d2_reg == 4'b1001) ? 4'b0000 : 
                 (up == 1'b0 && d1_reg != 4'b0000) ? d2_reg: 
                 (up == 1'b0 && d1_reg == 4'b0000 && d2_reg != 4'b0000) ? d2_reg - 1'b1 : 
                                                                         4'b1001;                
                               
assign d3_next = (clr == 1'b1) ? 4'b0000: 
                 (next_digit_enabled == 1'b0) ? d3_reg :                 
                 (up == 1'b1 && (d1_reg != 4'b1001 || d2_reg != 4'b1001)) ? d3_reg: 
                 (up == 1'b1 && (d1_reg == 4'b1001 && d2_reg == 4'b1001) && d3_reg != 4'b1001) ? d3_reg + 1'b1 : 
                 (up == 1'b1 && (d1_reg == 4'b1001 && d2_reg == 4'b1001) && d3_reg == 4'b1001) ? 4'b0000 : 
                 (up == 1'b0 && (d1_reg != 4'b0000 || d2_reg != 4'b0000)) ? d3_reg:  
                 (up == 1'b0 && (d1_reg == 4'b0000 && d2_reg == 4'b0000) && d3_reg != 4'b0000 ) ? d3_reg - 1'b1 : 
                                                                                                4'b1001;    
assign d1 = d1_reg;
assign d2 = d2_reg;               
assign d3 = d3_reg;

//assign d1_d_next = d1_next;
//assign d2_d_next = d2_next;
//assign d3_d_next = d3_next;

//assign counter_curr_w = counter_curr;



endmodule
