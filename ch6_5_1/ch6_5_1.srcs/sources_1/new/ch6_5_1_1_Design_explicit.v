//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2025 08:59:24 PM
// Design Name: 
// Module Name: ch6_5_1_1_Design
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


module ch6_5_1_1_Design_explicit(
input wire si,
output wire so,so_tick,
input wire clk, reset
    );
// symbolick state declaration 
localparam [1:0] level_0 = 2'b00,
                 wait_0 = 2'b01,
                 level_1 = 2'b10,
                 wait_1  = 2'b11;

// 20 ms = 20ns * number_of_clocks
// log2(10^(-3) / 10^(-9)) ~= 20 bits,
reg [19:0] counter_reg;
wire [19:0] counter_next;
reg db, db_tick;
reg [1:0] state_reg, state_next;

//localparam [19:0] wait_time   = 20'd1000000,
                  //wait_time_2 = 20'd500000;

// for simulation 
localparam [19:0] wait_time   = 3'b110,
                  wait_time_2 = 2'b10;

// FSMD state and data registers 
always @(posedge clk, posedge reset)
    if (reset)
        begin
            counter_reg <= wait_time;
            state_reg   <= level_0; 
        end
     else
        begin
           counter_reg <= counter_next;
           state_reg   <= state_next;
        end
 
// ---------------------------------
// ---- new localparam for explicit design
reg counter_load, counter_load_2, counter_dec;
wire counter_zero;
assign counter_zero = (counter_next == {20{1'b0}});
assign counter_next = (counter_load == 1'b1)   ? wait_time:
                      (counter_load_2 == 1'b1) ? wait_time_2 :
                      (counter_dec == 1'b1)    ? counter_reg - 1'b1:
                                                  counter_reg;
                



// ---------------------------
 
// next_state combinational circuits        
always @(*)
    begin
      // initial values
      counter_load = 1'b0;
      counter_load_2 = 1'b0;
      counter_dec = 1'b0;
      
      state_next = state_reg;
      //counter_next = counter_reg; 
      db_tick = 1'b0;
      case (state_reg)
        level_0: 
            begin
                db = 0;
                if (si)
                    begin
                        state_next = wait_0;
                        counter_load = 1'b1;
                    end
            end
        wait_0:
            begin
                db = 1;
                counter_dec = 1'b1;     
                if (counter_zero)
                    begin
                        if (si)
                            begin 
                                state_next = level_1;
                            end
                         else
                            begin
                                state_next = wait_0; 
                                //counter_next = wait_time_2; // wait 10 more ms
                                counter_load_2 = 1'b1;
                                counter_dec = 1'b0; 
                            end
                    end
                 else 
                    begin
                        if (counter_load == 1'b1)
                            begin
                                db_tick = 1'b1;
                            end
                    end
            end
                               
         level_1:
            begin
                db = 1;
                if (si == 1'b0)
                    begin
                        state_next = wait_1;
                        //counter_next = wait_time;
                        counter_load = 1'b1;
                    end                    
            end
            
         wait_1:
            begin
                db = 0;
                counter_dec = 1'b1;
                if (counter_zero)
                    begin
                        if (si == 1'b0)
                            begin 
                                state_next = level_0;
                            end
                         else
                            begin
                                state_next = wait_1; 
                                //counter_next = wait_time_2; // wait 10 mre ms
                                counter_load_2 = 1'b1;
                                counter_dec = 1'b0;
                            end
                    end
//                 else 
//                    begin
//                       // counter_next = counter_reg - 1'b1;
//                       counter_dec = 1'b1;
//                    end
            end
            endcase  
    end

assign so      = db; 
assign so_tick = db_tick;



endmodule
