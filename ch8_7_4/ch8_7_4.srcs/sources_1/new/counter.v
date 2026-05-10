`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2026 12:36:05 AM
// Design Name: 
// Module Name: counter
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
// this is from the book, see 4.9, with a small modification


module counter
#(
    parameter N = 4,   // number of bits in counter
              M = 10   // mod-M
)
(
    input  wire clk,
    input  wire reset,
    output wire max_tick,
    output wire [N-1:0] q
);

    // signal declaration
    reg  [N-1:0] r_reg;
    wire [N-1:0] r_next;

    // register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end

    // next-state logic
    assign r_next = (r_reg == (M-1)) ? 0 : r_reg + 1;

    // output logic
    assign q = r_reg;

    assign max_tick = (r_reg == (M-1)) ? 1'b1 : 1'b0;

endmodule