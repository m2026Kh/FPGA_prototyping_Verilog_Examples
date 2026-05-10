`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2026 06:12:27 PM
// Design Name: 
// Module Name: ch8_7_4_design
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


module ch8_7_4_design
#(parameter N_bit = 8, // data bits
            S_count = 16, // 1 stop bit needs 16 ticks.
            baud = 19200, // buad rate 
            divisor = 325, // 16 times faster in Rx -> clk_rate/(16*baud) = 100M/(16*19200)
            divisor_bits = 9, // ceil(divisor) = 9
            fifo_w = 3 // number of words in fifo: 2^(fifo_w), i.e. fifo_w is the number of address bits in fifo
)
(
input wire clk, reset,
input wire rx,
output wire tx,
output wire [6:0] sevenSegDisp,
output wire [3:0] enable
//output wire rx_empty
//output wire [N_bit-1:0] r_data // debug    
);
       
    
reg rd_uart_reg,wr_uart_reg, rd_uart_next ,wr_uart_next, write_en;
reg [N_bit-1:0] w_write_reg, w_write_next;

wire [N_bit-1:0] w_data, r_data;
reg [N_bit-1:0] r_data_next, r_data_reg;


reg [2:0] state_reg, state_next;
reg clr_reg, go_reg, up_reg, clr_next, go_next, up_next; 
reg [1:0] tx_byteNum_reg, tx_byteNum_next;
wire [3:0] d1, d2, d3;
wire tx_full;
wire rx_empty;

wire [6:0] led0, led1, led2;

hex_to_sevenSeg uut12(.hex(d1), .dp(1'b1), .sevenSeg(led0));
hex_to_sevenSeg uut13(.hex(d2), .dp(1'b1), .sevenSeg(led1));
hex_to_sevenSeg uut14(.hex(d3), .dp(1'b1), .sevenSeg(led2));


sevenSegDisp uut15(.clk(clk), .reset(reset),.led0(led0), .led1(led1), .led2(led2), .led3({7{1'b1}}),.sevenSegDisp(sevenSegDisp),.enable(enable));


    
ch8_7_4_UartDesignTopLEvel #(.N_bit(N_bit), .S_count(S_count), .baud(baud), .divisor(divisor), .divisor_bits(divisor_bits), .fifo_w(fifo_w)) uart(.clk(clk), .reset(reset), .rx(rx), .rd_uart(rd_uart_reg), .w_data(w_data), .wr_uart(wr_uart_reg), .r_data(r_data), .rx_empty(rx_empty), .tx_full(tx_full), .tx(tx));



stopWatch #(.N(24), .max_C(10000000)) watch(.d1(d1), .d2(d2), .d3(d3), .clk(clk), .clr(clr_reg), .go(go_reg), .up(up_reg)); 

//input wire rx,



// master FSM

always @(posedge clk or posedge reset)
    if (reset == 1)
        begin
            rd_uart_reg <= 1'b0;
            wr_uart_reg <= 1'b0;
            state_reg   <= 2'b00;
            clr_reg     <= 1'b1; 
            go_reg      <= 1'b0;
            up_reg      <= 1'b1;
            w_write_reg <= {N_bit{1'b0}};
            tx_byteNum_reg <= 2'b00;
            r_data_reg <= {N_bit{1'b0}};
        end       
     else
        begin
            rd_uart_reg <= rd_uart_next;
            wr_uart_reg <= wr_uart_next; 
            state_reg   <= state_next; 
            clr_reg     <= clr_next; 
            go_reg      <= go_next;
            up_reg      <= up_next; 
            w_write_reg <= w_write_next;
            tx_byteNum_reg <= tx_byteNum_next;  
            r_data_reg     <= r_data_next;
        end

localparam [2:0] idle      = 3'b000,
                 read      = 3'b001, 
                 process   = 3'b010,
                 pre_write = 3'b011,
                 write     = 3'b100,
                 next_byte = 3'b101;        

always @(*)
begin
rd_uart_next = 1'b0; // rd is 1'b1 in one clk only and then we select (not fetch!) data from fifo. Basically, no transmit or receive, unless required.
wr_uart_next = 1'b0; // same as above
state_next   = state_reg ;
clr_next = 1'b0;
go_next = go_reg;
up_next = up_reg;
write_en = 1'b0;
w_write_next = w_write_reg;
tx_byteNum_next = tx_byteNum_reg;
r_data_next = r_data_reg;

case (state_reg)
    idle:
    begin
    if (rx_empty == 0)
        begin
            state_next = read;
            rd_uart_next = 1'b1;
        end
    end
    read:
    begin
        state_next = process; //If data depends on a control signal -> separate them by 1 state 
                               // pointer will update one clock after rd request. 
        r_data_next = r_data; // you must capture/use current r_data BEFORE pointer advances. rd request will increase pointer by one at the end of the clock. So, save the array before clock edge.
    end
    process:
    begin
        
        case (r_data_reg)
            8'h72, 8'h52: // R r
                begin
                state_next = idle;
                    if (tx_full == 0)
                        begin
                            //wr_uart_next = 1'b1;
                            tx_byteNum_next = 0;
                            state_next = pre_write;
                        end
                     //else
                       // begin
                         //   state_next = idle;
                         //end
                end
            8'h63, 8'h43:  // C c
                begin
                    state_next = idle;
                    clr_next = 1'b1;
                    go_next = 1'b1;
                    up_next = 1'b1;
                end
                
            8'h67, 8'h47: 
                begin // G g
                    state_next = idle;
                    go_next = 1'b1;  
                end
            8'h70, 8'h50: 
            begin // P p
                state_next = idle;
                go_next = 1'b0; 
            end
            8'h75, 8'h55: // U u 
            begin
                state_next = idle;
                up_next = 1'b0; 
            end
            default: state_next = idle;
         endcase   
    end
    pre_write:
    begin
        state_next = write; 
        case (tx_byteNum_reg)
                2'b00:  w_write_next = 8'h30 + d3;
                2'b01:  w_write_next = 8'h2e;
                2'b10:  w_write_next = 8'h30 + d2;
                2'b11:  w_write_next = 8'h30 + d1;

         endcase
        
    end
    
    write: // send one byte from wr uart fifo. 
        begin
        if (~tx_full)
        begin
            wr_uart_next = 1'b1;
            if (tx_byteNum_reg == 2'b11)
                state_next = idle;
            else
            begin
                state_next = next_byte; 
            end

       end
       end  

    next_byte:
    begin
        tx_byteNum_next = tx_byteNum_reg + 1;
        state_next = pre_write;
    end       
                         
 endcase
end

assign w_data = w_write_reg;
    
endmodule
