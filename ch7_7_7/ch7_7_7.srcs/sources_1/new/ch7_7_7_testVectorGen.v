//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2026 01:24:26 AM
// Design Name: 
// Module Name: ch7_7_7_testVectorGen
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


module ch7_7_7_testVectorGen
#(parameter B=8, // number of bits in a word
            M=4, // number of address bits
            T = 20
)
(
output reg rd, wr,
output reg [B-1:0] w_data,
output reg clk, reset
    );

// clk gen
always 
    begin
    clk = 1'b0;
    #(T/2);
    clk = 1'b1;
    #(T/2);
    end


// test procedure 
initial 
    begin
    initialize();
    write_task({B{1'b1}});
    write_task(8'b11111111);
    write_task({{B/2{1'b1}},{B/2{1'b0}}});
    //read_task();
    write_task({{B/2{1'b0}},{B/2{1'b1}}});
    write_task({{3*B/4{1'b0}},{B/4{1'b0}}});
    doNothing_task();
    write_task({{B/2{1'b1}},{B/2{1'b1}}}); // write full
    doNothing_task();
    doNothing_task();
    read_task();
    read_task();
    read_task();
    read_task(); // empty
    write_task({{B/8{1'b1}},{7*B/8{1'b0}}});
    write_task({{B/4{1'b1}},{3*B/4{1'b0}}});
    wrtie_read_task({{B/2{1'b1}},{B/2{1'b0}}});   
    reset_task(); // reset 
    $stop;
    end
  
// define Tasks 
task initialize();
    begin
        rd = 1'b0;
        wr = 1'b0;
        w_data = {B{1'b0}}; 
        reset_task();       
    end
endtask

task reset_task();
    begin
    @(negedge clk);
    reset = 1'b1;
    @(negedge clk);
    reset = 1'b0;
    end
endtask

task read_task();
    begin
    @(negedge clk);
    rd = 1'b1; 
    wr = 1'b0;
    //@(negedge clk);
    end  
endtask

task doNothing_task();
    begin
    @(negedge clk);
    rd = 1'b0; 
    wr = 1'b0;
    //(negedge clk);
    end  
endtask

task write_task(input reg [B-1:0] w_data_val);
    begin
    @(negedge clk);
    rd = 1'b0; 
    wr = 1'b1;
    w_data = w_data_val;
    //@(negedge clk);
    end
 endtask
  
task wrtie_read_task(input reg [B-1:0] w_data_val);
    begin
    @(negedge clk);
    rd = 1'b1; 
    wr = 1'b1;
    w_data = w_data_val;
    //(negedge clk);
    end
 endtask 

endmodule
