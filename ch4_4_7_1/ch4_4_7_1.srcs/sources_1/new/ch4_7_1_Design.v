// 'timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2025 02:54:55 PM
// Design Name: 
// Module Name: ch4_7_1_Design
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


module ch4_7_1_Design
#(parameter N = 4)
(
// The circuit should be completely synchronous. So, 
// async reset for power-up reasons, but release reset on a clock edge
input  wire clk, reset,
input wire [N-1:0] m, n,
output wire sw // square wave 
    );
reg [N+2:0] m_reg, n_reg, m_next, n_next; // 3 more bits, as I want to multiply it by 5
localparam reset_value = 7'b0000000;

wire [N+2:0] m_mulBy5, n_mulBy5;
assign m_mulBy5 = {3'b000, m} * 3'b101;
assign n_mulBy5 = {3'b000, n} * 3'b101;

reg sw_reg;

// registers
always @(posedge clk)
    if (reset)
        begin
            m_reg <= reset_value;
            n_reg <= reset_value;
        end
     else
        begin
            m_reg <= m_next;
            n_reg <= n_next;
        end
        
// next state logic : write into m_next and n_next, i.e. computed next state. read m_reg and n_reg, i.e. current state 
always @*
   if (n_reg == 0 && m_reg!= 0) // square 0 (what about the begining of the square? will check later on)
    begin
        sw_reg = 1'b0;
        if (m_reg == m_mulBy5)
            begin
                m_next = 0;
                n_next = 1;
            end     
        else
            begin
                m_next = m_reg + 1'b1;
            end
    end
   else if (m_reg == 0 && n_reg!= 0)   
    begin
        sw_reg = 1'b1;
        if (n_reg == n_mulBy5)
            begin
                n_next = 0;
                m_next = 1;
            end     
        else
            begin
                n_next = n_reg + 1'b1;
            end
    end
    else // this is for the begining of the module. we do this: n_next = 0 and m_next = 1
      begin 
        sw_reg = 0;
        n_next = 0;
        m_next = 1;
      end
      
assign sw = sw_reg;
endmodule
