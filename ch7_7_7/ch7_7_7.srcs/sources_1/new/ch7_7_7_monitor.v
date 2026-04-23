`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2026 02:27:40 AM
// Design Name: 
// Module Name: ch7_7_7_monitor
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


module ch7_7_7_monitor
#(parameter B=8, // number of bits in a word
            M=4, // number of address bits
            T = 20
)
(
input wire rd, wr,
input wire [B-1:0] w_data,
input wire clk, reset,
input wire [B-1:0] r_data,
input wire empty, full
    );
    
reg empty_correct, full_correct, empty_correct_reg, full_correct_reg;
reg [M-1:0] w_ptr, r_ptr, tmp, tmp2;
reg [39:0] err_msg; // error message

initial 
    begin
    // assign initial values to reg
    empty_correct  = 1'b1;
    full_correct   = 1'b0;
    tmp            = {M{1'b0}};
    tmp2           = {M{1'b0}};
    w_ptr          = {M{1'b0}};
    r_ptr          = {M{1'b0}};
    $display("time reset empty/empty_correct full/full_Correct \n");
    end

always @(posedge clk)
    // full_Correct and empty_Correct will only change, if {rd,wr} = 2'b10 or 2'b01. Otherwise, they stay as they are in th previous clk edge. 
    begin
    // w_ptr and r_ptr: value sampled at the previous clk edge;
    case ({rd, wr})
        2'b00: //nothing
        begin
            empty_correct = empty_correct_reg;
            full_correct =  full_correct_reg; 
            w_ptr <= w_ptr;
            r_ptr <= r_ptr;
        end
        2'b01: // write
        begin
            if (~full)
                begin
                r_ptr <= r_ptr;
                empty_correct = 1'b0;
                tmp = w_ptr + 1;
                w_ptr <= tmp;
                if (r_ptr == tmp)
                   full_correct = 1'b1;
                else
                    full_correct = 1'b0; 
                end        
        end        
        2'b10: // read
        begin
            if (~empty)
                begin
                w_ptr <= w_ptr;
                full_correct = 1'b0;
                tmp =  r_ptr + 1;
                r_ptr <= tmp;
                if (w_ptr ==  tmp)
                   empty_correct = 1'b1;
                else
                    empty_correct = 1'b0; 
                end        
        end  
        2'b11: // write and read
        begin
            tmp = r_ptr+1;
            tmp2 = w_ptr+1;
            r_ptr <= tmp;
            w_ptr <= tmp2;
            empty_correct = empty_correct_reg;
            full_correct =  full_correct_reg;     
        end 
    endcase 
    empty_correct_reg <= empty_correct;
    full_correct_reg <= full_correct;
    // note that, full_correct and empty_correct, will be updated in the next clk. non-blockin <= assignment 
    
    if ((full_correct_reg == full) & (empty_correct_reg == empty))
        err_msg = " "; // no error
    else
        err_msg = "ERROR"; 
    if (reset)
        $display( "%5d, reset", $time);
    else
    begin
    case ({rd, wr})
        2'b00:
            $display( "%5d, %b, %b%b, %b%b, No read No write %s", $time , reset, empty, empty_correct_reg , full, full_correct_reg, err_msg);
        2'b01: // write  
            $display( "%5d, %b, %b%b, %b%b, Wrtie: %d, %s", $time , reset, empty, empty_correct_reg , full, full_correct_reg, w_data, err_msg);
        2'b10: // read
            $display( "%5d, %b, %b%b, %b%b, Read: %d, %s", $time , reset, empty, empty_correct_reg , full, full_correct_reg, r_data, err_msg);
         2'b11: // write and read
            $display( "%5d, %b, %b%b, %b%b, Wrtie: %d, Read: %d, %s", $time , reset, empty, empty_correct_reg , full, full_correct_reg, w_data, r_data, err_msg);
    endcase 
    end
    end
    
endmodule
