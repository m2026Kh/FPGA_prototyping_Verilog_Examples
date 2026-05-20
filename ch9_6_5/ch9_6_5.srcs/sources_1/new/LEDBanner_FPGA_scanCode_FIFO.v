`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2026 09:25:29 PM
// Design Name: 
// Module Name: LEDBanner_FPGA_scanCode_FIFO
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


module LEDBanner_FPGA_scanCode_FIFO
#(
    parameter B=8,  // FIFO - number of bits in a word
              W=4,   // FIFO - number of address bits
              digit_width = 10,  // digit width - each digit is shown by 4 bits
              n_bit = 4,  // log2(digit_width)
              num_bit_counter = 28,     //number of bits in counter
              M=200000000 // mod-M
)
(
input wire rx_en, clk, reset,   
input wire ps2c,
input wire ps2d,
input wire [(4*digit_width)-1:0] input_num,
output wire [15:0] output_num
);

wire rd_ps2, empty, rd_ps22;
wire [B-1:0] r_data_ps2;
reg [B-1:0] r_data_ps2_next, r_data_ps2_reg;

reg [(4*digit_width)-1:0] input_num_modified;

assign rd_ps2 = ~empty;

FPGA_codeScan_FIFO #(.B(B), .W(W)) FPGA_codeScan_FIFO_unit(.rx_en(rx_en), .clk(clk), .reset(reset), 
.ps2d(ps2d), .ps2c(ps2c), .rd_ps2(rd_ps2), .empty(empty), .r_data_ps2(r_data_ps2));


reg en, dir;

ch4_7_5_design #(.digit_width(digit_width), .num_bit_counter(num_bit_counter), .M(M), .n_bit(n_bit)) LedBanner(.clk(clk),
 .reset(reset), .input_num(input_num_modified), .output_num(output_num), .en(en_reg), .dir(dir_reg));


reg en_next, en_reg;
reg dir_next, dir_reg;

// LED banner does not do nything unless one key from keyboard is selcted, i.e. fifo is not empty
reg state_reg, state_next;
localparam no_commincation_yet = 1'b0,
           commincation_started = 1'b1;

always @(posedge clk)
begin
    if (reset)
        begin
        state_reg <= no_commincation_yet;
        //en = 1'b0;
        //dir = 1'b0;
        en_reg <= 1'b0;
        dir_reg <= 1'b0;
        r_data_ps2_reg <= 0;
        end
    else
        begin
        state_reg <= state_next;
        en_reg <= en_next;
        dir_reg <= dir_next;
        r_data_ps2_reg <= r_data_ps2_next;
        end
end 

always @(*)
begin
state_next = state_reg;
dir_next = dir_reg;
input_num_modified = input_num;
case(state_reg)
    no_commincation_yet:
    begin
        en = 1'b0;
        if (rd_ps2)
        begin
            state_next = commincation_started;
            r_data_ps2_next = r_data_ps2;
        end
    end
    
    commincation_started:
begin
en_next = en_reg;
r_data_ps2_next = r_data_ps2;
    case (r_data_ps2_reg)
        8'h34: // G - go
        begin
            en_next = 1'b1;
        end
    
        8'h4d: // P - pasue 
        begin
            en_next = 1'b0;
        end
    
        8'h23: // d - direction 
        begin
            dir_next = ~dir_reg; 
        end
    
        8'h45: // 0 
        begin
            input_num_modified[39:36] = 4'b0000;
           input_num_modified[35:0] = input_num[39:4];  
        end
            
        8'h16: // 1 
        begin
            input_num_modified[39:36] = 4'b0001;
            input_num_modified[35:0] = input_num[39:4];             
        end
               
        8'h1e: // 2  
        begin
           input_num_modified[39:36] = 4'b0010;
            input_num_modified[35:0] = input_num[39:4];             
        end
              
        8'h26: // 3  
         begin
           input_num_modified[39:36] = 4'b0011;
             input_num_modified[35:0] = input_num[39:4];              
        end
             
        8'h25: // 4  
        begin
           input_num_modified[39:36] = 4'b0100;
            input_num_modified[35:0] = input_num[39:4];             
        end
            
        8'h2e: // 5  
        begin
           input_num_modified[39:36] = 4'b0101;
           input_num_modified[35:0] = input_num[39:4];             
        end
                
        8'h36: // 6 
        begin
           input_num_modified[39:36] = 4'b0110;
          input_num_modified[35:0] = input_num[39:4];             
        end
               
        8'h3d: // 7  
        begin
           input_num_modified[39:36]= 4'b0111;
             input_num_modified[35:0] = input_num[39:4];            
        end
            
        8'h3e: // 8 
        begin
           input_num_modified[39:36] = 4'b1000;
           input_num_modified[35:0] = input_num[39:4];             
        end
                       
        8'h46: // 9 
        begin
         input_num_modified[39:36]= 4'b1001;
            input_num_modified[35:0] = input_num[39:4];           
        end
        endcase 
end
endcase
end


    
endmodule
