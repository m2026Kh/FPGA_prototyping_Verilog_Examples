`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2026 10:41:20 PM
// Design Name: 
// Module Name: ch11_7_4_testCircuit
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


module ch11_7_4_testCircuit(
input wire clk, reset,
input wire [2:0] btn,
input wire [7:0] sw,
output wire [3:0] an,
output wire [7:0] sseg,
output wire [7:0] led,
output wire [17:0] ad,
output wire we_n,
output wire oe_n,
inout wire [15:0] dio_a,
output wire ce_a_n,
output wire ub_a_n,
output wire lb_a_n
    );
reg [2:0] state_reg, state_next;
reg [17:0] addr;
wire [15:0] data_s2f;
reg [15:0] data_f2s;
reg mem;
reg rw;
wire [2:0] db_btn;
reg [17:0] c_next, c_reg;
reg [7:0] inj_reg, inj_next;
reg [15:0] err_next, err_reg;

debounce deb_unit0 (.clk(clk), .reset(reset), .sw(btn[0]), .db_level(), .db_tick(db_btn[0]));

debounce deb_unit1 (.clk(clk), .reset(reset), .sw(btn[1]), .db_level(), .db_tick(db_btn[1]));

debounce deb_unit2 (.clk(clk), .reset(reset), .sw(btn[2]), .db_level(), .db_tick(db_btn[2]));

disp_hex_mux disp_unit (.clk(clk), .reset(1'b0), .dp_in(4'b1111), .hex3(err_reg[15:12]), .hex2(err_reg[11:8]), .hex1(err_reg[7:4]), hex0(err_reg[3:0]), .an(an), .sseg(sseg));

ch11_7_4Design(.reset(reset), .clk(clk), .mem(mem), .rw(rw), .addr(addr), .data_m2f(data_f2s), .ready(), .data_f2m_r(), .data_f2m_ur(data_s2f), .ad(ad), .we_n(we_n), .oe_n(oe_n), .dio(dio_a), .ce_n(ce_a_n), .lb_n(lb_a_n), .ub_n(ub_a_n));



// states 

localparam [2:0] init = 3'b000,
                 rd_clk1 = 3'b001,
                 rd_clk2 = 3'b010,
                 rd_clk3 = 3'b011,
                 wr_err = 3'b100,
                 wr_clk1 = 3'b101,
                 wr_clk2 = 3'b110,
                 wr_clk3 = 3'b111;
                 
                 
always @(posedge clk, posedge reset)
begin
    if (reset)
    begin
        state_reg <= init;
        c_reg <= 0;
        inj_reg <= 0;
        err_reg <= 0;
    end
    else
    begin
        state_reg <= state_next;
        c_reg <= c_next;
        inj_reg <= inj_next;
        err_reg <= err_next;
    end
end


always @(*)
begin
    c_next = c_reg;
    inj_next = inj_reg;
    err_next = err_reg;
    addr = 0;
    rw = 1'b1;
    mem = 1'b0;
    data_f2s = 0;

    case (state_reg)

        init:
            if (db_btn[0])
            begin
                state_next = rd_clk1;
                c_next = 0;
                err_next = 0;
            end
            else if (db_btn[1])
            begin
                state_next = wr_clk1;
                c_next = 0;
                inj_next = 0;
            end
            else if (db_btn[2])
            begin
                state_next = wr_err;
                inj_next = inj_reg + 1;
            end
            else
                state_next = test_init;

        wr_err:   
        begin
            state_next = test_init;
            mem = 1'b1;
            rw = 1'b0;
            addr = {10'b0, sw};
            data_f2s = 16'hffff;
        end

        wr_clk1:   // in idle state of sram_ctrl
        begin
            state_next = wr_clk2;
            mem = 1'b1;
            rw = 1'b0;
            addr = c_reg;
            data_f2s = ~c_reg[15:0];
        end

        wr_clk2:   
            state_next = wr_clk3;

        wr_clk3:   
        begin
            c_next = c_reg + 1;
            if (c_next == 0)
                state_next = test_init;
            else
                state_next = wr_clk1;
        end

        rd_clk1:  
        begin
            state_next = rd_clk2;
            mem = 1'b1;
            rw = 1'b1;
            addr = c_reg;
        end

        rd_clk2:   
            state_next = rd_clk3;

        rd_clk3:   
        begin
            if (~c_reg[15:0] != data_s2f)
                err_next = err_reg + 1;

            c_next = c_reg + 1;

            if (c_next == 0)
                state_next = test_init;
            else
                state_next = rd_clk1;
        end

    endcase
end

assign led = inj_reg;                
    
    
endmodule
