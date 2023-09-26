# XDC constraints for the Xilinx Alveo U250 board
# part: xcu250-figd2104-2-e

# General configuration
set_property CFGBVS GND                                [current_design]
set_property CONFIG_VOLTAGE 1.8                        [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true           [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE    [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DISABLE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 63.8          [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES       [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4           [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP         [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable  [current_design]

set_operating_conditions -design_power_budget 160

# System clocks
# 300 MHz (DDR 0)
set_property -dict {LOC AY37 IOSTANDARD LVDS} [get_ports clk_400mhz_0_p]
set_property -dict {LOC AY38 IOSTANDARD LVDS} [get_ports clk_400mhz_0_n]
#create_clock -period 3.333 -name clk_300mhz_0 [get_ports clk_300mhz_0_p]

# 300 MHz (DDR 1)
set_property -dict {LOC AW20 IOSTANDARD LVDS} [get_ports clk_400mhz_1_p]
set_property -dict {LOC AW19 IOSTANDARD LVDS} [get_ports clk_400mhz_1_n]
#create_clock -period 3.333 -name clk_300mhz_1 [get_ports clk_300mhz_1_p]

# 300 MHz (DDR 2)
set_property -dict {LOC F32  IOSTANDARD LVDS} [get_ports clk_400mhz_2_p]
set_property -dict {LOC E32  IOSTANDARD LVDS} [get_ports clk_400mhz_2_n]
#create_clock -period 3.333 -name clk_300mhz_2 [get_ports clk_300mhz_2_p]

# 300 MHz (DDR 3)
set_property -dict {LOC J16  IOSTANDARD LVDS} [get_ports clk_400mhz_3_p]
set_property -dict {LOC H16  IOSTANDARD LVDS} [get_ports clk_400mhz_3_n]
#create_clock -period 3.333 -name clk_300mhz_3 [get_ports clk_300mhz_3_p]

# SI570 user clock
#set_property -dict {LOC AU19 IOSTANDARD LVDS} [get_ports clk_user_p]
#set_property -dict {LOC AV19 IOSTANDARD LVDS} [get_ports clk_user_n]
#create_clock -period 6.400 -name clk_user [get_ports clk_user_p]

# LEDs
set_property -dict {LOC BA20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[0]}]
set_property -dict {LOC BB20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[1]}]
set_property -dict {LOC BB21 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[2]}]

set_false_path -to [get_ports {led[*]}]
set_output_delay 0 [get_ports {led[*]}]

# Reset button
#set_property -dict {LOC AL20 IOSTANDARD LVCMOS12} [get_ports reset]

#set_false_path -from [get_ports {reset}]
#set_input_delay 0 [get_ports {reset}]

# DIP switches
# set_property -dict {LOC AN22 IOSTANDARD LVCMOS12} [get_ports {sw[0]}]
# set_property -dict {LOC AM19 IOSTANDARD LVCMOS12} [get_ports {sw[1]}]
# set_property -dict {LOC AL19 IOSTANDARD LVCMOS12} [get_ports {sw[2]}]
# set_property -dict {LOC AP20 IOSTANDARD LVCMOS12} [get_ports {sw[3]}]

set_false_path -from [get_ports {sw[*]}]
set_input_delay 0 [get_ports {sw[*]}]

# UART
#set_property -dict {LOC BF18 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports uart_txd]
#set_property -dict {LOC BB20 IOSTANDARD LVCMOS12} [get_ports uart_rxd]

#set_false_path -to [get_ports {uart_txd}]
#set_output_delay 0 [get_ports {uart_txd}]
#set_false_path -from [get_ports {uart_rxd}]
#set_input_delay 0 [get_ports {uart_rxd}]

# BMC
set_property -dict {LOC BC21 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 4} [get_ports {msp_gpio[0]}]
set_property -dict {LOC BB22 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 4} [get_ports {msp_gpio[1]}]
set_property -dict {LOC BC22 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 4} [get_ports {msp_gpio[2]}]
set_property -dict {LOC BA24 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 4} [get_ports {msp_gpio[3]}]
# set_property -dict {LOC BB19 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 4} [get_ports {msp_uart_txd}]
# set_property -dict {LOC BA19 IOSTANDARD LVCMOS12} [get_ports {msp_uart_rxd}]

# set_false_path -to [get_ports {msp_uart_txd}]
# set_output_delay 0 [get_ports {msp_uart_txd}]
# set_false_path -from [get_ports {msp_gpio[*] msp_uart_rxd}]
# set_input_delay 0 [get_ports {msp_gpio[*] msp_uart_rxd}]

# QSFP28 Interfaces
set_property -dict {LOC E9  } [get_ports qsfp0_tx1_p] ;# MGTYTXP0_231 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC E8  } [get_ports qsfp0_tx1_n] ;# MGTYTXN0_231 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC D7  } [get_ports qsfp0_tx2_p] ;# MGTYTXP1_231 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC D6  } [get_ports qsfp0_tx2_n] ;# MGTYTXN1_231 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC C9  } [get_ports qsfp0_tx3_p] ;# MGTYTXP2_231 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC C8  } [get_ports qsfp0_tx3_n] ;# MGTYTXN2_231 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC A9  } [get_ports qsfp0_tx4_p] ;# MGTYTXP3_231 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11
set_property -dict {LOC A8  } [get_ports qsfp0_tx4_n] ;# MGTYTXN3_231 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11
set_property -dict {LOC E4  } [get_ports qsfp0_rx1_p] ;# MGTYRXP0_231 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC E3  } [get_ports qsfp0_rx1_n] ;# MGTYRXN0_231 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC D2  } [get_ports qsfp0_rx2_p] ;# MGTYRXP1_231 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC D1  } [get_ports qsfp0_rx2_n] ;# MGTYRXN1_231 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC C4  } [get_ports qsfp0_rx3_p] ;# MGTYRXP2_231 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC C3  } [get_ports qsfp0_rx3_n] ;# MGTYRXN2_231 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC A5  } [get_ports qsfp0_rx4_p] ;# MGTYRXP3_231 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11
set_property -dict {LOC A4  } [get_ports qsfp0_rx4_n] ;# MGTYRXN3_231 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11

#set_property -dict {LOC M11 } [get_ports qsfp0_mgt_refclk_0_p] ;# MGTREFCLK0P_231 from U14.4 via U43.13
#set_property -dict {LOC M10 } [get_ports qsfp0_mgt_refclk_0_n] ;# MGTREFCLK0N_231 from U14.5 via U43.14
set_property -dict {LOC D11 } [get_ports qsfp0_mgt_refclk_1_p] ;# MGTREFCLK1P_231 from U9.18
set_property -dict {LOC D10 } [get_ports qsfp0_mgt_refclk_1_n] ;# MGTREFCLK1N_231 from U9.17

# set_property -dict {LOC BC7 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports qsfp0_modsell]
set_property -dict {LOC BA7 IOSTANDARD LVCMOS12 SLEW SLOW } [get_ports qsfp0_resetl]
set_property -dict {LOC BC7 IOSTANDARD LVCMOS12 PULLUP true} [get_ports qsfp0_modprsl]
set_property -dict {LOC BC8 IOSTANDARD LVCMOS12 PULLUP true} [get_ports qsfp0_intl]
set_property -dict {LOC BB9 IOSTANDARD LVCMOS12 SLEW SLOW } [get_ports qsfp0_lpmode]
# set_property -dict {LOC AT22 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports qsfp0_refclk_reset]
# set_property -dict {LOC AT20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {qsfp0_fs[0]}]
# set_property -dict {LOC AU22 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {qsfp0_fs[1]}]

# 156.25 MHz MGT reference clock (from SI570)
#create_clock -period 6.400 -name qsfp0_mgt_refclk_0 [get_ports qsfp0_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from 
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI533, FS = 0b01)
#create_clock -period 6.400 -name qsfp0_mgt_refclk_1 [get_ports qsfp0_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from 
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI533, FS = 0b10)
create_clock -period 6.206 -name qsfp0_mgt_refclk_1 [get_ports qsfp0_mgt_refclk_1_p]

set_false_path -to [get_ports {qsfp0_modsell qsfp0_resetl qsfp0_lpmode }]
set_output_delay 0 [get_ports {qsfp0_modsell qsfp0_resetl qsfp0_lpmode }]
set_false_path -from [get_ports {qsfp0_modprsl qsfp0_intl}]
set_input_delay 0 [get_ports {qsfp0_modprsl qsfp0_intl}]

set_property -dict {LOC AA9  } [get_ports qsfp1_tx1_p] ;# MGTYTXP0_230 GTYE4_CHANNEL_X1Y40 / GTYE4_COMMON_X1Y10
set_property -dict {LOC AA8  } [get_ports qsfp1_tx1_n] ;# MGTYTXN0_230 GTYE4_CHANNEL_X1Y40 / GTYE4_COMMON_X1Y10
set_property -dict {LOC Y7   } [get_ports qsfp1_tx2_p] ;# MGTYTXP1_230 GTYE4_CHANNEL_X1Y41 / GTYE4_COMMON_X1Y10
set_property -dict {LOC Y6   } [get_ports qsfp1_tx2_n] ;# MGTYTXN1_230 GTYE4_CHANNEL_X1Y41 / GTYE4_COMMON_X1Y10
set_property -dict {LOC W9   } [get_ports qsfp1_tx3_p] ;# MGTYTXP2_230 GTYE4_CHANNEL_X1Y42 / GTYE4_COMMON_X1Y10
set_property -dict {LOC W8   } [get_ports qsfp1_tx3_n] ;# MGTYTXN2_230 GTYE4_CHANNEL_X1Y42 / GTYE4_COMMON_X1Y10
set_property -dict {LOC V7   } [get_ports qsfp1_tx4_p] ;# MGTYTXP3_230 GTYE4_CHANNEL_X1Y43 / GTYE4_COMMON_X1Y10
set_property -dict {LOC V6   } [get_ports qsfp1_tx4_n] ;# MGTYTXN3_230 GTYE4_CHANNEL_X1Y43 / GTYE4_COMMON_X1Y10
set_property -dict {LOC AA4  } [get_ports qsfp1_rx1_p] ;# MGTYRXP0_230 GTYE4_CHANNEL_X1Y40 / GTYE4_COMMON_X1Y10
set_property -dict {LOC AA3  } [get_ports qsfp1_rx1_n] ;# MGTYRXN0_230 GTYE4_CHANNEL_X1Y40 / GTYE4_COMMON_X1Y10
set_property -dict {LOC Y2   } [get_ports qsfp1_rx2_p] ;# MGTYRXP1_230 GTYE4_CHANNEL_X1Y41 / GTYE4_COMMON_X1Y10
set_property -dict {LOC Y1   } [get_ports qsfp1_rx2_n] ;# MGTYRXN1_230 GTYE4_CHANNEL_X1Y41 / GTYE4_COMMON_X1Y10
set_property -dict {LOC W4   } [get_ports qsfp1_rx3_p] ;# MGTYRXP2_230 GTYE4_CHANNEL_X1Y42 / GTYE4_COMMON_X1Y10
set_property -dict {LOC W3   } [get_ports qsfp1_rx3_n] ;# MGTYRXN2_230 GTYE4_CHANNEL_X1Y42 / GTYE4_COMMON_X1Y10
set_property -dict {LOC V2   } [get_ports qsfp1_rx4_p] ;# MGTYRXP3_230 GTYE4_CHANNEL_X1Y43 / GTYE4_COMMON_X1Y10
set_property -dict {LOC V1   } [get_ports qsfp1_rx4_n] ;# MGTYRXN3_230 GTYE4_CHANNEL_X1Y43 / GTYE4_COMMON_X1Y10

#set_property -dict {LOC T11 } [get_ports qsfp1_mgt_refclk_0_p] ;# MGTREFCLK0P_230 from U14.4 via U43.15
#set_property -dict {LOC T10 } [get_ports qsfp1_mgt_refclk_0_n] ;# MGTREFCLK0N_230 from U14.5 via U43.16
set_property -dict {LOC Y11 } [get_ports qsfp1_mgt_refclk_1_p] ;# MGTREFCLK1P_230 from U12.18
set_property -dict {LOC Y10 } [get_ports qsfp1_mgt_refclk_1_n] ;# MGTREFCLK1N_230 from U12.17
# set_property -dict {LOC AY20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports qsfp1_modsell]
set_property -dict {LOC BB10 IOSTANDARD LVCMOS12 SLEW SLOW } [get_ports qsfp1_resetl]
set_property -dict {LOC BB11 IOSTANDARD LVCMOS12 PULLUP true} [get_ports qsfp1_modprsl]
set_property -dict {LOC BC11 IOSTANDARD LVCMOS12 PULLUP true} [get_ports qsfp1_intl]
set_property -dict {LOC BB7 IOSTANDARD LVCMOS12 SLEW SLOW } [get_ports qsfp1_lpmode]
# set_property -dict {LOC AR21 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports qsfp1_refclk_reset]
# set_property -dict {LOC AR22 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {qsfp1_fs[0]}]
# set_property -dict {LOC AU20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {qsfp1_fs[1]}]

# 156.25 MHz MGT reference clock (from SI570)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from 
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI533, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from 
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI533, FS = 0b10)
create_clock -period 6.206 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

set_false_path -to [get_ports {qsfp1_modsell qsfp1_resetl qsfp1_lpmode }]
set_output_delay 0 [get_ports {qsfp1_modsell qsfp1_resetl qsfp1_lpmode }]
set_false_path -from [get_ports {qsfp1_modprsl qsfp1_intl}]
set_input_delay 0 [get_ports {qsfp1_modprsl qsfp1_intl}]

# I2C interface
#set_property -dict {LOC BF19 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_mux_reset]
set_property -dict {LOC BF12 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_scl]
set_property -dict {LOC BD9  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_sda]

set_false_path -to [get_ports {i2c_sda i2c_scl}]
set_output_delay 0 [get_ports {i2c_sda i2c_scl}]
set_false_path -from [get_ports {i2c_sda i2c_scl}]
set_input_delay 0 [get_ports {i2c_sda i2c_scl}]


# PCIe Interface
set_property -dict {LOC BF5  } [get_ports {pcie_tx_p[0]}]  ;# MGTYTXP3_227 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
set_property -dict {LOC BD5  } [get_ports {pcie_tx_p[1]}]  ;# MGTYTXP2_227 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
set_property -dict {LOC BB5  } [get_ports {pcie_tx_p[2]}]  ;# MGTYTXP1_227 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AV7  } [get_ports {pcie_tx_p[3]}]  ;# MGTYTXP0_227 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AU9  } [get_ports {pcie_tx_p[4]}]  ;# MGTYTXP3_226 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AT7  } [get_ports {pcie_tx_p[5]}]  ;# MGTYTXP2_226 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AR9  } [get_ports {pcie_tx_p[6]}]  ;# MGTYTXP1_226 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AP7  } [get_ports {pcie_tx_p[7]}]  ;# MGTYTXP0_226 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AN9  } [get_ports {pcie_tx_p[8]}]  ;# MGTYTXP3_225 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AM7  } [get_ports {pcie_tx_p[9]}]  ;# MGTYTXP2_225 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AL9  } [get_ports {pcie_tx_p[10]}] ;# MGTYTXP1_225 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AK7  } [get_ports {pcie_tx_p[11]}] ;# MGTYTXP0_225 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AJ9  } [get_ports {pcie_tx_p[12]}] ;# MGTYTXP3_224 GTYE4_CHANNEL_X1Y19 / GTYE4_COMMON_X1Y4
set_property -dict {LOC AH7  } [get_ports {pcie_tx_p[13]}] ;# MGTYTXP2_224 GTYE4_CHANNEL_X1Y18 / GTYE4_COMMON_X1Y4
set_property -dict {LOC AG9  } [get_ports {pcie_tx_p[14]}] ;# MGTYTXP1_224 GTYE4_CHANNEL_X1Y17 / GTYE4_COMMON_X1Y4
set_property -dict {LOC AF7  } [get_ports {pcie_tx_p[15]}] ;# MGTYTXP0_224 GTYE4_CHANNEL_X1Y16 / GTYE4_COMMON_X1Y4
set_property -dict {LOC AK11 } [get_ports pcie_refclk_p] ;# MGTREFCLK0P_226
set_property -dict {LOC AR26 IOSTANDARD LVCMOS12 PULLUP true} [get_ports pcie_reset_n]


# 100 MHz MGT reference clock
create_clock -period 10 -name pcie_mgt_refclk_1 [get_ports pcie_refclk_p]

set_false_path -from [get_ports {pcie_reset_n}]
set_input_delay 0 [get_ports {pcie_reset_n}]

# DDR4 C0

set_property PACKAGE_PIN G25 [get_ports c0_sys_clk_p]
set_property PACKAGE_PIN B24 [get_ports c0_ddr4_reset_n]
set_property PACKAGE_PIN A22 [get_ports c0_ddr4_act_n]
set_property PACKAGE_PIN F23 [get_ports {c0_ddr4_adr[0]}]
set_property PACKAGE_PIN K23 [get_ports {c0_ddr4_adr[1]}]
set_property PACKAGE_PIN F24 [get_ports {c0_ddr4_adr[2]}]
set_property PACKAGE_PIN H23 [get_ports {c0_ddr4_adr[3]}]
set_property PACKAGE_PIN E23 [get_ports {c0_ddr4_adr[4]}]
set_property PACKAGE_PIN L23 [get_ports {c0_ddr4_adr[5]}]
set_property PACKAGE_PIN G22 [get_ports {c0_ddr4_adr[6]}]
set_property PACKAGE_PIN L25 [get_ports {c0_ddr4_adr[7]}]
set_property PACKAGE_PIN H24 [get_ports {c0_ddr4_adr[8]}]
set_property PACKAGE_PIN L24 [get_ports {c0_ddr4_adr[9]}]
set_property PACKAGE_PIN F22 [get_ports {c0_ddr4_adr[10]}]
set_property PACKAGE_PIN J24 [get_ports {c0_ddr4_adr[11]}]
set_property PACKAGE_PIN K22 [get_ports {c0_ddr4_adr[12]}]
set_property PACKAGE_PIN D24 [get_ports {c0_ddr4_adr[13]}]
set_property PACKAGE_PIN J23 [get_ports {c0_ddr4_adr[15]}]
set_property PACKAGE_PIN L22 [get_ports {c0_ddr4_adr[16]}]
set_property PACKAGE_PIN D23 [get_ports {c0_ddr4_ba[0]}]
set_property PACKAGE_PIN E25 [get_ports {c0_ddr4_ba[1]}]
set_property PACKAGE_PIN D25 [get_ports {c0_ddr4_bg[0]}]
set_property PACKAGE_PIN K25 [get_ports {c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN C23 [get_ports {c0_ddr4_cke[0]}]
set_property PACKAGE_PIN E22 [get_ports {c0_ddr4_adr[14]}]
set_property PACKAGE_PIN B22 [get_ports {c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN B26 [get_ports {c0_ddr4_odt[0]}]

set_property PACKAGE_PIN L14 [get_ports {c0_ddr4_dq[0]}]
set_property PACKAGE_PIN P15 [get_ports {c0_ddr4_dq[1]}]
set_property PACKAGE_PIN M14 [get_ports {c0_ddr4_dq[2]}]
set_property PACKAGE_PIN P14 [get_ports {c0_ddr4_dq[3]}]
set_property PACKAGE_PIN M16 [get_ports {c0_ddr4_dq[4]}]
set_property PACKAGE_PIN R15 [get_ports {c0_ddr4_dq[5]}]
set_property PACKAGE_PIN N16 [get_ports {c0_ddr4_dq[6]}]
set_property PACKAGE_PIN N14 [get_ports {c0_ddr4_dq[7]}]
set_property PACKAGE_PIN J14 [get_ports {c0_ddr4_dq[8]}]
set_property PACKAGE_PIN K15 [get_ports {c0_ddr4_dq[9]}]
set_property PACKAGE_PIN H13 [get_ports {c0_ddr4_dq[10]}]
set_property PACKAGE_PIN J13 [get_ports {c0_ddr4_dq[11]}]
set_property PACKAGE_PIN J16 [get_ports {c0_ddr4_dq[12]}]
set_property PACKAGE_PIN K16 [get_ports {c0_ddr4_dq[13]}]
set_property PACKAGE_PIN J15 [get_ports {c0_ddr4_dq[14]}]
set_property PACKAGE_PIN H14 [get_ports {c0_ddr4_dq[15]}]

set_property PACKAGE_PIN N21 [get_ports {c0_ddr4_dq[16]}]
set_property PACKAGE_PIN N18 [get_ports {c0_ddr4_dq[17]}]
set_property PACKAGE_PIN M20 [get_ports {c0_ddr4_dq[18]}]
set_property PACKAGE_PIN M19 [get_ports {c0_ddr4_dq[19]}]
set_property PACKAGE_PIN P20 [get_ports {c0_ddr4_dq[20]}]
set_property PACKAGE_PIN P18 [get_ports {c0_ddr4_dq[21]}]
set_property PACKAGE_PIN R20 [get_ports {c0_ddr4_dq[22]}]
set_property PACKAGE_PIN M21 [get_ports {c0_ddr4_dq[23]}]
set_property PACKAGE_PIN J19 [get_ports {c0_ddr4_dq[24]}]
set_property PACKAGE_PIN L18 [get_ports {c0_ddr4_dq[25]}]
set_property PACKAGE_PIN J18 [get_ports {c0_ddr4_dq[26]}]
set_property PACKAGE_PIN K18 [get_ports {c0_ddr4_dq[27]}]
set_property PACKAGE_PIN J20 [get_ports {c0_ddr4_dq[28]}]
set_property PACKAGE_PIN L19 [get_ports {c0_ddr4_dq[29]}]
set_property PACKAGE_PIN K20 [get_ports {c0_ddr4_dq[30]}]
set_property PACKAGE_PIN L20 [get_ports {c0_ddr4_dq[31]}]

set_property PACKAGE_PIN E15 [get_ports {c0_ddr4_dq[32]}]
set_property PACKAGE_PIN F15 [get_ports {c0_ddr4_dq[33]}]
set_property PACKAGE_PIN D15 [get_ports {c0_ddr4_dq[34]}]
set_property PACKAGE_PIN E13 [get_ports {c0_ddr4_dq[35]}]
set_property PACKAGE_PIN D16 [get_ports {c0_ddr4_dq[36]}]
set_property PACKAGE_PIN G15 [get_ports {c0_ddr4_dq[37]}]
set_property PACKAGE_PIN E16 [get_ports {c0_ddr4_dq[38]}]
set_property PACKAGE_PIN F13 [get_ports {c0_ddr4_dq[39]}]
set_property PACKAGE_PIN B16 [get_ports {c0_ddr4_dq[40]}]
set_property PACKAGE_PIN A14 [get_ports {c0_ddr4_dq[41]}]
set_property PACKAGE_PIN A17 [get_ports {c0_ddr4_dq[42]}]
set_property PACKAGE_PIN C14 [get_ports {c0_ddr4_dq[43]}]
set_property PACKAGE_PIN C16 [get_ports {c0_ddr4_dq[44]}]
set_property PACKAGE_PIN B14 [get_ports {c0_ddr4_dq[45]}]
set_property PACKAGE_PIN B17 [get_ports {c0_ddr4_dq[46]}]
set_property PACKAGE_PIN A13 [get_ports {c0_ddr4_dq[47]}]


set_property PACKAGE_PIN E20 [get_ports {c0_ddr4_dq[48]}]
set_property PACKAGE_PIN F17 [get_ports {c0_ddr4_dq[49]}]
set_property PACKAGE_PIN G20 [get_ports {c0_ddr4_dq[50]}]
set_property PACKAGE_PIN F19 [get_ports {c0_ddr4_dq[51]}]
set_property PACKAGE_PIN F20 [get_ports {c0_ddr4_dq[52]}]
set_property PACKAGE_PIN G19 [get_ports {c0_ddr4_dq[53]}]
set_property PACKAGE_PIN E21 [get_ports {c0_ddr4_dq[54]}]
set_property PACKAGE_PIN F18 [get_ports {c0_ddr4_dq[55]}]
set_property PACKAGE_PIN C21 [get_ports {c0_ddr4_dq[56]}]
set_property PACKAGE_PIN A19 [get_ports {c0_ddr4_dq[57]}]
set_property PACKAGE_PIN B21 [get_ports {c0_ddr4_dq[58]}]
set_property PACKAGE_PIN A20 [get_ports {c0_ddr4_dq[59]}]
set_property PACKAGE_PIN D21 [get_ports {c0_ddr4_dq[60]}]
set_property PACKAGE_PIN B19 [get_ports {c0_ddr4_dq[61]}]
set_property PACKAGE_PIN B20 [get_ports {c0_ddr4_dq[62]}]
set_property PACKAGE_PIN D20 [get_ports {c0_ddr4_dq[63]}]

set_property PACKAGE_PIN N22 [get_ports {c0_ddr4_dq[64]}]
set_property PACKAGE_PIN P23 [get_ports {c0_ddr4_dq[65]}]
set_property PACKAGE_PIN M22 [get_ports {c0_ddr4_dq[66]}]
set_property PACKAGE_PIN P25 [get_ports {c0_ddr4_dq[67]}]
set_property PACKAGE_PIN M24 [get_ports {c0_ddr4_dq[68]}]
set_property PACKAGE_PIN R25 [get_ports {c0_ddr4_dq[69]}]
set_property PACKAGE_PIN M25 [get_ports {c0_ddr4_dq[70]}]
set_property PACKAGE_PIN N23 [get_ports {c0_ddr4_dq[71]}]

set_property PACKAGE_PIN P13 [get_ports {c0_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN L13 [get_ports {c0_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN N17 [get_ports {c0_ddr4_dm_dbi_n[2]}]
set_property PACKAGE_PIN L17 [get_ports {c0_ddr4_dm_dbi_n[3]}]
set_property PACKAGE_PIN G14 [get_ports {c0_ddr4_dm_dbi_n[4]}]
set_property PACKAGE_PIN D13 [get_ports {c0_ddr4_dm_dbi_n[5]}]
set_property PACKAGE_PIN H19 [get_ports {c0_ddr4_dm_dbi_n[6]}]
set_property PACKAGE_PIN D19 [get_ports {c0_ddr4_dm_dbi_n[7]}]
set_property PACKAGE_PIN R21 [get_ports {c0_ddr4_dm_dbi_n[8]}]

set_property PACKAGE_PIN R16 [get_ports {c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN H17 [get_ports {c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN P19 [get_ports {c0_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN J21 [get_ports {c0_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN G17 [get_ports {c0_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN B15 [get_ports {c0_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN E18 [get_ports {c0_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN D18 [get_ports {c0_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN P24 [get_ports {c0_ddr4_dqs_t[8]}]

# DDR4 C1
set_property PACKAGE_PIN J26 [get_ports c1_sys_clk_p]
set_property PACKAGE_PIN G27 [get_ports {c1_ddr4_adr[0]}]
set_property PACKAGE_PIN H28 [get_ports {c1_ddr4_adr[1]}]
set_property PACKAGE_PIN H27 [get_ports {c1_ddr4_adr[2]}]
set_property PACKAGE_PIN L28 [get_ports {c1_ddr4_adr[3]}]
set_property PACKAGE_PIN F29 [get_ports {c1_ddr4_adr[4]}]
set_property PACKAGE_PIN J28 [get_ports {c1_ddr4_adr[5]}]
set_property PACKAGE_PIN F28 [get_ports {c1_ddr4_adr[6]}]
set_property PACKAGE_PIN L27 [get_ports {c1_ddr4_adr[7]}]
set_property PACKAGE_PIN F27 [get_ports {c1_ddr4_adr[8]}]
set_property PACKAGE_PIN K28 [get_ports {c1_ddr4_adr[9]}]
set_property PACKAGE_PIN G29 [get_ports {c1_ddr4_adr[10]}]
set_property PACKAGE_PIN G26 [get_ports {c1_ddr4_adr[11]}]
set_property PACKAGE_PIN L29 [get_ports {c1_ddr4_adr[12]}]
set_property PACKAGE_PIN M27 [get_ports {c1_ddr4_adr[13]}]
set_property PACKAGE_PIN J29 [get_ports {c1_ddr4_adr[14]}]
set_property PACKAGE_PIN M29 [get_ports {c1_ddr4_adr[15]}]
set_property PACKAGE_PIN H29 [get_ports {c1_ddr4_adr[16]}]
set_property PACKAGE_PIN E27 [get_ports {c1_ddr4_ba[0]}]
set_property PACKAGE_PIN E28 [get_ports {c1_ddr4_ba[1]}]
set_property PACKAGE_PIN D28 [get_ports {c1_ddr4_bg[0]}]
set_property PACKAGE_PIN K26 [get_ports {c1_ddr4_ck_t[0]}]

set_property PACKAGE_PIN C29 [get_ports {c1_ddr4_cke[0]}]
set_property PACKAGE_PIN A28 [get_ports c1_ddr4_act_n]
set_property PACKAGE_PIN B29 [get_ports c1_ddr4_reset_n]
set_property PACKAGE_PIN D30 [get_ports {c1_ddr4_odt[0]}]
set_property PACKAGE_PIN B27 [get_ports {c1_ddr4_cs_n[0]}]


set_property PACKAGE_PIN D39 [get_ports {c1_ddr4_dq[0]}]
set_property PACKAGE_PIN C39 [get_ports {c1_ddr4_dq[1]}]
set_property PACKAGE_PIN B40 [get_ports {c1_ddr4_dq[2]}]
set_property PACKAGE_PIN A40 [get_ports {c1_ddr4_dq[3]}]
set_property PACKAGE_PIN E38 [get_ports {c1_ddr4_dq[4]}]
set_property PACKAGE_PIN D38 [get_ports {c1_ddr4_dq[5]}]
set_property PACKAGE_PIN E39 [get_ports {c1_ddr4_dq[6]}]
set_property PACKAGE_PIN C38 [get_ports {c1_ddr4_dq[7]}]
set_property PACKAGE_PIN E35 [get_ports {c1_ddr4_dq[8]}]
set_property PACKAGE_PIN A35 [get_ports {c1_ddr4_dq[9]}]
set_property PACKAGE_PIN D36 [get_ports {c1_ddr4_dq[10]}]
set_property PACKAGE_PIN A38 [get_ports {c1_ddr4_dq[11]}]
set_property PACKAGE_PIN E36 [get_ports {c1_ddr4_dq[12]}]
set_property PACKAGE_PIN B35 [get_ports {c1_ddr4_dq[13]}]
set_property PACKAGE_PIN D35 [get_ports {c1_ddr4_dq[14]}]
set_property PACKAGE_PIN A37 [get_ports {c1_ddr4_dq[15]}]



set_property PACKAGE_PIN L32 [get_ports {c1_ddr4_dq[16]}]
set_property PACKAGE_PIN K32 [get_ports {c1_ddr4_dq[17]}]
set_property PACKAGE_PIN L33 [get_ports {c1_ddr4_dq[18]}]
set_property PACKAGE_PIN K31 [get_ports {c1_ddr4_dq[19]}]
set_property PACKAGE_PIN L30 [get_ports {c1_ddr4_dq[20]}]
set_property PACKAGE_PIN J31 [get_ports {c1_ddr4_dq[21]}]
set_property PACKAGE_PIN M30 [get_ports {c1_ddr4_dq[22]}]
set_property PACKAGE_PIN K33 [get_ports {c1_ddr4_dq[23]}]
set_property PACKAGE_PIN C33 [get_ports {c1_ddr4_dq[24]}]
set_property PACKAGE_PIN B32 [get_ports {c1_ddr4_dq[25]}]
set_property PACKAGE_PIN C34 [get_ports {c1_ddr4_dq[26]}]
set_property PACKAGE_PIN C32 [get_ports {c1_ddr4_dq[27]}]
set_property PACKAGE_PIN D33 [get_ports {c1_ddr4_dq[28]}]
set_property PACKAGE_PIN C31 [get_ports {c1_ddr4_dq[29]}]
set_property PACKAGE_PIN D34 [get_ports {c1_ddr4_dq[30]}]
set_property PACKAGE_PIN D31 [get_ports {c1_ddr4_dq[31]}]


set_property PACKAGE_PIN J36 [get_ports {c1_ddr4_dq[32]}]
set_property PACKAGE_PIN G37 [get_ports {c1_ddr4_dq[33]}]
set_property PACKAGE_PIN G34 [get_ports {c1_ddr4_dq[34]}]
set_property PACKAGE_PIN F34 [get_ports {c1_ddr4_dq[35]}]
set_property PACKAGE_PIN J35 [get_ports {c1_ddr4_dq[36]}]
set_property PACKAGE_PIN F37 [get_ports {c1_ddr4_dq[37]}]
set_property PACKAGE_PIN H34 [get_ports {c1_ddr4_dq[38]}]
set_property PACKAGE_PIN F35 [get_ports {c1_ddr4_dq[39]}]
set_property PACKAGE_PIN H32 [get_ports {c1_ddr4_dq[40]}]
set_property PACKAGE_PIN E32 [get_ports {c1_ddr4_dq[41]}]
set_property PACKAGE_PIN G31 [get_ports {c1_ddr4_dq[42]}]
set_property PACKAGE_PIN F32 [get_ports {c1_ddr4_dq[43]}]
set_property PACKAGE_PIN H31 [get_ports {c1_ddr4_dq[44]}]
set_property PACKAGE_PIN E33 [get_ports {c1_ddr4_dq[45]}]
set_property PACKAGE_PIN G32 [get_ports {c1_ddr4_dq[46]}]
set_property PACKAGE_PIN F33 [get_ports {c1_ddr4_dq[47]}]


set_property PACKAGE_PIN V31 [get_ports {c1_ddr4_dq[48]}]
set_property PACKAGE_PIN U32 [get_ports {c1_ddr4_dq[49]}]
set_property PACKAGE_PIN U31 [get_ports {c1_ddr4_dq[50]}]
set_property PACKAGE_PIN T32 [get_ports {c1_ddr4_dq[51]}]
set_property PACKAGE_PIN T30 [get_ports {c1_ddr4_dq[52]}]
set_property PACKAGE_PIN T33 [get_ports {c1_ddr4_dq[53]}]
set_property PACKAGE_PIN U30 [get_ports {c1_ddr4_dq[54]}]
set_property PACKAGE_PIN R33 [get_ports {c1_ddr4_dq[55]}]
set_property PACKAGE_PIN R32 [get_ports {c1_ddr4_dq[56]}]
set_property PACKAGE_PIN N32 [get_ports {c1_ddr4_dq[57]}]
set_property PACKAGE_PIN N31 [get_ports {c1_ddr4_dq[58]}]
set_property PACKAGE_PIN N34 [get_ports {c1_ddr4_dq[59]}]
set_property PACKAGE_PIN R31 [get_ports {c1_ddr4_dq[60]}]
set_property PACKAGE_PIN P31 [get_ports {c1_ddr4_dq[61]}]
set_property PACKAGE_PIN N33 [get_ports {c1_ddr4_dq[62]}]
set_property PACKAGE_PIN P34 [get_ports {c1_ddr4_dq[63]}]

set_property PACKAGE_PIN T27 [get_ports {c1_ddr4_dq[64]}]
set_property PACKAGE_PIN R27 [get_ports {c1_ddr4_dq[65]}]
set_property PACKAGE_PIN T26 [get_ports {c1_ddr4_dq[66]}]
set_property PACKAGE_PIN R26 [get_ports {c1_ddr4_dq[67]}]
set_property PACKAGE_PIN P28 [get_ports {c1_ddr4_dq[68]}]
set_property PACKAGE_PIN N28 [get_ports {c1_ddr4_dq[69]}]
set_property PACKAGE_PIN P26 [get_ports {c1_ddr4_dq[70]}]
set_property PACKAGE_PIN N26 [get_ports {c1_ddr4_dq[71]}]

set_property PACKAGE_PIN E40 [get_ports {c1_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN C36 [get_ports {c1_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN M31 [get_ports {c1_ddr4_dm_dbi_n[2]}]
set_property PACKAGE_PIN B34 [get_ports {c1_ddr4_dm_dbi_n[3]}]
set_property PACKAGE_PIN H37 [get_ports {c1_ddr4_dm_dbi_n[4]}]
set_property PACKAGE_PIN G30 [get_ports {c1_ddr4_dm_dbi_n[5]}]
set_property PACKAGE_PIN U34 [get_ports {c1_ddr4_dm_dbi_n[6]}]
set_property PACKAGE_PIN R30 [get_ports {c1_ddr4_dm_dbi_n[7]}]
set_property PACKAGE_PIN T28 [get_ports {c1_ddr4_dm_dbi_n[8]}]

set_property PACKAGE_PIN B39 [get_ports {c1_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN B36 [get_ports {c1_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN K30 [get_ports {c1_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN A32 [get_ports {c1_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN H36 [get_ports {c1_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN J33 [get_ports {c1_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN V32 [get_ports {c1_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN M34 [get_ports {c1_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN P29 [get_ports {c1_ddr4_dqs_t[8]}]

# DDR4 C2

set_property PACKAGE_PIN AE31 [get_ports c2_sys_clk_p]
set_property PACKAGE_PIN AH33 [get_ports {c2_ddr4_adr[0]}]
set_property PACKAGE_PIN AF34 [get_ports {c2_ddr4_adr[1]}]
set_property PACKAGE_PIN AD33 [get_ports {c2_ddr4_adr[2]}]
set_property PACKAGE_PIN AE33 [get_ports {c2_ddr4_adr[3]}]
set_property PACKAGE_PIN AJ34 [get_ports {c2_ddr4_adr[4]}]
set_property PACKAGE_PIN AD31 [get_ports {c2_ddr4_adr[5]}]
set_property PACKAGE_PIN AG32 [get_ports {c2_ddr4_adr[6]}]
set_property PACKAGE_PIN AF30 [get_ports {c2_ddr4_adr[7]}]
set_property PACKAGE_PIN AF32 [get_ports {c2_ddr4_adr[8]}]
set_property PACKAGE_PIN AE30 [get_ports {c2_ddr4_adr[9]}]
set_property PACKAGE_PIN AJ33 [get_ports {c2_ddr4_adr[10]}]
set_property PACKAGE_PIN AC32 [get_ports {c2_ddr4_adr[11]}]
set_property PACKAGE_PIN AF33 [get_ports {c2_ddr4_adr[12]}]
set_property PACKAGE_PIN AC31 [get_ports {c2_ddr4_adr[13]}]
set_property PACKAGE_PIN AG31 [get_ports {c2_ddr4_adr[14]}]
set_property PACKAGE_PIN AG34 [get_ports {c2_ddr4_adr[15]}]
set_property PACKAGE_PIN AH34 [get_ports {c2_ddr4_adr[16]}]
set_property PACKAGE_PIN AC33 [get_ports {c2_ddr4_ba[0]}]
set_property PACKAGE_PIN AC34 [get_ports {c2_ddr4_ba[1]}]
set_property PACKAGE_PIN AD34 [get_ports {c2_ddr4_bg[0]}]
set_property PACKAGE_PIN AH31 [get_ports {c2_ddr4_ck_t[0]}]

set_property PACKAGE_PIN AB34 [get_ports {c2_ddr4_cke[0]}]
set_property PACKAGE_PIN Y31 [get_ports c2_ddr4_act_n]
set_property PACKAGE_PIN Y32 [get_ports c2_ddr4_reset_n]
set_property PACKAGE_PIN Y30 [get_ports {c2_ddr4_odt[0]}]
set_property PACKAGE_PIN AA33 [get_ports {c2_ddr4_cs_n[0]}]


set_property PACKAGE_PIN AK31 [get_ports {c2_ddr4_dq[0]}]
set_property PACKAGE_PIN AG29 [get_ports {c2_ddr4_dq[1]}]
set_property PACKAGE_PIN AJ30 [get_ports {c2_ddr4_dq[2]}]
set_property PACKAGE_PIN AJ31 [get_ports {c2_ddr4_dq[3]}]
set_property PACKAGE_PIN AJ29 [get_ports {c2_ddr4_dq[4]}]
set_property PACKAGE_PIN AJ28 [get_ports {c2_ddr4_dq[5]}]
set_property PACKAGE_PIN AK28 [get_ports {c2_ddr4_dq[6]}]
set_property PACKAGE_PIN AG30 [get_ports {c2_ddr4_dq[7]}]
set_property PACKAGE_PIN AP33 [get_ports {c2_ddr4_dq[8]}]
set_property PACKAGE_PIN AM34 [get_ports {c2_ddr4_dq[9]}]
set_property PACKAGE_PIN AP34 [get_ports {c2_ddr4_dq[10]}]
set_property PACKAGE_PIN AL34 [get_ports {c2_ddr4_dq[11]}]
set_property PACKAGE_PIN AR33 [get_ports {c2_ddr4_dq[12]}]
set_property PACKAGE_PIN AM32 [get_ports {c2_ddr4_dq[13]}]
set_property PACKAGE_PIN AN34 [get_ports {c2_ddr4_dq[14]}]
set_property PACKAGE_PIN AL32 [get_ports {c2_ddr4_dq[15]}]


set_property PACKAGE_PIN AW31 [get_ports {c2_ddr4_dq[16]}]
set_property PACKAGE_PIN AU31 [get_ports {c2_ddr4_dq[17]}]
set_property PACKAGE_PIN AV31 [get_ports {c2_ddr4_dq[18]}]
set_property PACKAGE_PIN AU32 [get_ports {c2_ddr4_dq[19]}]
set_property PACKAGE_PIN AT29 [get_ports {c2_ddr4_dq[20]}]
set_property PACKAGE_PIN AU30 [get_ports {c2_ddr4_dq[21]}]
set_property PACKAGE_PIN AV32 [get_ports {c2_ddr4_dq[22]}]
set_property PACKAGE_PIN AT30 [get_ports {c2_ddr4_dq[23]}]
set_property PACKAGE_PIN AP29 [get_ports {c2_ddr4_dq[24]}]
set_property PACKAGE_PIN AN31 [get_ports {c2_ddr4_dq[25]}]
set_property PACKAGE_PIN AR30 [get_ports {c2_ddr4_dq[26]}]
set_property PACKAGE_PIN AM31 [get_ports {c2_ddr4_dq[27]}]
set_property PACKAGE_PIN AN29 [get_ports {c2_ddr4_dq[28]}]
set_property PACKAGE_PIN AL29 [get_ports {c2_ddr4_dq[29]}]
set_property PACKAGE_PIN AP30 [get_ports {c2_ddr4_dq[30]}]
set_property PACKAGE_PIN AL30 [get_ports {c2_ddr4_dq[31]}]


set_property PACKAGE_PIN BE38 [get_ports {c2_ddr4_dq[32]}]
set_property PACKAGE_PIN BF38 [get_ports {c2_ddr4_dq[33]}]
set_property PACKAGE_PIN BC38 [get_ports {c2_ddr4_dq[34]}]
set_property PACKAGE_PIN BD39 [get_ports {c2_ddr4_dq[35]}]
set_property PACKAGE_PIN BF37 [get_ports {c2_ddr4_dq[36]}]
set_property PACKAGE_PIN BB38 [get_ports {c2_ddr4_dq[37]}]
set_property PACKAGE_PIN BE37 [get_ports {c2_ddr4_dq[38]}]
set_property PACKAGE_PIN BC39 [get_ports {c2_ddr4_dq[39]}]
set_property PACKAGE_PIN BE35 [get_ports {c2_ddr4_dq[40]}]
set_property PACKAGE_PIN BB36 [get_ports {c2_ddr4_dq[41]}]
set_property PACKAGE_PIN BE36 [get_ports {c2_ddr4_dq[42]}]
set_property PACKAGE_PIN BA35 [get_ports {c2_ddr4_dq[43]}]
set_property PACKAGE_PIN BD35 [get_ports {c2_ddr4_dq[44]}]
set_property PACKAGE_PIN BB35 [get_ports {c2_ddr4_dq[45]}]
set_property PACKAGE_PIN BD36 [get_ports {c2_ddr4_dq[46]}]
set_property PACKAGE_PIN BC36 [get_ports {c2_ddr4_dq[47]}]


set_property PACKAGE_PIN AY35 [get_ports {c2_ddr4_dq[48]}]
set_property PACKAGE_PIN AW34 [get_ports {c2_ddr4_dq[49]}]
set_property PACKAGE_PIN AY36 [get_ports {c2_ddr4_dq[50]}]
set_property PACKAGE_PIN AV34 [get_ports {c2_ddr4_dq[51]}]
set_property PACKAGE_PIN AY33 [get_ports {c2_ddr4_dq[52]}]
set_property PACKAGE_PIN AV33 [get_ports {c2_ddr4_dq[53]}]
set_property PACKAGE_PIN BA33 [get_ports {c2_ddr4_dq[54]}]
set_property PACKAGE_PIN AW33 [get_ports {c2_ddr4_dq[55]}]
set_property PACKAGE_PIN BB29 [get_ports {c2_ddr4_dq[56]}]
set_property PACKAGE_PIN AY31 [get_ports {c2_ddr4_dq[57]}]
set_property PACKAGE_PIN AY30 [get_ports {c2_ddr4_dq[58]}]
set_property PACKAGE_PIN BB31 [get_ports {c2_ddr4_dq[59]}]
set_property PACKAGE_PIN BA29 [get_ports {c2_ddr4_dq[60]}]
set_property PACKAGE_PIN AY32 [get_ports {c2_ddr4_dq[61]}]
set_property PACKAGE_PIN BA30 [get_ports {c2_ddr4_dq[62]}]
set_property PACKAGE_PIN BB30 [get_ports {c2_ddr4_dq[63]}]

set_property PACKAGE_PIN BE30 [get_ports {c2_ddr4_dq[64]}]
set_property PACKAGE_PIN BE31 [get_ports {c2_ddr4_dq[65]}]
set_property PACKAGE_PIN BF30 [get_ports {c2_ddr4_dq[66]}]
set_property PACKAGE_PIN BE32 [get_ports {c2_ddr4_dq[67]}]
set_property PACKAGE_PIN BD29 [get_ports {c2_ddr4_dq[68]}]
set_property PACKAGE_PIN BD33 [get_ports {c2_ddr4_dq[69]}]
set_property PACKAGE_PIN BC29 [get_ports {c2_ddr4_dq[70]}]
set_property PACKAGE_PIN BE33 [get_ports {c2_ddr4_dq[71]}]

set_property PACKAGE_PIN AJ27 [get_ports {c2_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN AT33 [get_ports {c2_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN AW29 [get_ports {c2_ddr4_dm_dbi_n[2]}]
set_property PACKAGE_PIN AP31 [get_ports {c2_ddr4_dm_dbi_n[3]}]
set_property PACKAGE_PIN BF39 [get_ports {c2_ddr4_dm_dbi_n[4]}]
set_property PACKAGE_PIN BC34 [get_ports {c2_ddr4_dm_dbi_n[5]}]
set_property PACKAGE_PIN BA34 [get_ports {c2_ddr4_dm_dbi_n[6]}]
set_property PACKAGE_PIN BC31 [get_ports {c2_ddr4_dm_dbi_n[7]}]
set_property PACKAGE_PIN BF32 [get_ports {c2_ddr4_dm_dbi_n[8]}]


set_property PACKAGE_PIN AH28 [get_ports {c2_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN AN32 [get_ports {c2_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AU29 [get_ports {c2_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN AM29 [get_ports {c2_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN BD40 [get_ports {c2_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN BB37 [get_ports {c2_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN AW35 [get_ports {c2_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN BA32 [get_ports {c2_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN BD30 [get_ports {c2_ddr4_dqs_t[8]}]

# DDR4 C3
set_property PACKAGE_PIN AW14 [get_ports c3_sys_clk_p]
set_property PACKAGE_PIN AV14 [get_ports {c3_ddr4_adr[0]}]
set_property PACKAGE_PIN BA14 [get_ports {c3_ddr4_adr[1]}]
set_property PACKAGE_PIN AW16 [get_ports {c3_ddr4_adr[2]}]
set_property PACKAGE_PIN AY11 [get_ports {c3_ddr4_adr[3]}]
set_property PACKAGE_PIN AV13 [get_ports {c3_ddr4_adr[4]}]
set_property PACKAGE_PIN BA15 [get_ports {c3_ddr4_adr[5]}]
set_property PACKAGE_PIN AU14 [get_ports {c3_ddr4_adr[6]}]
set_property PACKAGE_PIN AY13 [get_ports {c3_ddr4_adr[7]}]
set_property PACKAGE_PIN AU13 [get_ports {c3_ddr4_adr[8]}]
set_property PACKAGE_PIN AY15 [get_ports {c3_ddr4_adr[9]}]
set_property PACKAGE_PIN AY12 [get_ports {c3_ddr4_adr[10]}]
set_property PACKAGE_PIN AT15 [get_ports {c3_ddr4_adr[11]}]
set_property PACKAGE_PIN BA12 [get_ports {c3_ddr4_adr[12]}]
set_property PACKAGE_PIN AW15 [get_ports {c3_ddr4_adr[13]}]
set_property PACKAGE_PIN BA13 [get_ports {c3_ddr4_adr[14]}]
set_property PACKAGE_PIN AY16 [get_ports {c3_ddr4_adr[15]}]
set_property PACKAGE_PIN BB12 [get_ports {c3_ddr4_adr[16]}]
set_property PACKAGE_PIN AU15 [get_ports {c3_ddr4_ba[0]}]
set_property PACKAGE_PIN AU16 [get_ports {c3_ddr4_ba[1]}]
set_property PACKAGE_PIN AV16 [get_ports {c3_ddr4_bg[0]}]
set_property PACKAGE_PIN BB15 [get_ports {c3_ddr4_ck_t[0]}]

set_property PACKAGE_PIN AP14 [get_ports {c3_ddr4_cke[0]}]
set_property PACKAGE_PIN AR13 [get_ports c3_ddr4_act_n]
set_property PACKAGE_PIN AL15 [get_ports c3_ddr4_reset_n]
set_property PACKAGE_PIN AN13 [get_ports {c3_ddr4_odt[0]}]
set_property PACKAGE_PIN AR15 [get_ports {c3_ddr4_cs_n[0]}]


set_property PACKAGE_PIN AY26 [get_ports {c3_ddr4_dq[0]}]
set_property PACKAGE_PIN BB26 [get_ports {c3_ddr4_dq[1]}]
set_property PACKAGE_PIN AY28 [get_ports {c3_ddr4_dq[2]}]
set_property PACKAGE_PIN BA27 [get_ports {c3_ddr4_dq[3]}]
set_property PACKAGE_PIN AW28 [get_ports {c3_ddr4_dq[4]}]
set_property PACKAGE_PIN BB27 [get_ports {c3_ddr4_dq[5]}]
set_property PACKAGE_PIN AY27 [get_ports {c3_ddr4_dq[6]}]
set_property PACKAGE_PIN BA28 [get_ports {c3_ddr4_dq[7]}]
set_property PACKAGE_PIN AM16 [get_ports {c3_ddr4_dq[8]}]
set_property PACKAGE_PIN AM19 [get_ports {c3_ddr4_dq[9]}]
set_property PACKAGE_PIN AP19 [get_ports {c3_ddr4_dq[10]}]
set_property PACKAGE_PIN AM20 [get_ports {c3_ddr4_dq[11]}]
set_property PACKAGE_PIN AN16 [get_ports {c3_ddr4_dq[12]}]
set_property PACKAGE_PIN AL20 [get_ports {c3_ddr4_dq[13]}]
set_property PACKAGE_PIN AN19 [get_ports {c3_ddr4_dq[14]}]
set_property PACKAGE_PIN AL19 [get_ports {c3_ddr4_dq[15]}]


set_property PACKAGE_PIN BE25 [get_ports {c3_ddr4_dq[16]}]
set_property PACKAGE_PIN BE28 [get_ports {c3_ddr4_dq[17]}]
set_property PACKAGE_PIN BF25 [get_ports {c3_ddr4_dq[18]}]
set_property PACKAGE_PIN BF27 [get_ports {c3_ddr4_dq[19]}]
set_property PACKAGE_PIN BC27 [get_ports {c3_ddr4_dq[20]}]
set_property PACKAGE_PIN BD28 [get_ports {c3_ddr4_dq[21]}]
set_property PACKAGE_PIN BC26 [get_ports {c3_ddr4_dq[22]}]
set_property PACKAGE_PIN BE27 [get_ports {c3_ddr4_dq[23]}]
set_property PACKAGE_PIN AV18 [get_ports {c3_ddr4_dq[24]}]
set_property PACKAGE_PIN AW18 [get_ports {c3_ddr4_dq[25]}]
set_property PACKAGE_PIN AW19 [get_ports {c3_ddr4_dq[26]}]
set_property PACKAGE_PIN AY18 [get_ports {c3_ddr4_dq[27]}]
set_property PACKAGE_PIN AW20 [get_ports {c3_ddr4_dq[28]}]
set_property PACKAGE_PIN BA18 [get_ports {c3_ddr4_dq[29]}]
set_property PACKAGE_PIN AV19 [get_ports {c3_ddr4_dq[30]}]
set_property PACKAGE_PIN AY20 [get_ports {c3_ddr4_dq[31]}]


set_property PACKAGE_PIN BC13 [get_ports {c3_ddr4_dq[32]}]
set_property PACKAGE_PIN BF15 [get_ports {c3_ddr4_dq[33]}]
set_property PACKAGE_PIN BD14 [get_ports {c3_ddr4_dq[34]}]
set_property PACKAGE_PIN BE16 [get_ports {c3_ddr4_dq[35]}]
set_property PACKAGE_PIN BC14 [get_ports {c3_ddr4_dq[36]}]
set_property PACKAGE_PIN BD15 [get_ports {c3_ddr4_dq[37]}]
set_property PACKAGE_PIN BE15 [get_ports {c3_ddr4_dq[38]}]
set_property PACKAGE_PIN BD16 [get_ports {c3_ddr4_dq[39]}]
set_property PACKAGE_PIN AR28 [get_ports {c3_ddr4_dq[40]}]
set_property PACKAGE_PIN AU27 [get_ports {c3_ddr4_dq[41]}]
set_property PACKAGE_PIN AT27 [get_ports {c3_ddr4_dq[42]}]
set_property PACKAGE_PIN AV27 [get_ports {c3_ddr4_dq[43]}]
set_property PACKAGE_PIN AR27 [get_ports {c3_ddr4_dq[44]}]
set_property PACKAGE_PIN AT28 [get_ports {c3_ddr4_dq[45]}]
set_property PACKAGE_PIN AU26 [get_ports {c3_ddr4_dq[46]}]
set_property PACKAGE_PIN AV28 [get_ports {c3_ddr4_dq[47]}]


set_property PACKAGE_PIN AR18 [get_ports {c3_ddr4_dq[48]}]
set_property PACKAGE_PIN AT18 [get_ports {c3_ddr4_dq[49]}]
set_property PACKAGE_PIN AU17 [get_ports {c3_ddr4_dq[50]}]
set_property PACKAGE_PIN AR20 [get_ports {c3_ddr4_dq[51]}]
set_property PACKAGE_PIN AP20 [get_ports {c3_ddr4_dq[52]}]
set_property PACKAGE_PIN AU20 [get_ports {c3_ddr4_dq[53]}]
set_property PACKAGE_PIN AP18 [get_ports {c3_ddr4_dq[54]}]
set_property PACKAGE_PIN AT20 [get_ports {c3_ddr4_dq[55]}]
set_property PACKAGE_PIN BB19 [get_ports {c3_ddr4_dq[56]}]
set_property PACKAGE_PIN BE18 [get_ports {c3_ddr4_dq[57]}]
set_property PACKAGE_PIN BC17 [get_ports {c3_ddr4_dq[58]}]
set_property PACKAGE_PIN BF18 [get_ports {c3_ddr4_dq[59]}]
set_property PACKAGE_PIN BB17 [get_ports {c3_ddr4_dq[60]}]
set_property PACKAGE_PIN BD18 [get_ports {c3_ddr4_dq[61]}]
set_property PACKAGE_PIN BC18 [get_ports {c3_ddr4_dq[62]}]
set_property PACKAGE_PIN BF19 [get_ports {c3_ddr4_dq[63]}]

set_property PACKAGE_PIN AL25 [get_ports {c3_ddr4_dq[64]}]
set_property PACKAGE_PIN AP28 [get_ports {c3_ddr4_dq[65]}]
set_property PACKAGE_PIN AN27 [get_ports {c3_ddr4_dq[66]}]
set_property PACKAGE_PIN AM27 [get_ports {c3_ddr4_dq[67]}]
set_property PACKAGE_PIN AM25 [get_ports {c3_ddr4_dq[68]}]
set_property PACKAGE_PIN AL28 [get_ports {c3_ddr4_dq[69]}]
set_property PACKAGE_PIN AN28 [get_ports {c3_ddr4_dq[70]}]
set_property PACKAGE_PIN AL27 [get_ports {c3_ddr4_dq[71]}]

set_property PACKAGE_PIN BA25 [get_ports {c3_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN AN18 [get_ports {c3_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN BF28 [get_ports {c3_ddr4_dm_dbi_n[2]}]
set_property PACKAGE_PIN AY17 [get_ports {c3_ddr4_dm_dbi_n[3]}]
set_property PACKAGE_PIN BF14 [get_ports {c3_ddr4_dm_dbi_n[4]}]
set_property PACKAGE_PIN AV26 [get_ports {c3_ddr4_dm_dbi_n[5]}]
set_property PACKAGE_PIN AT19 [get_ports {c3_ddr4_dm_dbi_n[6]}]
set_property PACKAGE_PIN BE17 [get_ports {c3_ddr4_dm_dbi_n[7]}]
set_property PACKAGE_PIN AP25 [get_ports {c3_ddr4_dm_dbi_n[8]}]

set_property PACKAGE_PIN AW25 [get_ports {c3_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN AL17 [get_ports {c3_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN BD26 [get_ports {c3_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN AV21 [get_ports {c3_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN BD13 [get_ports {c3_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN AR25 [get_ports {c3_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN AR17 [get_ports {c3_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN BC19 [get_ports {c3_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN AM26 [get_ports {c3_ddr4_dqs_t[8]}]
