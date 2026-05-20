`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2026 02:25:44 PM
// Design Name: 
// Module Name: ch9_6_5_testBench
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


module ch9_6_5_testBench;

localparam    B=8,  
              W=4,  
              digit_width = 10, 
              n_bit = 4, 
              num_bit_counter = 28,    
              //M=200000000; 
              M=500;
              
localparam T = 2;

reg clk;
reg ps2c;
reg ps2d;
reg retest; 
reg rx_en;
reg reset;

reg [(4*digit_width)-1:0] input_num;
wire [15:0] output_num;


always 
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end

LEDBanner_FPGA_scanCode_FIFO #(.B(B), .W(W), .digit_width(digit_width),  .n_bit(n_bit),  .num_bit_counter(num_bit_counter), .M(M)) designUnit(
.rx_en(rx_en), .clk(clk), .reset(reset), .ps2c(ps2c), .ps2d(ps2d), .input_num(input_num), .output_num(output_num));

task ps2c_gn;
begin
    #50 ps2c = 1'b0;
    #50 ps2c = 1'b1;
end
endtask


task send_ps2_byte;

input [7:0] data;

integer i;
reg parity;

begin

    parity = 1'b1;
    
    // start bit   
    ps2d = 1'b0;
    ps2c_gn();

    
    // data bits (LSB first
    for(i=0; i<8; i=i+1)
    begin
        ps2d = data[i];
        parity = parity ^ data[i];
        ps2c_gn();
    end

    
    // parity bit
    ps2d = parity;
    ps2c_gn();

    
    // stop bit
    ps2d = 1'b1;
    ps2c_gn();

end
endtask




initial 
begin
     input_num = {4'h0,4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8,4'h9};
reset = 1'b1;
ps2c = 1'b1;
ps2d = 1'b1;
rx_en = 1'b0;
#(20*T);
reset = 1'b0;
#(20*T);
rx_en = 1'b1;

    // input_num = {4'h0,4'h1,4'h2,4'h3,4'h4,4'h5,4'h6,4'h7,4'h8,4'h9};
    
  
//          send_ps2_byte(8'hf0);

//    #(500);
//     send_ps2_byte(8'h26);

//    #(1001);
    
    
    
         
     send_ps2_byte(8'hf0);

    #(200);

    send_ps2_byte(8'h34);

    #(1001);
    

    send_ps2_byte(8'hf0);

    #(1);
     send_ps2_byte(8'h4d);

    #(5000);
    
         send_ps2_byte(8'hf0);

    #(5000);

    send_ps2_byte(8'h34);

    #(5001);
    
   // send_ps2_byte(8'h1C);
   // #(500);

   // send_ps2_byte(8'h45);
   // #(1000);

    $stop;




end



endmodule
