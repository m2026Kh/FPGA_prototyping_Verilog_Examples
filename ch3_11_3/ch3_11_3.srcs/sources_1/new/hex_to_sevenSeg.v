`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2026 01:05:32 AM
// Design Name: 
// Module Name: hex_to_sevenSeg
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


module hex_to_sevenSeg(
input wire [3:0] hex,
input wire dp,
output reg [7:0] sevenSeg
    );
    
always @(*)
begin
case (hex)
     4'h0: sevenSeg[6:0] = 7'b0000001; 
     4'h1: sevenSeg[6:0] = 7'b1001111;
     4'h2: sevenSeg[6:0] = 7'b0010010; 
     4'h3: sevenSeg[6:0] = 7'b0000110;     
     4'h4: sevenSeg[6:0] = 7'b1001100; 
     4'h5: sevenSeg[6:0] = 7'b0100100; 
     4'h6: sevenSeg[6:0] = 7'b0100000;
     4'h7: sevenSeg[6:0] = 7'b0001111;
     4'h8: sevenSeg[6:0] = 7'b0000000; 
     4'h9: sevenSeg[6:0] = 7'b0000100 ;
     4'ha: sevenSeg[6:0] = 7'b0001000;
     4'hb: sevenSeg[6:0] = 7'b1100000;    
     4'hc: sevenSeg[6:0] = 7'b0110001;
     4'hd: sevenSeg[6:0] = 7'b1000010;
     4'he: sevenSeg[6:0] = 7'b0110000;
     4'hf: sevenSeg[6:0] = 7'b0111000;
     default: sevenSeg[6:0] = 7'b0000000;

endcase 
sevenSeg[7] = dp;
end    
    
endmodule
