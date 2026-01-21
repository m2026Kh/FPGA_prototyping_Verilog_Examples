set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


#set_property PACKAGE_PIN R2 [get_ports reset];# SW15
#set_property IOSTANDARD LVCMOS33 [get_ports reset];
set_property PACKAGE_PIN T17 [get_ports start];
set_property IOSTANDARD LVCMOS33 [get_ports start];
set_property PACKAGE_PIN V19 [get_ports done_tick];
set_property IOSTANDARD LVCMOS33 [get_ports done_tick];
set_property PACKAGE_PIN W19 [get_ports reset];
set_property IOSTANDARD LVCMOS33 [get_ports reset];

set_property PACKAGE_PIN V17 [get_ports {n[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[0]}]
set_property PACKAGE_PIN V16 [get_ports {n[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[1]}]
set_property PACKAGE_PIN W16 [get_ports {n[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[2]}]
set_property PACKAGE_PIN W17 [get_ports {n[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[3]}]
set_property PACKAGE_PIN W15 [get_ports {n[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[4]}]
set_property PACKAGE_PIN V15 [get_ports {n[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {n[5]}]
			


set_property PACKAGE_PIN W7  [get_ports sevenSegDisp[6]] ;# a
set_property PACKAGE_PIN W6  [get_ports sevenSegDisp[5]] ;# b
set_property PACKAGE_PIN U8  [get_ports sevenSegDisp[4]] ;# c
set_property PACKAGE_PIN V8  [get_ports sevenSegDisp[3]] ;# d
set_property PACKAGE_PIN U5  [get_ports sevenSegDisp[2]] ;# e
set_property PACKAGE_PIN V5  [get_ports sevenSegDisp[1]] ;# f
set_property PACKAGE_PIN U7  [get_ports sevenSegDisp[0]] ;# g
set_property PACKAGE_PIN V7  [get_ports sevenSegDisp[7]] ;# dp
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[6]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[5]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[4]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[3]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sevenSegDisp[7]]


set_property PACKAGE_PIN U2 [get_ports enable[0]]
set_property PACKAGE_PIN U4 [get_ports enable[1]]
set_property PACKAGE_PIN V4 [get_ports enable[2]]
set_property PACKAGE_PIN W4 [get_ports enable[3]]
set_property IOSTANDARD LVCMOS33 [get_ports enable[0]]
set_property IOSTANDARD LVCMOS33 [get_ports enable[1]]
set_property IOSTANDARD LVCMOS33 [get_ports enable[2]]
set_property IOSTANDARD LVCMOS33 [get_ports enable[3]]