`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2025 02:24:38 AM
// Design Name: 
// Module Name: ch5_5_3_Sim
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


module ch5_5_3_Sim;
reg a,b;
wire enter, exit;
reg clk, reset;

ch5_5_3Design uut (.a(a), .b(b), .enter(enter), .exit(exit), .clk(clk), .reset(reset));
localparam T = 2;

always 
    begin
        clk = 0;
        #(T/2);
        clk = 1;
        #(T/2);
    end

initial 
    begin
        $stop;
        a = 1'b0;
        b = 1'b0;
        reset = 1'b0;
        // reset 
        #(T);
        reset = 1'b1;
        #(T);
        reset = 1'b0;
        #(T);
        // enter
        a = 1'b0;
        b = 1'b0;
        #(T);
        a = 1'b1;
        b = 1'b0;
        #(T);
        a = 1'b1;
        b = 1'b1; 
        #(T);
        a = 1'b0;
        b = 1'b1;                    
        #(T);
        a = 1'b0;
        b = 1'b0;  
        #(3*T);
        $stop;
        
        // exit
        a = 1'b0;
        b = 1'b0; 
        #(T);
        a = 1'b0;
        b = 1'b1;
        #(T);
        a = 1'b1;
        b = 1'b1; 
        #(T);
        a = 1'b1;
        b = 1'b0;  
        #(T);
        a = 1'b0;
        b = 1'b0; 
        #(3*T);
        $stop;
        
        // another enter   
        a = 1'b0;
        b = 1'b0;
        #(T);       
        a = 1'b1;
        b = 1'b0;
        #(T);
        a = 1'b1;
        b = 1'b0;
        #(T);
        a = 1'b0;
        b = 1'b0;
        #(T);       
        a = 1'b1;
        b = 1'b0;
        #(T);
        a = 1'b1;
        b = 1'b1; 
        #(T);
        a = 1'b0;
        b = 1'b1;                    
        #(T);
        a = 1'b0;
        b = 1'b1;                    
        #(T);
        a = 1'b0;
        b = 1'b0;  
        #(3*T);
        $stop;
        
        // another exit
        a = 1'b0;
        b = 1'b0; 
        #(T);
        a = 1'b0;
        b = 1'b1;
        #(T);
        a = 1'b0;
        b = 1'b0; 
        #(T);
        a = 1'b0;
        b = 1'b1;
        #(T);
        a = 1'b0;
        b = 1'b1;
        #(T);       
        a = 1'b1;
        b = 1'b1; 
        #(T);
        a = 1'b1;
        b = 1'b0;  
        #(T);
        a = 1'b1;
        b = 1'b1; 
        #(T);
        a = 1'b1;
        b = 1'b0;  
        #(T);
        a = 1'b0;
        b = 1'b0; 
        #(3*T);
        $stop;
    end
    

endmodule
