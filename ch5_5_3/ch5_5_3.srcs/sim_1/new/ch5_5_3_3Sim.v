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


module ch5_5_3_3Sim;
reg a,b;
wire [15:0] counter;
reg clk, reset;

ch5_5_3_3Design uut2 (.a(a), .b(b), .counter(counter), .clk(clk), .reset(reset));
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
    end
    

endmodule
