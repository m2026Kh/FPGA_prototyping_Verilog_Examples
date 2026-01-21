//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 10:49:37 PM
// Design Name: 
// Module Name: ch6_5_4Design
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


module ch6_5_4Design(
input wire [7:0] BCD_in,
input wire clk, reset,
input wire start,
output wire [3:0] BCD_out_0, BCD_out_1, BCD_out_2, BCD_out_3,
output reg done_tick, ready,
reg overflow
    );

// states

reg [2:0] state_reg, state_next;

localparam [2:0] idle            = 3'b000,
                 BCD_To_Bin_Op   = 3'b001,
                 fib_Op          = 3'b010,
                 Bin_To_BCD_Op   = 3'b011,
                 done            = 3'b100;
                 
localparam [6:0] zero    = 7'b0000000,
                 seven   = 7'b0000111,
                 fifteen = 7'b0001111;
                 //fib_99  = 7'b1100011;             

// output reg for BCD_To_Bin_Op
reg [6:0] b_out_reg, b_out_next;
assign binary_out = b_out_reg;

reg [6:0] counter_reg;
wire [6:0] counter_next;
reg counter_start, counter_done, counter_dec;
assign counter_next = ((counter_start) && (state_next == BCD_To_Bin_Op)) ? seven : 
                      ((counter_start) && (state_next == Bin_To_BCD_Op)) ? fifteen : 
                      ((counter_start) && (state_next == fib_Op)) ?  b_out_reg : // output of this state : BCD_To_Bin_Op
                      (counter_done)  ? zero : 
                      (counter_dec)   ? counter_reg - 1'b1 : 
                                        counter_reg;

// BCD to Bin: _next will take care of shift. _tmp will take care of subtraction
// Bin to BCD: _next will take care of shift. _tmp will take care of addition.
reg [3:0] BCD_3_reg, BCD_2_reg, BCD_1_reg, BCD_0_reg;
wire [3:0] BCD_3_next, BCD_2_next, BCD_1_next, BCD_0_next;
reg [3:0] BCD_3_tmp, BCD_2_tmp, BCD_1_tmp, BCD_0_tmp;



