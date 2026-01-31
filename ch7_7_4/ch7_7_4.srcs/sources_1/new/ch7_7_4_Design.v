//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2026 11:56:21 PM
// Design Name: 
// Module Name: ch7_7_4_Design
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


module ch7_7_4_Design(
input wire clk, reset, start,
input wire [4:0] i,
output wire [19:0] fib_out,
output wire done_tick, ready
    );

// state register: 00: idle, 01: op, 10: done
reg [1:0] state_reg; 
localparam [1:0] idle = 2'b00,
                 op   = 2'b01,
                 done = 2'b10; 
// fib(i-1) and fib(i-2)
reg [19:0] fib_0, fib_1;
// input
reg [4:0] i_reg;

//reg ready_reg, done_tick_reg;

always @(posedge clk, posedge reset)
begin
if (reset == 1'b1)
    begin
        state_reg <= idle; // state register
        fib_0 <= {20{1'b0}};  // data register
        fib_1 <= {{19{1'b0}},1'b1};
        i_reg <= i;
    end 
else 
    begin
        case (state_reg)
            idle:
            begin
                //ready_reg = 1'b1;
                if (start == 1'b1)
                    begin
                        state_reg <= op;
                        fib_0 <= {20{1'b0}}; 
                        fib_1 <= {{19{1'b0}},1'b1};
                        i_reg <= i;                    
                     end
                 else 
                    begin
                        state_reg <= idle;
                    end                   
             end
             op:
             begin
                if (i_reg == 5'b00000)
                    begin
                        fib_1 <= {20{1'b0}};
                        state_reg <= done;
                    end
                else if (i_reg == 5'b00001)
                    begin
                         state_reg <= done;
                    end
                else 
                    begin
                    state_reg <= op;
                    fib_1 <= fib_1 + fib_0;
                    fib_0 <= fib_1;
                    i_reg <= i_reg -1'b1;
                    end           
             end
            
             done:
             begin
                 state_reg <= idle;
                 //done_tick_reg = 1'b1;     
             end     
       endcase
    
    end

end
assign fib_out = fib_1;
assign done_tick = (state_reg == done);
assign ready = (state_reg ==idle);    
    
endmodule
