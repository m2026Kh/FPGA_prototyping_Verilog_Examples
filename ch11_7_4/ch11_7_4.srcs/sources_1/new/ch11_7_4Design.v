`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2026 10:42:28 PM
// Design Name: 
// Module Name: ch11_7_4Design
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


module ch11_7_4Design(
input wire reset, clk,
input wire mem,
input wire rw,
input wire [17:0] addr,
input wire [15:0] data_m2f,
output wire [15:0] data_f2m_r,
output wire [15:0] data_f2m_ur,
output reg ready,
output wire [17:0] ad,
inout wire [15:0] dio,
output wire we_n,
output wire oe_n,
output wire ce_n, lb_n, ub_n
    );

// local signals 
reg [15:0] data_f2m_r_reg, data_f2m_r_next;
reg [15:0] data_m2f_reg, data_m2f_next;
reg [17:0] ad_reg, ad_next;
reg we_n_reg, we_n_next;
reg oe_n_reg, oe_n_next;
reg tri_reg, tri_next;

reg [2:0] state_reg, state_next;

always @(posedge clk)
begin
    if (reset)
    begin
        data_f2m_r_reg <= 0;
        data_m2f_reg   <= 0;
        we_n_reg       <= 1'b1;
        oe_n_reg       <= 1'b1;
        state_reg      <= idle;
        ad_reg         <= 0;
        tri_reg        <= 1'b1;
    end
    else
    begin
        data_f2m_r_reg <= data_f2m_r_next;
        data_m2f_reg   <= data_m2f_next;
        we_n_reg       <= we_n_next;
        oe_n_reg       <= oe_n_next;
        state_reg      <= state_next;   
        ad_reg         <= ad_next;    
        tri_reg        <= tri_next; 
    end
    

end


localparam [2:0] idle = 3'b000,
                 r1   = 3'b001,
                 r2   = 3'b010,
                 w1   = 3'b011,
                 w2   = 3'b100;
                 

always @(*)
begin

data_f2m_r_next = data_f2m_r_reg;
data_m2f_next = data_m2f_reg;
state_next = state_reg;
ad_next = ad_reg;

ready = 1'b0;

case (state_reg)
    idle:
    begin
        if (mem)
        begin
            ready = 1'b1;
            if (rw) // read
                begin
                    state_next = r1;
                    ad_next = addr;
                end
            else // write
                begin
                    state_next = w1;
                    ad_next = addr;
                    data_m2f_next = data_m2f;
                end 
        end   
    end
    
    r1:
    begin
        state_next = r2;
    end
    
    r2:
    begin
        state_next = idle;
        data_f2m_r_next = dio;
    end
    
    w1:
    begin
        state_next = w2;
    end
    
    w2:
    begin
         state_next = idle;
    end

endcase

end   
   
   
always @(*)
begin
  
tri_next = 1'b1;
we_n_next = 1'b1;
oe_n_next = 1'b1; 

// look-ahead output
case (state_next)
    r1:
    begin
        oe_n_next = 1'b0;
    end
       
    r2:
    begin
        oe_n_next = 1'b0;
    end
        
    w1:
    begin
    we_n_next = 1'b0;
    tri_next = 1'b0;
    end
        
    w2:
    begin
    tri_next = 1'b0;
    end   
    
endcase    
   
end 


assign data_f2m_r = data_f2m_r_reg;
assign data_f2m_ur = dio;
assign ad = ad_reg;
assign we_n = we_n_reg;
assign oe_n = oe_n_reg;

assign dio = (tri_reg == 1'b0)? data_m2f_reg: {16{1'bz}};

assign ce_n = 1'b0;
assign lb_n = 1'b0;
assign ub_n = 1'b0;



    
endmodule