//reg start_tick - take care of both cases of BCD_To_Bin_Op and BCD_To_Bin_Op
// BCD3 and BCD2 are only for Bin_To_BCD_Op
assign BCD_3_next =  (overflow) ? 4'b1001 :
                     ((start) || (state_next == BCD_To_Bin_Op)) ? {4{1'b0}} : 
                     ((state_next == Bin_To_BCD_Op) && (BCD_3_reg > 3'b100)) ? BCD_3_reg + 2'b11 :
                     (state_next == Bin_To_BCD_Op) ? BCD_3_reg :
                      BCD_3_reg;  
                      
assign BCD_2_next =  (overflow) ? 4'b1001 :
                     ((start) || (state_next == BCD_To_Bin_Op)) ? {4{1'b0}} : 
                     ((state_next == Bin_To_BCD_Op) && (BCD_2_reg > 3'b100)) ? BCD_2_reg + 2'b11 :
                     (state_next == Bin_To_BCD_Op) ? BCD_2_reg :
                      BCD_2_reg;   

assign BCD_1_next =  (overflow) ? 4'b1001 :
                    ((start) && (state_next == BCD_To_Bin_Op)) ? BCD_in[7:4] : 
                    ((BCD_1_tmp > 3'b100) && (state_next == BCD_To_Bin_Op)) ?  BCD_1_tmp - 2'b11 :
                     (state_next == BCD_To_Bin_Op)? BCD_1_tmp:
                     ((state_next == Bin_To_BCD_Op) && (BCD_1_reg > 3'b100)) ? BCD_1_reg + 2'b11 :
                     (state_next == Bin_To_BCD_Op) ? BCD_1_reg :
                      BCD_1_reg;
  
assign BCD_0_next =  (overflow) ? 4'b1001 :
                     ((start) && (state_next == BCD_To_Bin_Op)) ? BCD_in[3:0] : 
                    ((BCD_0_tmp > 3'b100) && (state_next == BCD_To_Bin_Op)) ?  BCD_0_tmp - 2'b11 :
                     (state_next == BCD_To_Bin_Op)? BCD_0_tmp:
                     ((state_next == Bin_To_BCD_Op) && (BCD_0_reg > 3'b100)) ? BCD_0_reg + 2'b11 :
                     (state_next == Bin_To_BCD_Op) ? BCD_0_reg :
                      BCD_0_reg;   

                               

// output reg for fib_op. not that, ceil(log2(fib(99))) = 68. But, we will show with 4 BCD digits. i.e. ceil(log2(9999)) = 14
reg [13:0] t0_reg, t0_next, t1_reg, t1_next;

always @(posedge clk, posedge reset)
    begin
        if (reset)  
            begin
                state_reg <= idle;
                counter_reg <= seven;
                BCD_3_reg <= {4{1'b0}};
                BCD_2_reg <= {4{1'b0}};
                BCD_1_reg <= BCD_in[7:4];
                BCD_0_reg <= BCD_in[3:0];
                b_out_reg <= {6{1'b0}};
                t0_reg <= {14{1'b0}};
                t1_reg <= {14{1'b0}};
            end
          else
            begin
                state_reg <= state_next;
                counter_reg <= counter_next;
                if (state_next == fib_Op)
                    begin
                        t0_reg <= t0_next;
                        t1_reg <= t1_next;
                    end
               else if (state_next == Bin_To_BCD_Op)
                    begin
                        BCD_3_reg <= BCD_3_tmp;
                        BCD_2_reg <= BCD_2_tmp;
                        BCD_1_reg <= BCD_1_tmp;
                        BCD_0_reg <= BCD_0_tmp;
                        t1_reg    <= t1_next;
                    end
                else if (state_next == BCD_To_Bin_Op)
                    begin 
                        BCD_1_reg <= BCD_1_next;
                        BCD_0_reg <= BCD_0_next;
                        b_out_reg <= b_out_next;
                        
                        BCD_3_reg <= BCD_3_next;
                        BCD_2_reg <= BCD_2_next;
                    end
               else if ((state_next == done) || (state_next == idle))
                    begin
                        BCD_3_reg <= BCD_3_next;
                        BCD_2_reg <= BCD_2_next;
                        BCD_1_reg <= BCD_1_next;
                        BCD_0_reg <= BCD_0_next;  
                    end     
               else
                    begin
                    // not sure the best way to handle this. Maybe I will learn later on in the book.
                        t0_reg <= t0_next;
                        t1_reg <= t1_next;
                        BCD_3_reg <= BCD_1_tmp;
                        BCD_2_reg <= BCD_0_tmp;
                        BCD_1_reg <= BCD_1_tmp;
                        BCD_0_reg <= BCD_0_tmp;
                    end   
            end
     end

always @(*)
    begin    
        state_next = state_reg;
        counter_start = 1'b0;
        counter_done  = 1'b0;
        counter_dec   = 1'b0;
        
        BCD_3_tmp = BCD_3_reg;
        BCD_2_tmp = BCD_2_reg;       
        BCD_1_tmp = BCD_1_reg;
        BCD_0_tmp = BCD_0_reg;
        
        b_out_next = b_out_reg;
        
        done_tick = 1'b0;
        
        overflow = 1'b0;
       
        case(state_reg)
            idle:
                begin
                ready = 1'b1;
                    if (start) 
                        begin
                            state_next = BCD_To_Bin_Op;
                            counter_start = 1'b1;
                        end
                end         
            BCD_To_Bin_Op:
                begin
                    counter_dec = 1'b1;
                    if (counter_reg == 1'b0)
                        begin
                            state_next = fib_Op;
                            t0_next = 14'd0;
                            t1_next = 14'd1;
                            counter_start = 1'b1;
                        end  
                    else 
                        begin
                            b_out_next = {BCD_0_reg[0], b_out_reg[6:1]};
                            BCD_1_tmp = BCD_1_reg >> 1;    
                            BCD_0_tmp = {BCD_1_reg[0],BCD_0_reg[3:1]};
                        end         
                end
           
           fib_Op:  
                begin
                    if (counter_reg == 1'b0)
                        begin
                            t1_next = 14'd0;
                            state_next = Bin_To_BCD_Op;
                            counter_start = 1'b1;
                        end
                    else if (counter_reg == 1'b1)
                        begin
                            state_next = Bin_To_BCD_Op;
                            counter_start = 1'b1;                          
                        end
                    else
                        begin
                            t1_next = t1_reg + t0_reg;
                            t0_next = t1_reg;
                            counter_dec = 1'b1;
                        end
                end
                        
            Bin_To_BCD_Op:   
                begin
                   if ((t1_reg > 14'd9999) && (counter_reg == fifteen))
                        begin
                           // BCD_0_tmp = 4'b1001;
                           // BCD_1_tmp = 4'b1001;
                           // BCD_2_tmp = 4'b1001;
                           // BCD_3_tmp = 4'b1001;
                            state_next = done; 
                            overflow   = 1'b1;
                        end  
                  else
                        begin   
                            t1_next = t1_reg << 1;
        
                            BCD_0_tmp = {BCD_0_next[2:0], t1_reg[13]};
                            BCD_1_tmp = {BCD_1_next[2:0], BCD_0_next[3]};
                            BCD_2_tmp = {BCD_2_next[2:0], BCD_1_next[3]};
                            BCD_3_tmp = {BCD_3_next[2:0], BCD_2_next[3]};
                            
                            counter_dec = 1'b1;
                            
                            if (counter_next == 0)
                                begin
                                    state_next = done;
                                end 
                       end
                end
                
            done: 
                begin
                    counter_done = 1'b1;
                    done_tick    = 1'b1;
                    state_next   = idle;               
                end                    
        endcase
    end

//assign overflow = (t1_reg > 14'd9999)? 1'b1 : 1'b0;   
assign BCD_out_0 = BCD_0_reg;
assign BCD_out_1 = BCD_1_reg;
assign BCD_out_2 = BCD_2_reg;
assign BCD_out_3 = BCD_3_reg;
    
endmodule
