`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2026 11:29:27 AM
// Design Name: 
// Module Name: sevenSegDispThisProblem
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


module sevenSegDispThisProblem
#(
parameter N = 17
)
(
input wire clk, reset,
input wire [6:0] led0, led1, led2, led3,
output reg [6:0] sevenSegDisp,
output reg [3:0] enable
    );
reg [N-1:0] counter_Reg; 
wire [N-1] counter_next;

always @(posedge clk, posedge reset)
    begin
        if (reset == 1'b1)
            begin
                counter_reg = {N{1'b0}};
            end
         else 
            begin
                counter_next <= counter_next; 
            end
    end

assign counter_next = counter_reg + 1'b1;

always @(*)
begin
    case (counter_reg[N-1:N-2])
        2'b00:
            begin
                sevenSegDisp = led0;
                enable = ~(4'b0001);
            end
        2'b01:
            begin
                sevenSegDisp = led1;
                enable = ~(4'b0010);
            end
        2'b10:
            begin
                sevenSegDisp = led2;
                enable = ~(4'b0100);
            end
        default: //this icludes default and also this case: 2'b11:
            begin
                sevenSegDisp = led3;
                enable = ~(4'b1000);
            end    
    endcase
end       

endmodule
