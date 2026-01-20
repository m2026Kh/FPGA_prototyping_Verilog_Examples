`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2025 12:36:08 PM
// Design Name: 
// Module Name: ch4_7_7_Sim
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


module ch4_7_7_Sim;
localparam W = 4;
localparam B = 8;
localparam T = 2;
reg pop, push;
reg [B-1:0] push_word;
reg clk, reset;
wire [B-1:0] pop_word;
wire full, empty;
//reg [B-1:0] stack_Array [2**W-1:0]; // stack 


ch4_7_7Design uut (.pop(pop), .push(push), .push_word(push_word), .clk(clk), .reset(reset), .pop_word(pop_word), .full(full), .empty(empty));

always 
 begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
 end
 
 initial
    begin 
        pop = 1'b0;
        push = 1'b0;
        push_word = 8'b00000000;
        reset = 1'b0;
        #(T)
        $stop;
        pop = 1'b0;
        push = 1'b0;        
        reset = 1'b1;
        #(T)
        $stop;
        reset = 1'b0;
        push = 1'b1; 
        push_word = 8'b00000001;
        #(T)
        $stop;
        push_word = 8'b00000011;
        //#(2*T) if you have 2T, then it it will write 3 (8'b00000011) in two consecutive arrays, as push is enabled for two clocks. 
        #(T)
        $stop;
        push_word = 8'b00000111;
        #(T)
        $stop;
        pop = 1'b1;
        push = 1'b0; 
        #(2*T)
        $stop;
        pop = 1'b1;
        push = 1'b0; 
        #(T)
        $stop;
        pop = 1'b0;
        push = 1'b1;   
        push_word = 8'b00001111;
        #(T)
        $stop;
        push_word = 8'b00011111;
        #(T)
        $stop;
        pop = 1'b1;
        push = 1'b1;   
        push_word = 8'b00111111;
        #(T)
        $stop;
        pop = 1'b0;
        push = 1'b1;   
        push_word = 8'b10000001;
        #(T)
        $stop;
        push_word = 8'b10000011;
        #(T)
        $stop;        
        push_word = 8'b10000001;
        #(T)
        $stop;
        push_word = 8'b10000010;
        #(T)
        $stop;
        push_word = 8'b10000011;
        #(T)
        $stop;
        push_word = 8'b10000100;
        #(T)
        $stop;
        push_word = 8'b10000101;
        #(T)
        $stop;
        push_word = 8'b10000110;
        #(T)
        $stop;
        push_word = 8'b10000111;
        #(T)
        $stop;
        push_word = 8'b10001000;
        #(T)
        $stop;
        push_word = 8'b10001001;
        #(T)
        $stop;
        push_word = 8'b10001010;
        #(T)
        $stop;    
        push_word = 8'b10001011;
        #(T)
        $stop;
        push_word = 8'b10001101;
        #(T)
        $stop;
        push_word = 8'b10001001;
        #(T)
        $stop;
        push_word = 8'b10101001;
        #(T)
        $stop;
        push_word = 8'b11101001;
        #(T)
        $stop;        
        push_word = 8'b11111001;
        #(T)
        $stop;          
    end
endmodule
