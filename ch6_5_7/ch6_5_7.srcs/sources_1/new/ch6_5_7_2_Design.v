//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 06:17:14 PM
// Design Name: 
// Module Name: ch6_5_7_2_Design
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


module ch6_5_7_2_Design
#( parameter N = 12,
             M = 6  // ceil(log2(63)) = 6 
)
(
input wire [M-1:0] n,
input wire clk, reset,
input wire start,
output wire done_tick,
output wire [12:0] fn
// I need 13 bits for the output
// a = 2*(63*63) + 3*(63) + 5 = 8132
// log2(a) = 12.989
);

reg done_tick_reg;
// 4 states: idle, gn, fn, done
localparam [1:0] idle  = 2'b00,
                 gnCal = 2'b01,
                 fnCal = 2'b10,
                 done  = 2'b11;

reg [1:0] state_reg, state_next;
                 
// track of f(n-1), f(n), g(n-1), g(n)
reg [12:0] fn_reg, fn_next, gn_reg, gn_next;

reg load, noChange, increase;
// n = 0,1,2,3,..., onput_n
reg  [M-1:0] n_counter_reg;
wire [M-1:0] n_counter_next;
assign n_counter_next = (load)     ? {N{1'b0}} : 
                        (noChange) ? n_counter_reg :
                        (increase) ? n_counter_reg+1 :
                                     n_counter_reg;

// FSMD state
always @(posedge clk, posedge reset)
    begin
        if (reset)
            begin
               fn_reg        <= {N{1'b0}};
               gn_reg        <= {N{1'b0}};
               n_counter_reg <= {M{1'b0}};
               state_reg     <= 2'b00;
            end
        else
            begin
               fn_reg        <= fn_next;
               gn_reg        <= gn_next;   
               n_counter_reg <= n_counter_next;
               state_reg     <= state_next;
            end            
    end
  
assign fn = fn_reg;

// data path and next-state with combanitional  
always @(*)
    begin
        // initial values
        fn_next        = fn_reg;
        gn_next        = gn_reg;
        state_next     = state_reg;
        //n_counter_next = n_counter_reg;
        
        load     = 1'b0;
        noChange = 1'b0;
        increase = 1'b0;
        
        done_tick_reg = 1'b0;
        
        case(state_reg)
            idle: 
                begin
                    if (start)
                        begin
                           state_next = gnCal;
                           load = 1'b1;
                        end  
                end
           gnCal: 
                begin
                    noChange = 1'b1;
                    state_next = fnCal;
                    if (n_counter_reg == 1'b0)
                        begin
                            gn_next = 1'b0;
                        end
                    else if (n_counter_reg == 1'b1)
                         begin
                            gn_next = 3'b101;
                        end
                    else 
                        begin
                            gn_next = gn_reg + 3'b100;
                        end                        
                end
              fnCal:
                begin
                    //increase = 1'b1;
                    if (n_counter_reg > n)
                        begin
                        // in case you want have "done" state
                            //state_next = done;
                            
                        // in case you dont want to have "done" state
                            noChange = 1'b1;
                            done_tick_reg = 1'b1;
                            state_next = idle;
                        end
                    else 
                        begin
                            //if (n_counter_reg < n)
                            increase = 1'b1;  
                                         
                            state_next = gnCal;
                            if (n_counter_reg == 1'b0)
                                 begin
                                    fn_next = 3'b101;
                                end
                            else 
                                begin
                                    fn_next = fn_reg + gn_next; // check this: I think gn_next equlas gn_reg at this poit. It is not the case when state is gn_cal
                                end         
                          end             
                end
             done:
                begin
                    noChange = 1'b1;
                    done_tick_reg = 1'b1;
                    state_next = idle;
                end
            endcase        
    end

endmodule
