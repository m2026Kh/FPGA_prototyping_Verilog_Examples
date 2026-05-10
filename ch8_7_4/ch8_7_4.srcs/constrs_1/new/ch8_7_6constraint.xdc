set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]


set_property PACKAGE_PIN R2 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]




#set_property PACKAGE_PIN U16 [get_ports r_data[0]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[0]];

#set_property PACKAGE_PIN E19 [get_ports r_data[1]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[1]];

#set_property PACKAGE_PIN U19 [get_ports r_data[2]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[2]];

#set_property PACKAGE_PIN V19 [get_ports r_data[3]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[3]];

#set_property PACKAGE_PIN W18 [get_ports r_data[4]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[4]];

#set_property PACKAGE_PIN U15 [get_ports r_data[5]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[5]];

#set_property PACKAGE_PIN U14 [get_ports r_data[6]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[6]];

#set_property PACKAGE_PIN V14 [get_ports r_data[7]];
#set_property IOSTANDARD LVCMOS33 [get_ports r_data[7]];

#set_property PACKAGE_PIN L1 [get_ports rx_empty];
#set_property IOSTANDARD LVCMOS33 [get_ports rx_empty];


#set_property PACKAGE_PIN W19 [get_ports btn];
#set_property IOSTANDARD LVCMOS33 [get_ports btn];
# set_property PACKAGE_PIN V16 [get_ports go];
# set_property IOSTANDARD LVCMOS33 [get_ports go];
# set_property PACKAGE_PIN W19 [get_ports clr];
# set_property IOSTANDARD LVCMOS33 [get_ports clr];


set_property PACKAGE_PIN B18 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]

set_property PACKAGE_PIN A18 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports tx]



set_property PACKAGE_PIN W7 [get_ports {sevenSegDisp[6]}]
set_property PACKAGE_PIN W6 [get_ports {sevenSegDisp[5]}]
set_property PACKAGE_PIN U8 [get_ports {sevenSegDisp[4]}]
set_property PACKAGE_PIN V8 [get_ports {sevenSegDisp[3]}]
set_property PACKAGE_PIN U5 [get_ports {sevenSegDisp[2]}]
set_property PACKAGE_PIN V5 [get_ports {sevenSegDisp[1]}]
set_property PACKAGE_PIN U7 [get_ports {sevenSegDisp[0]}]
#set_property PACKAGE_PIN V7  [get_ports {sevenSegDisp[7]}] ;# dp
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sevenSegDisp[7]}]


set_property PACKAGE_PIN U2 [get_ports {enable[0]}]
set_property PACKAGE_PIN U4 [get_ports {enable[1]}]
set_property PACKAGE_PIN V4 [get_ports {enable[2]}]
set_property PACKAGE_PIN W4 [get_ports {enable[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {enable[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {enable[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {enable[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {enable[3]}]

