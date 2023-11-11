set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins ddr4_c0_inst/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins ddr4_c1_inst/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins ddr4_c2_inst/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins ddr4_c3_inst/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks qsfp0_mgt_refclk_1] 6.2
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 4.0
set_max_delay -datapath_only -from [get_clocks qsfp0_mgt_refclk_1] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks qsfp0_mgt_refclk_1] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 6.2
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 4.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks qsfp0_mgt_refclk_1] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks qsfp1_mgt_refclk_1] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp0_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]] 8.0
set_max_delay -datapath_only -from [get_clocks qsfp0_mgt_refclk_1] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks qsfp1_mgt_refclk_1] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT0]] 20.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 8.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clk_mmcm_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins pcie4_uscale_plus_inst/inst/pcie4_uscale_plus_0_gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] 20.0
set_max_delay -datapath_only -from [get_clocks qsfp0_mgt_refclk_1] -to [get_clocks -of_objects [get_pins {qsfp1_cmac_inst/gty_ch_1/xcvr_gty_com.cmac_gty_full_inst/inst/gen_gtwizard_gtye4_top.cmac_gty_full_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[28].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/RXOUTCLK}]] 6.2
