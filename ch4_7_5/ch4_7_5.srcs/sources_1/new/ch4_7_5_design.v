`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 11:29:52 PM
// Design Name: 
// Module Name: ch4_7_5_design
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


module ch4_7_5_design
#(parameter digit_width = 10,  // digit width - each digit is shown by 4 bits
            num_bit_counter = 28,     //number of bits in counter
            M=200000000, // mod-M
            n_bit = 4  // log2(bit_width)
)
(
input wire clk, reset,
input wire [(4*digit_width)-1:0] input_num,
output wire [15:0] output_num, // 4 digits, each has 4 bits. BCD format
input wire en, dir
    );

wire tick; 
localparam bit_width  = 4*digit_width;
    
counter #(.M(M),.N(num_bit_counter)) counterU(.clk(clk), .reset(reset), .q(), .max_tick(tick)); // see ch8.7.4 for a counter module code

reg [n_bit-1:0] n_reg, n_next;
reg [(4*digit_width)-1:0] out_reg, out_next;

always @(posedge clk)
    if (reset)
        begin
            n_reg <= 0;
            out_reg <=input_num;
        end
    else 
        begin
            n_reg <= n_next;
            out_reg <= out_next;
        end


always @(*)
begin

out_next = out_reg;
n_next = n_reg;
case ({en, dir, tick})
// 3'b0xx, 3'bxx0:
//    begin
//        out_next = out_reg;
//        n_next = n_reg;
//    end
    3'b111: // left rotate
    if (n_reg < digit_width)
        begin
            out_next = {out_reg[bit_width-5:0],out_reg[bit_width-1:bit_width-4]};
            n_next = n_reg + 1;
        end
//     else 
//        begin
//            out_next = out_reg;
//            n_next = n_reg;
//        end
    3'b101: // right rotate
    if (n_reg < digit_width)
        begin
            out_next = {out_reg[3:0], out_reg[bit_width-1:4]};
            n_next = n_reg + 1;
        end
//     else 
//        begin
//            out_next = out_reg;
//            n_next = n_reg;
//        end
endcase

end
    
assign output_num = out_reg[bit_width-1:bit_width-16];
    
endmodule
