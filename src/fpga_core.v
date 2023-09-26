// SPDX-License-Identifier: BSD-2-Clause-Views
/*
 * Copyright (c) 2019-2023 The Regents of the University of California
 */

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * FPGA core logic
 */
module fpga_core #
(
    // FW and board IDs
    parameter FPGA_ID = 32'h4B57093,
    parameter FW_ID = 32'h00000000,
    parameter FW_VER = 32'h00_00_01_00,
    parameter BOARD_ID = 32'h10ee_90fa,
    parameter BOARD_VER = 32'h01_00_00_00,
    parameter BUILD_DATE = 32'd602976000,
    parameter GIT_HASH = 32'hdce357bf,
    parameter RELEASE_INFO = 32'h00000000,

    // Structural configuration
    parameter IF_COUNT = 2,
    parameter PORTS_PER_IF = 1,
    parameter SCHED_PER_IF = PORTS_PER_IF,
    parameter PORT_MASK = 0,

    // Clock configuration
    parameter CLK_PERIOD_NS_NUM = 4,
    parameter CLK_PERIOD_NS_DENOM = 1,

    // PTP configuration
    parameter PTP_CLK_PERIOD_NS_NUM = 1024,
    parameter PTP_CLK_PERIOD_NS_DENOM = 165,
    parameter PTP_TS_WIDTH = 96,
    parameter PTP_CLOCK_PIPELINE = 0,
    parameter PTP_CLOCK_CDC_PIPELINE = 0,
    parameter PTP_USE_SAMPLE_CLOCK = 1,
    parameter PTP_SEPARATE_RX_CLOCK = 0,
    parameter PTP_PORT_CDC_PIPELINE = 0,
    parameter PTP_PEROUT_ENABLE = 0,
    parameter PTP_PEROUT_COUNT = 1,

    // Queue manager configuration
    parameter EVENT_QUEUE_OP_TABLE_SIZE = 32,
    parameter TX_QUEUE_OP_TABLE_SIZE = 32,
    parameter RX_QUEUE_OP_TABLE_SIZE = 32,
    parameter CQ_OP_TABLE_SIZE = 32,
    parameter EQN_WIDTH = 5,
    parameter TX_QUEUE_INDEX_WIDTH = 13,
    parameter RX_QUEUE_INDEX_WIDTH = 8,
    parameter CQN_WIDTH = (TX_QUEUE_INDEX_WIDTH > RX_QUEUE_INDEX_WIDTH ? TX_QUEUE_INDEX_WIDTH : RX_QUEUE_INDEX_WIDTH) + 1,
    parameter EQ_PIPELINE = 3,
    parameter TX_QUEUE_PIPELINE = 3+(TX_QUEUE_INDEX_WIDTH > 12 ? TX_QUEUE_INDEX_WIDTH-12 : 0),
    parameter RX_QUEUE_PIPELINE = 3+(RX_QUEUE_INDEX_WIDTH > 12 ? RX_QUEUE_INDEX_WIDTH-12 : 0),
    parameter CQ_PIPELINE = 3+(CQN_WIDTH > 12 ? CQN_WIDTH-12 : 0),

    // TX and RX engine configuration
    parameter TX_DESC_TABLE_SIZE = 32,
    parameter RX_DESC_TABLE_SIZE = 32,
    parameter RX_INDIR_TBL_ADDR_WIDTH = RX_QUEUE_INDEX_WIDTH > 8 ? 8 : RX_QUEUE_INDEX_WIDTH,

    // Scheduler configuration
    parameter TX_SCHEDULER_OP_TABLE_SIZE = TX_DESC_TABLE_SIZE,
    parameter TX_SCHEDULER_PIPELINE = TX_QUEUE_PIPELINE,
    parameter TDMA_INDEX_WIDTH = 6,

    // Interface configuration
    parameter PTP_TS_ENABLE = 1,
    parameter TX_CPL_FIFO_DEPTH = 32,
    parameter TX_TAG_WIDTH = 16,
    parameter TX_CHECKSUM_ENABLE = 1,
    parameter RX_HASH_ENABLE = 1,
    parameter RX_CHECKSUM_ENABLE = 1,
    parameter TX_FIFO_DEPTH = 32768,
    parameter RX_FIFO_DEPTH = 131072,
    parameter MAX_TX_SIZE = 9214,
    parameter MAX_RX_SIZE = 9214,
    parameter TX_RAM_SIZE = 131072,
    parameter RX_RAM_SIZE = 131072,

    // RAM configuration
    parameter DDR_CH = 4,
    parameter DDR_ENABLE = 0,
    parameter AXI_DDR_DATA_WIDTH = 512,
    parameter AXI_DDR_ADDR_WIDTH = 34,
    parameter AXI_DDR_STRB_WIDTH = (AXI_DDR_DATA_WIDTH/8),
    parameter AXI_DDR_ID_WIDTH = 8,
    parameter AXI_DDR_MAX_BURST_LEN = 256,
    parameter AXI_DDR_NARROW_BURST = 0,

    // Application block configuration
    parameter APP_ID = 32'h00000000,
    parameter APP_ENABLE = 0,
    parameter APP_CTRL_ENABLE = 1,
    parameter APP_DMA_ENABLE = 1,
    parameter APP_AXIS_DIRECT_ENABLE = 1,
    parameter APP_AXIS_SYNC_ENABLE = 1,
    parameter APP_AXIS_IF_ENABLE = 1,
    parameter APP_STAT_ENABLE = 1,

    // DMA interface configuration
    parameter DMA_IMM_ENABLE = 0,
    parameter DMA_IMM_WIDTH = 32,
    parameter DMA_LEN_WIDTH = 16,
    parameter DMA_TAG_WIDTH = 16,
    parameter RAM_ADDR_WIDTH = $clog2(TX_RAM_SIZE > RX_RAM_SIZE ? TX_RAM_SIZE : RX_RAM_SIZE),
    parameter RAM_PIPELINE = 2,

    // PCIe interface configuration
    parameter AXIS_PCIE_DATA_WIDTH = 512,
    parameter AXIS_PCIE_KEEP_WIDTH = (AXIS_PCIE_DATA_WIDTH/32),
    parameter AXIS_PCIE_RC_USER_WIDTH = AXIS_PCIE_DATA_WIDTH < 512 ? 75 : 161,
    parameter AXIS_PCIE_RQ_USER_WIDTH = AXIS_PCIE_DATA_WIDTH < 512 ? 62 : 137,
    parameter AXIS_PCIE_CQ_USER_WIDTH = AXIS_PCIE_DATA_WIDTH < 512 ? 85 : 183,
    parameter AXIS_PCIE_CC_USER_WIDTH = AXIS_PCIE_DATA_WIDTH < 512 ? 33 : 81,
    parameter RC_STRADDLE = AXIS_PCIE_DATA_WIDTH >= 256,
    parameter RQ_STRADDLE = AXIS_PCIE_DATA_WIDTH >= 512,
    parameter CQ_STRADDLE = AXIS_PCIE_DATA_WIDTH >= 512,
    parameter CC_STRADDLE = AXIS_PCIE_DATA_WIDTH >= 512,
    parameter RQ_SEQ_NUM_WIDTH = AXIS_PCIE_RQ_USER_WIDTH == 60 ? 4 : 6,
    parameter PF_COUNT = 1,
    parameter VF_COUNT = 0,
    parameter PCIE_TAG_COUNT = 256,

    // Interrupt configuration
    parameter IRQ_INDEX_WIDTH = EQN_WIDTH,

    // AXI lite interface configuration (control)
    parameter AXIL_CTRL_DATA_WIDTH = 32,
    parameter AXIL_CTRL_ADDR_WIDTH = 24,

    // AXI lite interface configuration (application control)
    parameter AXIL_APP_CTRL_DATA_WIDTH = AXIL_CTRL_DATA_WIDTH,
    parameter AXIL_APP_CTRL_ADDR_WIDTH = 24,

    // Ethernet interface configuration
    parameter AXIS_ETH_DATA_WIDTH = 512,
    parameter AXIS_ETH_KEEP_WIDTH = AXIS_ETH_DATA_WIDTH/8,
    parameter AXIS_ETH_SYNC_DATA_WIDTH = AXIS_ETH_DATA_WIDTH,
    parameter AXIS_ETH_TX_USER_WIDTH = TX_TAG_WIDTH + 1,
    parameter AXIS_ETH_RX_USER_WIDTH = (PTP_TS_ENABLE ? PTP_TS_WIDTH : 0) + 1,
    parameter AXIS_ETH_TX_PIPELINE = 4,
    parameter AXIS_ETH_TX_FIFO_PIPELINE = 4,
    parameter AXIS_ETH_TX_TS_PIPELINE = 4,
    parameter AXIS_ETH_RX_PIPELINE = 4,
    parameter AXIS_ETH_RX_FIFO_PIPELINE = 4,

    // Statistics counter subsystem
    parameter STAT_ENABLE = 1,
    parameter STAT_DMA_ENABLE = 1,
    parameter STAT_PCIE_ENABLE = 1,
    parameter STAT_INC_WIDTH = 24,
    parameter STAT_ID_WIDTH = 12
)
(
    /*
     * Clock: 250 MHz
     * Synchronous reset
     */
    input  wire                               clk_250mhz,
    input  wire                               rst_250mhz,

    /*
     * PTP clock
     */
    input  wire                               ptp_clk,
    input  wire                               ptp_rst,
    input  wire                               ptp_sample_clk,

    /*
     * GPIO
     */
    input  wire [3:0]                         sw,
    output wire [2:0]                         led,

    /*
     * I2C
     */
    input  wire                               i2c_scl_i,
    output wire                               i2c_scl_o,
    output wire                               i2c_scl_t,
    input  wire                               i2c_sda_i,
    output wire                               i2c_sda_o,
    output wire                               i2c_sda_t,

    /*
     * PCIe
     */
    output wire [AXIS_PCIE_DATA_WIDTH-1:0]    m_axis_rq_tdata,
    output wire [AXIS_PCIE_KEEP_WIDTH-1:0]    m_axis_rq_tkeep,
    output wire                               m_axis_rq_tlast,
    input  wire                               m_axis_rq_tready,
    output wire [AXIS_PCIE_RQ_USER_WIDTH-1:0] m_axis_rq_tuser,
    output wire                               m_axis_rq_tvalid,

    input  wire [AXIS_PCIE_DATA_WIDTH-1:0]    s_axis_rc_tdata,
    input  wire [AXIS_PCIE_KEEP_WIDTH-1:0]    s_axis_rc_tkeep,
    input  wire                               s_axis_rc_tlast,
    output wire                               s_axis_rc_tready,
    input  wire [AXIS_PCIE_RC_USER_WIDTH-1:0] s_axis_rc_tuser,
    input  wire                               s_axis_rc_tvalid,

    input  wire [AXIS_PCIE_DATA_WIDTH-1:0]    s_axis_cq_tdata,
    input  wire [AXIS_PCIE_KEEP_WIDTH-1:0]    s_axis_cq_tkeep,
    input  wire                               s_axis_cq_tlast,
    output wire                               s_axis_cq_tready,
    input  wire [AXIS_PCIE_CQ_USER_WIDTH-1:0] s_axis_cq_tuser,
    input  wire                               s_axis_cq_tvalid,

    output wire [AXIS_PCIE_DATA_WIDTH-1:0]    m_axis_cc_tdata,
    output wire [AXIS_PCIE_KEEP_WIDTH-1:0]    m_axis_cc_tkeep,
    output wire                               m_axis_cc_tlast,
    input  wire                               m_axis_cc_tready,
    output wire [AXIS_PCIE_CC_USER_WIDTH-1:0] m_axis_cc_tuser,
    output wire                               m_axis_cc_tvalid,

    input  wire [RQ_SEQ_NUM_WIDTH-1:0]        s_axis_rq_seq_num_0,
    input  wire                               s_axis_rq_seq_num_valid_0,
    input  wire [RQ_SEQ_NUM_WIDTH-1:0]        s_axis_rq_seq_num_1,
    input  wire                               s_axis_rq_seq_num_valid_1,

    input  wire [1:0]                         pcie_tfc_nph_av,
    input  wire [1:0]                         pcie_tfc_npd_av,

    input  wire [2:0]                         cfg_max_payload,
    input  wire [2:0]                         cfg_max_read_req,
    input  wire [3:0]                         cfg_rcb_status,

    output wire [9:0]                         cfg_mgmt_addr,
    output wire [7:0]                         cfg_mgmt_function_number,
    output wire                               cfg_mgmt_write,
    output wire [31:0]                        cfg_mgmt_write_data,
    output wire [3:0]                         cfg_mgmt_byte_enable,
    output wire                               cfg_mgmt_read,
    input  wire [31:0]                        cfg_mgmt_read_data,
    input  wire                               cfg_mgmt_read_write_done,

    input  wire [7:0]                         cfg_fc_ph,
    input  wire [11:0]                        cfg_fc_pd,
    input  wire [7:0]                         cfg_fc_nph,
    input  wire [11:0]                        cfg_fc_npd,
    input  wire [7:0]                         cfg_fc_cplh,
    input  wire [11:0]                        cfg_fc_cpld,
    output wire [2:0]                         cfg_fc_sel,

    input  wire [3:0]                         cfg_interrupt_msix_enable,
    input  wire [3:0]                         cfg_interrupt_msix_mask,
    input  wire [251:0]                       cfg_interrupt_msix_vf_enable,
    input  wire [251:0]                       cfg_interrupt_msix_vf_mask,
    output wire [63:0]                        cfg_interrupt_msix_address,
    output wire [31:0]                        cfg_interrupt_msix_data,
    output wire                               cfg_interrupt_msix_int,
    output wire [1:0]                         cfg_interrupt_msix_vec_pending,
    input  wire                               cfg_interrupt_msix_vec_pending_status,
    input  wire                               cfg_interrupt_msix_sent,
    input  wire                               cfg_interrupt_msix_fail,
    output wire [7:0]                         cfg_interrupt_msi_function_number,

    output wire                               status_error_cor,
    output wire                               status_error_uncor,

    /*
     * Ethernet: QSFP28
     */
    input  wire                               qsfp0_tx_clk,
    input  wire                               qsfp0_tx_rst,

    output wire [AXIS_ETH_DATA_WIDTH-1:0]     qsfp0_tx_axis_tdata,
    output wire [AXIS_ETH_KEEP_WIDTH-1:0]     qsfp0_tx_axis_tkeep,
    output wire                               qsfp0_tx_axis_tvalid,
    input  wire                               qsfp0_tx_axis_tready,
    output wire                               qsfp0_tx_axis_tlast,
    output wire [16+1-1:0]                    qsfp0_tx_axis_tuser,

    output wire [79:0]                        qsfp0_tx_ptp_time,
    input  wire [79:0]                        qsfp0_tx_ptp_ts,
    input  wire [15:0]                        qsfp0_tx_ptp_ts_tag,
    input  wire                               qsfp0_tx_ptp_ts_valid,

    input  wire                               qsfp0_rx_clk,
    input  wire                               qsfp0_rx_rst,

    input  wire [AXIS_ETH_DATA_WIDTH-1:0]     qsfp0_rx_axis_tdata,
    input  wire [AXIS_ETH_KEEP_WIDTH-1:0]     qsfp0_rx_axis_tkeep,
    input  wire                               qsfp0_rx_axis_tvalid,
    input  wire                               qsfp0_rx_axis_tlast,
    input  wire [80+1-1:0]                    qsfp0_rx_axis_tuser,

    input  wire                               qsfp0_rx_ptp_clk,
    input  wire                               qsfp0_rx_ptp_rst,
    output wire [79:0]                        qsfp0_rx_ptp_time,

    input  wire                               qsfp0_rx_status,

    input  wire                               qsfp0_drp_clk,
    input  wire                               qsfp0_drp_rst,
    output wire [23:0]                        qsfp0_drp_addr,
    output wire [15:0]                        qsfp0_drp_di,
    output wire                               qsfp0_drp_en,
    output wire                               qsfp0_drp_we,
    input  wire [15:0]                        qsfp0_drp_do,
    input  wire                               qsfp0_drp_rdy,

    output wire                               qsfp0_modsell,
    output wire                               qsfp0_resetl,
    input  wire                               qsfp0_modprsl,
    input  wire                               qsfp0_intl,
    output wire                               qsfp0_lpmode,

    input  wire                               qsfp1_tx_clk,
    input  wire                               qsfp1_tx_rst,

    output wire [AXIS_ETH_DATA_WIDTH-1:0]     qsfp1_tx_axis_tdata,
    output wire [AXIS_ETH_KEEP_WIDTH-1:0]     qsfp1_tx_axis_tkeep,
    output wire                               qsfp1_tx_axis_tvalid,
    input  wire                               qsfp1_tx_axis_tready,
    output wire                               qsfp1_tx_axis_tlast,
    output wire [16+1-1:0]                    qsfp1_tx_axis_tuser,

    output wire [79:0]                        qsfp1_tx_ptp_time,
    input  wire [79:0]                        qsfp1_tx_ptp_ts,
    input  wire [15:0]                        qsfp1_tx_ptp_ts_tag,
    input  wire                               qsfp1_tx_ptp_ts_valid,

    input  wire                               qsfp1_rx_clk,
    input  wire                               qsfp1_rx_rst,

    input  wire [AXIS_ETH_DATA_WIDTH-1:0]     qsfp1_rx_axis_tdata,
    input  wire [AXIS_ETH_KEEP_WIDTH-1:0]     qsfp1_rx_axis_tkeep,
    input  wire                               qsfp1_rx_axis_tvalid,
    input  wire                               qsfp1_rx_axis_tlast,
    input  wire [80+1-1:0]                    qsfp1_rx_axis_tuser,

    input  wire                               qsfp1_rx_ptp_clk,
    input  wire                               qsfp1_rx_ptp_rst,
    output wire [79:0]                        qsfp1_rx_ptp_time,

    input  wire                               qsfp1_rx_status,

    input  wire                               qsfp1_drp_clk,
    input  wire                               qsfp1_drp_rst,
    output wire [23:0]                        qsfp1_drp_addr,
    output wire [15:0]                        qsfp1_drp_di,
    output wire                               qsfp1_drp_en,
    output wire                               qsfp1_drp_we,
    input  wire [15:0]                        qsfp1_drp_do,
    input  wire                               qsfp1_drp_rdy,

    output wire                               qsfp1_modsell,
    output wire                               qsfp1_resetl,
    input  wire                               qsfp1_modprsl,
    input  wire                               qsfp1_intl,
    output wire                               qsfp1_lpmode,

    /*
     * DDR
     */
    input  wire [DDR_CH-1:0]                     ddr_clk,
    input  wire [DDR_CH-1:0]                     ddr_rst,

    output wire [DDR_CH*AXI_DDR_ID_WIDTH-1:0]    m_axi_ddr_awid,
    output wire [DDR_CH*AXI_DDR_ADDR_WIDTH-1:0]  m_axi_ddr_awaddr,
    output wire [DDR_CH*8-1:0]                   m_axi_ddr_awlen,
    output wire [DDR_CH*3-1:0]                   m_axi_ddr_awsize,
    output wire [DDR_CH*2-1:0]                   m_axi_ddr_awburst,
    output wire [DDR_CH-1:0]                     m_axi_ddr_awlock,
    output wire [DDR_CH*4-1:0]                   m_axi_ddr_awcache,
    output wire [DDR_CH*3-1:0]                   m_axi_ddr_awprot,
    output wire [DDR_CH*4-1:0]                   m_axi_ddr_awqos,
    output wire [DDR_CH-1:0]                     m_axi_ddr_awvalid,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_awready,
    output wire [DDR_CH*AXI_DDR_DATA_WIDTH-1:0]  m_axi_ddr_wdata,
    output wire [DDR_CH*AXI_DDR_STRB_WIDTH-1:0]  m_axi_ddr_wstrb,
    output wire [DDR_CH-1:0]                     m_axi_ddr_wlast,
    output wire [DDR_CH-1:0]                     m_axi_ddr_wvalid,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_wready,
    input  wire [DDR_CH*AXI_DDR_ID_WIDTH-1:0]    m_axi_ddr_bid,
    input  wire [DDR_CH*2-1:0]                   m_axi_ddr_bresp,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_bvalid,
    output wire [DDR_CH-1:0]                     m_axi_ddr_bready,
    output wire [DDR_CH*AXI_DDR_ID_WIDTH-1:0]    m_axi_ddr_arid,
    output wire [DDR_CH*AXI_DDR_ADDR_WIDTH-1:0]  m_axi_ddr_araddr,
    output wire [DDR_CH*8-1:0]                   m_axi_ddr_arlen,
    output wire [DDR_CH*3-1:0]                   m_axi_ddr_arsize,
    output wire [DDR_CH*2-1:0]                   m_axi_ddr_arburst,
    output wire [DDR_CH-1:0]                     m_axi_ddr_arlock,
    output wire [DDR_CH*4-1:0]                   m_axi_ddr_arcache,
    output wire [DDR_CH*3-1:0]                   m_axi_ddr_arprot,
    output wire [DDR_CH*4-1:0]                   m_axi_ddr_arqos,
    output wire [DDR_CH-1:0]                     m_axi_ddr_arvalid,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_arready,
    input  wire [DDR_CH*AXI_DDR_ID_WIDTH-1:0]    m_axi_ddr_rid,
    input  wire [DDR_CH*AXI_DDR_DATA_WIDTH-1:0]  m_axi_ddr_rdata,
    input  wire [DDR_CH*2-1:0]                   m_axi_ddr_rresp,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_rlast,
    input  wire [DDR_CH-1:0]                     m_axi_ddr_rvalid,
    output wire [DDR_CH-1:0]                     m_axi_ddr_rready,

    input  wire [DDR_CH-1:0]                     ddr_status,

    /*
     * QSPI flash
     */
    output wire                               fpga_boot,
    output wire                               qspi_clk,
    input  wire [3:0]                         qspi_dq_i,
    output wire [3:0]                         qspi_dq_o,
    output wire [3:0]                         qspi_dq_oe,
    output wire                               qspi_cs,

    /*
     * AXI-Lite interface to CMS
     */
    output wire                               m_axil_cms_clk,
    output wire                               m_axil_cms_rst,
    output wire [17:0]                        m_axil_cms_awaddr,
    output wire [2:0]                         m_axil_cms_awprot,
    output wire                               m_axil_cms_awvalid,
    input  wire                               m_axil_cms_awready,
    output wire [31:0]                        m_axil_cms_wdata,
    output wire [3:0]                         m_axil_cms_wstrb,
    output wire                               m_axil_cms_wvalid,
    input  wire                               m_axil_cms_wready,
    input  wire [1:0]                         m_axil_cms_bresp,
    input  wire                               m_axil_cms_bvalid,
    output wire                               m_axil_cms_bready,
    output wire [17:0]                        m_axil_cms_araddr,
    output wire [2:0]                         m_axil_cms_arprot,
    output wire                               m_axil_cms_arvalid,
    input  wire                               m_axil_cms_arready,
    input  wire [31:0]                        m_axil_cms_rdata,
    input  wire [1:0]                         m_axil_cms_rresp,
    input  wire                               m_axil_cms_rvalid,
    output wire                               m_axil_cms_rready
);

parameter PORT_COUNT = IF_COUNT*PORTS_PER_IF;

parameter F_COUNT = PF_COUNT+VF_COUNT;

parameter AXIL_CTRL_STRB_WIDTH = (AXIL_CTRL_DATA_WIDTH/8);
parameter AXIL_IF_CTRL_ADDR_WIDTH = AXIL_CTRL_ADDR_WIDTH-$clog2(IF_COUNT);
parameter AXIL_CSR_ADDR_WIDTH = AXIL_IF_CTRL_ADDR_WIDTH-5-$clog2((PORTS_PER_IF+3)/8);

localparam RB_BASE_ADDR = 16'h1000;
localparam RBB = RB_BASE_ADDR & {AXIL_CTRL_ADDR_WIDTH{1'b1}};

localparam RB_DRP_QSFP0_BASE = RB_BASE_ADDR + 16'h60;
localparam RB_DRP_QSFP1_BASE = RB_DRP_QSFP0_BASE + 16'h20;

initial begin
    if (PORT_COUNT > 2) begin
        $error("Error: Max port count exceeded (instance %m)");
        $finish;
    end
end

// PTP
wire [PTP_TS_WIDTH-1:0]     ptp_ts_96;
wire                        ptp_ts_step;
wire                        ptp_pps;
wire                        ptp_pps_str;
wire [PTP_TS_WIDTH-1:0]     ptp_sync_ts_96;
wire                        ptp_sync_ts_step;
wire                        ptp_sync_pps;

wire [PTP_PEROUT_COUNT-1:0] ptp_perout_locked;
wire [PTP_PEROUT_COUNT-1:0] ptp_perout_error;
wire [PTP_PEROUT_COUNT-1:0] ptp_perout_pulse;

// control registers
wire [AXIL_CSR_ADDR_WIDTH-1:0]   ctrl_reg_wr_addr;
wire [AXIL_CTRL_DATA_WIDTH-1:0]  ctrl_reg_wr_data;
wire [AXIL_CTRL_STRB_WIDTH-1:0]  ctrl_reg_wr_strb;
wire                             ctrl_reg_wr_en;
wire                             ctrl_reg_wr_wait;
wire                             ctrl_reg_wr_ack;
wire [AXIL_CSR_ADDR_WIDTH-1:0]   ctrl_reg_rd_addr;
wire                             ctrl_reg_rd_en;
wire [AXIL_CTRL_DATA_WIDTH-1:0]  ctrl_reg_rd_data;
wire                             ctrl_reg_rd_wait;
wire                             ctrl_reg_rd_ack;

wire qsfp0_drp_reg_wr_wait;
wire qsfp0_drp_reg_wr_ack;
wire [AXIL_CTRL_DATA_WIDTH-1:0] qsfp0_drp_reg_rd_data;
wire qsfp0_drp_reg_rd_wait;
wire qsfp0_drp_reg_rd_ack;

wire qsfp1_drp_reg_wr_wait;
wire qsfp1_drp_reg_wr_ack;
wire [AXIL_CTRL_DATA_WIDTH-1:0] qsfp1_drp_reg_rd_data;
wire qsfp1_drp_reg_rd_wait;
wire qsfp1_drp_reg_rd_ack;

reg ctrl_reg_wr_ack_reg = 1'b0;
reg [AXIL_CTRL_DATA_WIDTH-1:0] ctrl_reg_rd_data_reg = {AXIL_CTRL_DATA_WIDTH{1'b0}};
reg ctrl_reg_rd_ack_reg = 1'b0;

reg qsfp0_reset_reg = 1'b0;
reg qsfp1_reset_reg = 1'b0;

reg qsfp0_lpmode_reg = 1'b0;
reg qsfp1_lpmode_reg = 1'b0;

reg i2c_scl_o_reg = 1'b1;
reg i2c_sda_o_reg = 1'b1;

reg fpga_boot_reg = 1'b0;

reg qspi_clk_reg = 1'b0;
reg qspi_cs_reg = 1'b1;
reg [3:0] qspi_dq_o_reg = 4'd0;
reg [3:0] qspi_dq_oe_reg = 4'd0;

reg [17:0] m_axil_cms_addr_reg = 18'd0;
reg m_axil_cms_awvalid_reg = 1'b0;
reg [31:0] m_axil_cms_wdata_reg = 32'd0;
reg [3:0] m_axil_cms_wstrb_reg = 4'b0000;
reg m_axil_cms_wvalid_reg = 1'b0;
reg m_axil_cms_arvalid_reg = 1'b0;

assign ctrl_reg_wr_wait = qsfp0_drp_reg_wr_wait | qsfp1_drp_reg_wr_wait;
assign ctrl_reg_wr_ack = ctrl_reg_wr_ack_reg | qsfp0_drp_reg_wr_ack | qsfp1_drp_reg_wr_ack;
assign ctrl_reg_rd_data = ctrl_reg_rd_data_reg | qsfp0_drp_reg_rd_data | qsfp1_drp_reg_rd_data;
assign ctrl_reg_rd_wait = qsfp0_drp_reg_rd_wait | qsfp1_drp_reg_rd_wait;
assign ctrl_reg_rd_ack = ctrl_reg_rd_ack_reg | qsfp0_drp_reg_rd_ack | qsfp1_drp_reg_rd_ack;

assign qsfp0_modsell = 1'b0;
assign qsfp1_modsell = 1'b0;

assign qsfp0_resetl = !qsfp0_reset_reg;
assign qsfp1_resetl = !qsfp1_reset_reg;

assign qsfp0_lpmode = qsfp0_lpmode_reg;
assign qsfp1_lpmode = qsfp1_lpmode_reg;

assign i2c_scl_o = i2c_scl_o_reg;
assign i2c_scl_t = i2c_scl_o_reg;
assign i2c_sda_o = i2c_sda_o_reg;
assign i2c_sda_t = i2c_sda_o_reg;

assign fpga_boot = fpga_boot_reg;

assign qspi_clk = qspi_clk_reg;
assign qspi_cs = qspi_cs_reg;
assign qspi_dq_o = qspi_dq_o_reg;
assign qspi_dq_oe = qspi_dq_oe_reg;

assign m_axil_cms_clk = clk_250mhz;
assign m_axil_cms_rst = rst_250mhz;
assign m_axil_cms_awaddr = m_axil_cms_addr_reg;
assign m_axil_cms_awprot = 3'b000;
assign m_axil_cms_awvalid = m_axil_cms_awvalid_reg;
assign m_axil_cms_wdata = m_axil_cms_wdata_reg;
assign m_axil_cms_wstrb = m_axil_cms_wstrb_reg;
assign m_axil_cms_wvalid = m_axil_cms_wvalid_reg;
assign m_axil_cms_bready = 1'b1;
assign m_axil_cms_araddr = m_axil_cms_addr_reg;
assign m_axil_cms_arprot = 3'b000;
assign m_axil_cms_arvalid = m_axil_cms_arvalid_reg;
assign m_axil_cms_rready = 1'b1;

always @(posedge clk_250mhz) begin
    ctrl_reg_wr_ack_reg <= 1'b0;
    ctrl_reg_rd_data_reg <= {AXIL_CTRL_DATA_WIDTH{1'b0}};
    ctrl_reg_rd_ack_reg <= 1'b0;

    m_axil_cms_awvalid_reg <= m_axil_cms_awvalid_reg && !m_axil_cms_awready;
    m_axil_cms_wvalid_reg <= m_axil_cms_wvalid_reg && !m_axil_cms_wready;
    m_axil_cms_arvalid_reg <= m_axil_cms_arvalid_reg && !m_axil_cms_arready;

    if (ctrl_reg_wr_en && !ctrl_reg_wr_ack_reg) begin
        // write operation
        ctrl_reg_wr_ack_reg <= 1'b0;
        case ({ctrl_reg_wr_addr >> 2, 2'b00})
            // FW ID
            8'h0C: begin
                // FW ID: FPGA JTAG ID
                fpga_boot_reg <= ctrl_reg_wr_data == 32'hFEE1DEAD;
            end
            // I2C 0
            RBB+8'h0C: begin
                // I2C ctrl: control
                if (ctrl_reg_wr_strb[0]) begin
                    i2c_scl_o_reg <= ctrl_reg_wr_data[1];
                end
                if (ctrl_reg_wr_strb[1]) begin
                    i2c_sda_o_reg <= ctrl_reg_wr_data[9];
                end
            end
            // XCVR GPIO
            RBB+8'h1C: begin
                // XCVR GPIO: control 0123
                if (ctrl_reg_wr_strb[0]) begin
                    qsfp0_reset_reg <= ctrl_reg_wr_data[4];
                    qsfp0_lpmode_reg <= ctrl_reg_wr_data[5];
                end
                if (ctrl_reg_wr_strb[1]) begin
                    qsfp1_reset_reg <= ctrl_reg_wr_data[12];
                    qsfp1_lpmode_reg <= ctrl_reg_wr_data[13];
                end
            end
            // QSPI flash
            RBB+8'h2C: begin
                // SPI flash ctrl: format
                fpga_boot_reg <= ctrl_reg_wr_data == 32'hFEE1DEAD;
            end
            RBB+8'h30: begin
                // SPI flash ctrl: control 0
                if (ctrl_reg_wr_strb[0]) begin
                    qspi_dq_o_reg <= ctrl_reg_wr_data[3:0];
                end
                if (ctrl_reg_wr_strb[1]) begin
                    qspi_dq_oe_reg <= ctrl_reg_wr_data[11:8];
                end
                if (ctrl_reg_wr_strb[2]) begin
                    qspi_clk_reg <= ctrl_reg_wr_data[16];
                    qspi_cs_reg <= ctrl_reg_wr_data[17];
                end
            end
            // Alveo BMC
            RBB+8'h4C: begin
                // BMC ctrl: Addr
                if (!m_axil_cms_arvalid && !m_axil_cms_awvalid) begin
                    m_axil_cms_addr_reg <= ctrl_reg_wr_data;
                    m_axil_cms_arvalid_reg <= 1'b1;
                end
            end
            RBB+8'h50: begin
                // BMC ctrl: Data
                if (!m_axil_cms_wvalid) begin
                    m_axil_cms_awvalid_reg <= 1'b1;
                    m_axil_cms_wdata_reg <= ctrl_reg_wr_data;
                    m_axil_cms_wstrb_reg <= ctrl_reg_wr_strb;
                    m_axil_cms_wvalid_reg <= 1'b1;
                end
            end
            default: ctrl_reg_wr_ack_reg <= 1'b0;
        endcase
    end

    if (ctrl_reg_rd_en && !ctrl_reg_rd_ack_reg) begin
        // read operation
        ctrl_reg_rd_ack_reg <= 1'b1;
        case ({ctrl_reg_rd_addr >> 2, 2'b00})
            // I2C 0
            RBB+8'h00: ctrl_reg_rd_data_reg <= 32'h0000C110;             // I2C ctrl: Type
            RBB+8'h04: ctrl_reg_rd_data_reg <= 32'h00000100;             // I2C ctrl: Version
            RBB+8'h08: ctrl_reg_rd_data_reg <= RB_BASE_ADDR+8'h10;       // I2C ctrl: Next header
            RBB+8'h0C: begin
                // I2C ctrl: control
                ctrl_reg_rd_data_reg[0] <= i2c_scl_i;
                ctrl_reg_rd_data_reg[1] <= i2c_scl_o_reg;
                ctrl_reg_rd_data_reg[8] <= i2c_sda_i;
                ctrl_reg_rd_data_reg[9] <= i2c_sda_o_reg;
            end
            // XCVR GPIO
            RBB+8'h10: ctrl_reg_rd_data_reg <= 32'h0000C101;             // XCVR GPIO: Type
            RBB+8'h14: ctrl_reg_rd_data_reg <= 32'h00000100;             // XCVR GPIO: Version
            RBB+8'h18: ctrl_reg_rd_data_reg <= RB_BASE_ADDR+8'h20;       // XCVR GPIO: Next header
            RBB+8'h1C: begin
                // XCVR GPIO: control 0123
                ctrl_reg_rd_data_reg[0] <= !qsfp0_modprsl;
                ctrl_reg_rd_data_reg[1] <= !qsfp0_intl;
                ctrl_reg_rd_data_reg[4] <= qsfp0_reset_reg;
                ctrl_reg_rd_data_reg[5] <= qsfp0_lpmode_reg;
                ctrl_reg_rd_data_reg[8] <= !qsfp1_modprsl;
                ctrl_reg_rd_data_reg[9] <= !qsfp1_intl;
                ctrl_reg_rd_data_reg[12] <= qsfp1_reset_reg;
                ctrl_reg_rd_data_reg[13] <= qsfp1_lpmode_reg;
            end
            // QSPI flash
            RBB+8'h20: ctrl_reg_rd_data_reg <= 32'h0000C120;             // SPI flash ctrl: Type
            RBB+8'h24: ctrl_reg_rd_data_reg <= 32'h00000200;             // SPI flash ctrl: Version
            RBB+8'h28: ctrl_reg_rd_data_reg <= RB_BASE_ADDR+8'h40;       // SPI flash ctrl: Next header
            RBB+8'h2C: begin
                // SPI flash ctrl: format
                ctrl_reg_rd_data_reg[3:0]   <= 2;                   // configuration (two segments)
                ctrl_reg_rd_data_reg[7:4]   <= 1;                   // default segment
                ctrl_reg_rd_data_reg[11:8]  <= 0;                   // fallback segment
                ctrl_reg_rd_data_reg[31:12] <= 32'h01002000 >> 12;  // first segment size (Alveo default)
            end
            RBB+8'h30: begin
                // SPI flash ctrl: control 0
                ctrl_reg_rd_data_reg[3:0] <= qspi_dq_i;
                ctrl_reg_rd_data_reg[11:8] <= qspi_dq_oe;
                ctrl_reg_rd_data_reg[16] <= qspi_clk;
                ctrl_reg_rd_data_reg[17] <= qspi_cs;
            end
            // Alveo BMC
            RBB+8'h40: ctrl_reg_rd_data_reg <= 32'h0000C140;             // BMC ctrl: Type
            RBB+8'h44: ctrl_reg_rd_data_reg <= 32'h00000100;             // BMC ctrl: Version
            RBB+8'h48: ctrl_reg_rd_data_reg <= RB_DRP_QSFP0_BASE;        // BMC ctrl: Next header
            RBB+8'h4C: ctrl_reg_rd_data_reg <= m_axil_cms_addr_reg;      // BMC ctrl: Addr
            RBB+8'h50: ctrl_reg_rd_data_reg <= m_axil_cms_rdata;         // BMC ctrl: Data
            default: ctrl_reg_rd_ack_reg <= 1'b0;
        endcase
    end

    if (rst_250mhz) begin
        ctrl_reg_wr_ack_reg <= 1'b0;
        ctrl_reg_rd_ack_reg <= 1'b0;

        qsfp0_reset_reg <= 1'b0;
        qsfp1_reset_reg <= 1'b0;

        qsfp0_lpmode_reg <= 1'b0;
        qsfp1_lpmode_reg <= 1'b0;

        i2c_scl_o_reg <= 1'b1;
        i2c_sda_o_reg <= 1'b1;

        fpga_boot_reg <= 1'b0;

        qspi_clk_reg <= 1'b0;
        qspi_cs_reg <= 1'b1;
        qspi_dq_o_reg <= 4'd0;
        qspi_dq_oe_reg <= 4'd0;

        m_axil_cms_awvalid_reg <= 1'b0;
        m_axil_cms_wvalid_reg <= 1'b0;
        m_axil_cms_arvalid_reg <= 1'b0;
    end
end

rb_drp #(
    .DRP_ADDR_WIDTH(24),
    .DRP_DATA_WIDTH(16),
    .DRP_INFO({8'h09, 8'h03, 8'd2, 8'd4}),
    .REG_ADDR_WIDTH(AXIL_CSR_ADDR_WIDTH),
    .REG_DATA_WIDTH(AXIL_CTRL_DATA_WIDTH),
    .REG_STRB_WIDTH(AXIL_CTRL_STRB_WIDTH),
    .RB_BASE_ADDR(RB_DRP_QSFP0_BASE),
    .RB_NEXT_PTR(RB_DRP_QSFP1_BASE)
)
qsfp0_rb_drp_inst (
    .clk(clk_250mhz),
    .rst(rst_250mhz),

    /*
     * Register interface
     */
    .reg_wr_addr(ctrl_reg_wr_addr),
    .reg_wr_data(ctrl_reg_wr_data),
    .reg_wr_strb(ctrl_reg_wr_strb),
    .reg_wr_en(ctrl_reg_wr_en),
    .reg_wr_wait(qsfp0_drp_reg_wr_wait),
    .reg_wr_ack(qsfp0_drp_reg_wr_ack),
    .reg_rd_addr(ctrl_reg_rd_addr),
    .reg_rd_en(ctrl_reg_rd_en),
    .reg_rd_data(qsfp0_drp_reg_rd_data),
    .reg_rd_wait(qsfp0_drp_reg_rd_wait),
    .reg_rd_ack(qsfp0_drp_reg_rd_ack),

    /*
     * DRP
     */
    .drp_clk(qsfp0_drp_clk),
    .drp_rst(qsfp0_drp_rst),
    .drp_addr(qsfp0_drp_addr),
    .drp_di(qsfp0_drp_di),
    .drp_en(qsfp0_drp_en),
    .drp_we(qsfp0_drp_we),
    .drp_do(qsfp0_drp_do),
    .drp_rdy(qsfp0_drp_rdy)
);

rb_drp #(
    .DRP_ADDR_WIDTH(24),
    .DRP_DATA_WIDTH(16),
    .DRP_INFO({8'h09, 8'h03, 8'd2, 8'd4}),
    .REG_ADDR_WIDTH(AXIL_CSR_ADDR_WIDTH),
    .REG_DATA_WIDTH(AXIL_CTRL_DATA_WIDTH),
    .REG_STRB_WIDTH(AXIL_CTRL_STRB_WIDTH),
    .RB_BASE_ADDR(RB_DRP_QSFP1_BASE),
    .RB_NEXT_PTR(0)
)
qsfp1_rb_drp_inst (
    .clk(clk_250mhz),
    .rst(rst_250mhz),

    /*
     * Register interface
     */
    .reg_wr_addr(ctrl_reg_wr_addr),
    .reg_wr_data(ctrl_reg_wr_data),
    .reg_wr_strb(ctrl_reg_wr_strb),
    .reg_wr_en(ctrl_reg_wr_en),
    .reg_wr_wait(qsfp1_drp_reg_wr_wait),
    .reg_wr_ack(qsfp1_drp_reg_wr_ack),
    .reg_rd_addr(ctrl_reg_rd_addr),
    .reg_rd_en(ctrl_reg_rd_en),
    .reg_rd_data(qsfp1_drp_reg_rd_data),
    .reg_rd_wait(qsfp1_drp_reg_rd_wait),
    .reg_rd_ack(qsfp1_drp_reg_rd_ack),

    /*
     * DRP
     */
    .drp_clk(qsfp1_drp_clk),
    .drp_rst(qsfp1_drp_rst),
    .drp_addr(qsfp1_drp_addr),
    .drp_di(qsfp1_drp_di),
    .drp_en(qsfp1_drp_en),
    .drp_we(qsfp1_drp_we),
    .drp_do(qsfp1_drp_do),
    .drp_rdy(qsfp1_drp_rdy)
);

assign led[0] = ptp_pps_str;
assign led[2:1] = 0;

wire [PORT_COUNT-1:0]                         eth_tx_clk;
wire [PORT_COUNT-1:0]                         eth_tx_rst;

wire [PORT_COUNT-1:0]                         eth_tx_ptp_clk;
wire [PORT_COUNT-1:0]                         eth_tx_ptp_rst;
wire [PORT_COUNT*PTP_TS_WIDTH-1:0]            eth_tx_ptp_ts_96;
wire [PORT_COUNT-1:0]                         eth_tx_ptp_ts_step;

wire [PORT_COUNT*AXIS_ETH_DATA_WIDTH-1:0]     axis_eth_tx_tdata;
wire [PORT_COUNT*AXIS_ETH_KEEP_WIDTH-1:0]     axis_eth_tx_tkeep;
wire [PORT_COUNT-1:0]                         axis_eth_tx_tvalid;
wire [PORT_COUNT-1:0]                         axis_eth_tx_tready;
wire [PORT_COUNT-1:0]                         axis_eth_tx_tlast;
wire [PORT_COUNT*AXIS_ETH_TX_USER_WIDTH-1:0]  axis_eth_tx_tuser;

wire [PORT_COUNT*PTP_TS_WIDTH-1:0]            axis_eth_tx_ptp_ts;
wire [PORT_COUNT*TX_TAG_WIDTH-1:0]            axis_eth_tx_ptp_ts_tag;
wire [PORT_COUNT-1:0]                         axis_eth_tx_ptp_ts_valid;
wire [PORT_COUNT-1:0]                         axis_eth_tx_ptp_ts_ready;

wire [PORT_COUNT-1:0]                         eth_tx_status;

wire [PORT_COUNT-1:0]                         eth_rx_clk;
wire [PORT_COUNT-1:0]                         eth_rx_rst;

wire [PORT_COUNT-1:0]                         eth_rx_ptp_clk;
wire [PORT_COUNT-1:0]                         eth_rx_ptp_rst;
wire [PORT_COUNT*PTP_TS_WIDTH-1:0]            eth_rx_ptp_ts_96;
wire [PORT_COUNT-1:0]                         eth_rx_ptp_ts_step;

wire [PORT_COUNT*AXIS_ETH_DATA_WIDTH-1:0]     axis_eth_rx_tdata;
wire [PORT_COUNT*AXIS_ETH_KEEP_WIDTH-1:0]     axis_eth_rx_tkeep;
wire [PORT_COUNT-1:0]                         axis_eth_rx_tvalid;
wire [PORT_COUNT-1:0]                         axis_eth_rx_tready;
wire [PORT_COUNT-1:0]                         axis_eth_rx_tlast;
wire [PORT_COUNT*AXIS_ETH_RX_USER_WIDTH-1:0]  axis_eth_rx_tuser;

wire [PORT_COUNT-1:0]                         eth_rx_status;

wire [PTP_TS_WIDTH-1:0] qsfp0_tx_ptp_time_int;
wire [PTP_TS_WIDTH-1:0] qsfp1_tx_ptp_time_int;
wire [PTP_TS_WIDTH-1:0] qsfp0_rx_ptp_time_int;
wire [PTP_TS_WIDTH-1:0] qsfp1_rx_ptp_time_int;

assign qsfp0_tx_ptp_time = qsfp0_tx_ptp_time_int >> 16;
assign qsfp1_tx_ptp_time = qsfp1_tx_ptp_time_int >> 16;
assign qsfp0_rx_ptp_time = qsfp0_rx_ptp_time_int >> 16;
assign qsfp1_rx_ptp_time = qsfp1_rx_ptp_time_int >> 16;

mqnic_port_map_mac_axis #(
    .MAC_COUNT(2),
    .PORT_MASK(PORT_MASK),
    .PORT_GROUP_SIZE(1),

    .IF_COUNT(IF_COUNT),
    .PORTS_PER_IF(PORTS_PER_IF),

    .PORT_COUNT(PORT_COUNT),

    .PTP_TS_WIDTH(PTP_TS_WIDTH),
    .PTP_TAG_WIDTH(TX_TAG_WIDTH),
    .AXIS_DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .AXIS_KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .AXIS_TX_USER_WIDTH(AXIS_ETH_TX_USER_WIDTH),
    .AXIS_RX_USER_WIDTH(AXIS_ETH_RX_USER_WIDTH)
)
mqnic_port_map_mac_axis_inst (
    // towards MAC
    .mac_tx_clk({qsfp1_tx_clk, qsfp0_tx_clk}),
    .mac_tx_rst({qsfp1_tx_rst, qsfp0_tx_rst}),

    .mac_tx_ptp_clk(2'b00),
    .mac_tx_ptp_rst(2'b00),
    .mac_tx_ptp_ts_96({qsfp1_tx_ptp_time_int, qsfp0_tx_ptp_time_int}),
    .mac_tx_ptp_ts_step(),

    .m_axis_mac_tx_tdata({qsfp1_tx_axis_tdata, qsfp0_tx_axis_tdata}),
    .m_axis_mac_tx_tkeep({qsfp1_tx_axis_tkeep, qsfp0_tx_axis_tkeep}),
    .m_axis_mac_tx_tvalid({qsfp1_tx_axis_tvalid, qsfp0_tx_axis_tvalid}),
    .m_axis_mac_tx_tready({qsfp1_tx_axis_tready, qsfp0_tx_axis_tready}),
    .m_axis_mac_tx_tlast({qsfp1_tx_axis_tlast, qsfp0_tx_axis_tlast}),
    .m_axis_mac_tx_tuser({qsfp1_tx_axis_tuser, qsfp0_tx_axis_tuser}),

    .s_axis_mac_tx_ptp_ts({{qsfp1_tx_ptp_ts, 16'd0}, {qsfp0_tx_ptp_ts, 16'd0}}),
    .s_axis_mac_tx_ptp_ts_tag({qsfp1_tx_ptp_ts_tag, qsfp0_tx_ptp_ts_tag}),
    .s_axis_mac_tx_ptp_ts_valid({qsfp1_tx_ptp_ts_valid, qsfp0_tx_ptp_ts_valid}),
    .s_axis_mac_tx_ptp_ts_ready(),

    .mac_tx_status(2'b11),

    .mac_rx_clk({qsfp1_rx_clk, qsfp0_rx_clk}),
    .mac_rx_rst({qsfp1_rx_rst, qsfp0_rx_rst}),

    .mac_rx_ptp_clk({qsfp1_rx_ptp_clk, qsfp0_rx_ptp_clk}),
    .mac_rx_ptp_rst({qsfp1_rx_ptp_rst, qsfp0_rx_ptp_rst}),
    .mac_rx_ptp_ts_96({qsfp1_rx_ptp_time_int, qsfp0_rx_ptp_time_int}),
    .mac_rx_ptp_ts_step(),

    .s_axis_mac_rx_tdata({qsfp1_rx_axis_tdata, qsfp0_rx_axis_tdata}),
    .s_axis_mac_rx_tkeep({qsfp1_rx_axis_tkeep, qsfp0_rx_axis_tkeep}),
    .s_axis_mac_rx_tvalid({qsfp1_rx_axis_tvalid, qsfp0_rx_axis_tvalid}),
    .s_axis_mac_rx_tready(),
    .s_axis_mac_rx_tlast({qsfp1_rx_axis_tlast, qsfp0_rx_axis_tlast}),
    .s_axis_mac_rx_tuser({{qsfp1_rx_axis_tuser[80:1], 16'd0, qsfp1_rx_axis_tuser[0]}, {qsfp0_rx_axis_tuser[80:1], 16'd0, qsfp0_rx_axis_tuser[0]}}),

    .mac_rx_status({qsfp1_rx_status, qsfp0_rx_status}),

    // towards datapath
    .tx_clk(eth_tx_clk),
    .tx_rst(eth_tx_rst),

    .tx_ptp_clk(eth_tx_ptp_clk),
    .tx_ptp_rst(eth_tx_ptp_rst),
    .tx_ptp_ts_96(eth_tx_ptp_ts_96),
    .tx_ptp_ts_step(eth_tx_ptp_ts_step),

    .s_axis_tx_tdata(axis_eth_tx_tdata),
    .s_axis_tx_tkeep(axis_eth_tx_tkeep),
    .s_axis_tx_tvalid(axis_eth_tx_tvalid),
    .s_axis_tx_tready(axis_eth_tx_tready),
    .s_axis_tx_tlast(axis_eth_tx_tlast),
    .s_axis_tx_tuser(axis_eth_tx_tuser),

    .m_axis_tx_ptp_ts(axis_eth_tx_ptp_ts),
    .m_axis_tx_ptp_ts_tag(axis_eth_tx_ptp_ts_tag),
    .m_axis_tx_ptp_ts_valid(axis_eth_tx_ptp_ts_valid),
    .m_axis_tx_ptp_ts_ready(axis_eth_tx_ptp_ts_ready),

    .tx_status(eth_tx_status),

    .rx_clk(eth_rx_clk),
    .rx_rst(eth_rx_rst),

    .rx_ptp_clk(eth_rx_ptp_clk),
    .rx_ptp_rst(eth_rx_ptp_rst),
    .rx_ptp_ts_96(eth_rx_ptp_ts_96),
    .rx_ptp_ts_step(eth_rx_ptp_ts_step),

    .m_axis_rx_tdata(axis_eth_rx_tdata),
    .m_axis_rx_tkeep(axis_eth_rx_tkeep),
    .m_axis_rx_tvalid(axis_eth_rx_tvalid),
    .m_axis_rx_tready(axis_eth_rx_tready),
    .m_axis_rx_tlast(axis_eth_rx_tlast),
    .m_axis_rx_tuser(axis_eth_rx_tuser),

    .rx_status(eth_rx_status)
);

mqnic_core_pcie_us #(
    // FW and board IDs
    .FPGA_ID(FPGA_ID),
    .FW_ID(FW_ID),
    .FW_VER(FW_VER),
    .BOARD_ID(BOARD_ID),
    .BOARD_VER(BOARD_VER),
    .BUILD_DATE(BUILD_DATE),
    .GIT_HASH(GIT_HASH),
    .RELEASE_INFO(RELEASE_INFO),

    // Structural configuration
    .IF_COUNT(IF_COUNT),
    .PORTS_PER_IF(PORTS_PER_IF),
    .SCHED_PER_IF(SCHED_PER_IF),

    .PORT_COUNT(PORT_COUNT),

    // Clock configuration
    .CLK_PERIOD_NS_NUM(CLK_PERIOD_NS_NUM),
    .CLK_PERIOD_NS_DENOM(CLK_PERIOD_NS_DENOM),

    // PTP configuration
    .PTP_CLK_PERIOD_NS_NUM(PTP_CLK_PERIOD_NS_NUM),
    .PTP_CLK_PERIOD_NS_DENOM(PTP_CLK_PERIOD_NS_DENOM),
    .PTP_TS_WIDTH(PTP_TS_WIDTH),
    .PTP_CLOCK_PIPELINE(PTP_CLOCK_PIPELINE),
    .PTP_CLOCK_CDC_PIPELINE(PTP_CLOCK_CDC_PIPELINE),
    .PTP_USE_SAMPLE_CLOCK(PTP_USE_SAMPLE_CLOCK),
    .PTP_SEPARATE_TX_CLOCK(0),
    .PTP_SEPARATE_RX_CLOCK(PTP_SEPARATE_RX_CLOCK),
    .PTP_PORT_CDC_PIPELINE(PTP_PORT_CDC_PIPELINE),
    .PTP_PEROUT_ENABLE(PTP_PEROUT_ENABLE),
    .PTP_PEROUT_COUNT(PTP_PEROUT_COUNT),

    // Queue manager configuration
    .EVENT_QUEUE_OP_TABLE_SIZE(EVENT_QUEUE_OP_TABLE_SIZE),
    .TX_QUEUE_OP_TABLE_SIZE(TX_QUEUE_OP_TABLE_SIZE),
    .RX_QUEUE_OP_TABLE_SIZE(RX_QUEUE_OP_TABLE_SIZE),
    .CQ_OP_TABLE_SIZE(CQ_OP_TABLE_SIZE),
    .EQN_WIDTH(EQN_WIDTH),
    .TX_QUEUE_INDEX_WIDTH(TX_QUEUE_INDEX_WIDTH),
    .RX_QUEUE_INDEX_WIDTH(RX_QUEUE_INDEX_WIDTH),
    .CQN_WIDTH(CQN_WIDTH),
    .EQ_PIPELINE(EQ_PIPELINE),
    .TX_QUEUE_PIPELINE(TX_QUEUE_PIPELINE),
    .RX_QUEUE_PIPELINE(RX_QUEUE_PIPELINE),
    .CQ_PIPELINE(CQ_PIPELINE),

    // TX and RX engine configuration
    .TX_DESC_TABLE_SIZE(TX_DESC_TABLE_SIZE),
    .RX_DESC_TABLE_SIZE(RX_DESC_TABLE_SIZE),
    .RX_INDIR_TBL_ADDR_WIDTH(RX_INDIR_TBL_ADDR_WIDTH),

    // Scheduler configuration
    .TX_SCHEDULER_OP_TABLE_SIZE(TX_SCHEDULER_OP_TABLE_SIZE),
    .TX_SCHEDULER_PIPELINE(TX_SCHEDULER_PIPELINE),
    .TDMA_INDEX_WIDTH(TDMA_INDEX_WIDTH),

    // Interface configuration
    .PTP_TS_ENABLE(PTP_TS_ENABLE),
    .TX_CPL_ENABLE(PTP_TS_ENABLE),
    .TX_CPL_FIFO_DEPTH(TX_CPL_FIFO_DEPTH),
    .TX_TAG_WIDTH(TX_TAG_WIDTH),
    .TX_CHECKSUM_ENABLE(TX_CHECKSUM_ENABLE),
    .RX_HASH_ENABLE(RX_HASH_ENABLE),
    .RX_CHECKSUM_ENABLE(RX_CHECKSUM_ENABLE),
    .TX_FIFO_DEPTH(TX_FIFO_DEPTH),
    .RX_FIFO_DEPTH(RX_FIFO_DEPTH),
    .MAX_TX_SIZE(MAX_TX_SIZE),
    .MAX_RX_SIZE(MAX_RX_SIZE),
    .TX_RAM_SIZE(TX_RAM_SIZE),
    .RX_RAM_SIZE(RX_RAM_SIZE),

    // RAM configuration
    .DDR_CH(DDR_CH),
    .DDR_ENABLE(DDR_ENABLE),
    .DDR_GROUP_SIZE(1),
    .AXI_DDR_DATA_WIDTH(AXI_DDR_DATA_WIDTH),
    .AXI_DDR_ADDR_WIDTH(AXI_DDR_ADDR_WIDTH),
    .AXI_DDR_STRB_WIDTH(AXI_DDR_STRB_WIDTH),
    .AXI_DDR_ID_WIDTH(AXI_DDR_ID_WIDTH),
    .AXI_DDR_AWUSER_ENABLE(0),
    .AXI_DDR_WUSER_ENABLE(0),
    .AXI_DDR_BUSER_ENABLE(0),
    .AXI_DDR_ARUSER_ENABLE(0),
    .AXI_DDR_RUSER_ENABLE(0),
    .AXI_DDR_MAX_BURST_LEN(AXI_DDR_MAX_BURST_LEN),
    .AXI_DDR_NARROW_BURST(AXI_DDR_NARROW_BURST),
    .AXI_DDR_FIXED_BURST(0),
    .AXI_DDR_WRAP_BURST(1),
    .HBM_ENABLE(0),

    // Application block configuration
    .APP_ID(APP_ID),
    .APP_ENABLE(APP_ENABLE),
    .APP_CTRL_ENABLE(APP_CTRL_ENABLE),
    .APP_DMA_ENABLE(APP_DMA_ENABLE),
    .APP_AXIS_DIRECT_ENABLE(APP_AXIS_DIRECT_ENABLE),
    .APP_AXIS_SYNC_ENABLE(APP_AXIS_SYNC_ENABLE),
    .APP_AXIS_IF_ENABLE(APP_AXIS_IF_ENABLE),
    .APP_STAT_ENABLE(APP_STAT_ENABLE),
    .APP_GPIO_IN_WIDTH(32),
    .APP_GPIO_OUT_WIDTH(32),

    // DMA interface configuration
    .DMA_IMM_ENABLE(DMA_IMM_ENABLE),
    .DMA_IMM_WIDTH(DMA_IMM_WIDTH),
    .DMA_LEN_WIDTH(DMA_LEN_WIDTH),
    .DMA_TAG_WIDTH(DMA_TAG_WIDTH),
    .RAM_ADDR_WIDTH(RAM_ADDR_WIDTH),
    .RAM_PIPELINE(RAM_PIPELINE),

    // PCIe interface configuration
    .AXIS_PCIE_DATA_WIDTH(AXIS_PCIE_DATA_WIDTH),
    .AXIS_PCIE_KEEP_WIDTH(AXIS_PCIE_KEEP_WIDTH),
    .AXIS_PCIE_RC_USER_WIDTH(AXIS_PCIE_RC_USER_WIDTH),
    .AXIS_PCIE_RQ_USER_WIDTH(AXIS_PCIE_RQ_USER_WIDTH),
    .AXIS_PCIE_CQ_USER_WIDTH(AXIS_PCIE_CQ_USER_WIDTH),
    .AXIS_PCIE_CC_USER_WIDTH(AXIS_PCIE_CC_USER_WIDTH),
    .RC_STRADDLE(RC_STRADDLE),
    .RQ_STRADDLE(RQ_STRADDLE),
    .CQ_STRADDLE(CQ_STRADDLE),
    .CC_STRADDLE(CC_STRADDLE),
    .RQ_SEQ_NUM_WIDTH(RQ_SEQ_NUM_WIDTH),
    .PF_COUNT(PF_COUNT),
    .VF_COUNT(VF_COUNT),
    .F_COUNT(F_COUNT),
    .PCIE_TAG_COUNT(PCIE_TAG_COUNT),

    // Interrupt configuration
    .IRQ_INDEX_WIDTH(IRQ_INDEX_WIDTH),

    // AXI lite interface configuration (control)
    .AXIL_CTRL_DATA_WIDTH(AXIL_CTRL_DATA_WIDTH),
    .AXIL_CTRL_ADDR_WIDTH(AXIL_CTRL_ADDR_WIDTH),
    .AXIL_CTRL_STRB_WIDTH(AXIL_CTRL_STRB_WIDTH),
    .AXIL_IF_CTRL_ADDR_WIDTH(AXIL_IF_CTRL_ADDR_WIDTH),
    .AXIL_CSR_ADDR_WIDTH(AXIL_CSR_ADDR_WIDTH),
    .AXIL_CSR_PASSTHROUGH_ENABLE(0),
    .RB_NEXT_PTR(RB_BASE_ADDR),

    // AXI lite interface configuration (application control)
    .AXIL_APP_CTRL_DATA_WIDTH(AXIL_APP_CTRL_DATA_WIDTH),
    .AXIL_APP_CTRL_ADDR_WIDTH(AXIL_APP_CTRL_ADDR_WIDTH),

    // Ethernet interface configuration
    .AXIS_ETH_DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .AXIS_ETH_KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .AXIS_ETH_SYNC_DATA_WIDTH(AXIS_ETH_SYNC_DATA_WIDTH),
    .AXIS_ETH_TX_USER_WIDTH(AXIS_ETH_TX_USER_WIDTH),
    .AXIS_ETH_RX_USER_WIDTH(AXIS_ETH_RX_USER_WIDTH),
    .AXIS_ETH_RX_USE_READY(0),
    .AXIS_ETH_TX_PIPELINE(AXIS_ETH_TX_PIPELINE),
    .AXIS_ETH_TX_FIFO_PIPELINE(AXIS_ETH_TX_FIFO_PIPELINE),
    .AXIS_ETH_TX_TS_PIPELINE(AXIS_ETH_TX_TS_PIPELINE),
    .AXIS_ETH_RX_PIPELINE(AXIS_ETH_RX_PIPELINE),
    .AXIS_ETH_RX_FIFO_PIPELINE(AXIS_ETH_RX_FIFO_PIPELINE),

    // Statistics counter subsystem
    .STAT_ENABLE(STAT_ENABLE),
    .STAT_DMA_ENABLE(STAT_DMA_ENABLE),
    .STAT_PCIE_ENABLE(STAT_PCIE_ENABLE),
    .STAT_INC_WIDTH(STAT_INC_WIDTH),
    .STAT_ID_WIDTH(STAT_ID_WIDTH)
)
core_inst (
    .clk(clk_250mhz),
    .rst(rst_250mhz),

    /*
     * AXI input (RC)
     */
    .s_axis_rc_tdata(s_axis_rc_tdata),
    .s_axis_rc_tkeep(s_axis_rc_tkeep),
    .s_axis_rc_tvalid(s_axis_rc_tvalid),
    .s_axis_rc_tready(s_axis_rc_tready),
    .s_axis_rc_tlast(s_axis_rc_tlast),
    .s_axis_rc_tuser(s_axis_rc_tuser),

    /*
     * AXI output (RQ)
     */
    .m_axis_rq_tdata(m_axis_rq_tdata),
    .m_axis_rq_tkeep(m_axis_rq_tkeep),
    .m_axis_rq_tvalid(m_axis_rq_tvalid),
    .m_axis_rq_tready(m_axis_rq_tready),
    .m_axis_rq_tlast(m_axis_rq_tlast),
    .m_axis_rq_tuser(m_axis_rq_tuser),

    /*
     * AXI input (CQ)
     */
    .s_axis_cq_tdata(s_axis_cq_tdata),
    .s_axis_cq_tkeep(s_axis_cq_tkeep),
    .s_axis_cq_tvalid(s_axis_cq_tvalid),
    .s_axis_cq_tready(s_axis_cq_tready),
    .s_axis_cq_tlast(s_axis_cq_tlast),
    .s_axis_cq_tuser(s_axis_cq_tuser),

    /*
     * AXI output (CC)
     */
    .m_axis_cc_tdata(m_axis_cc_tdata),
    .m_axis_cc_tkeep(m_axis_cc_tkeep),
    .m_axis_cc_tvalid(m_axis_cc_tvalid),
    .m_axis_cc_tready(m_axis_cc_tready),
    .m_axis_cc_tlast(m_axis_cc_tlast),
    .m_axis_cc_tuser(m_axis_cc_tuser),

    /*
     * Transmit sequence number input
     */
    .s_axis_rq_seq_num_0(s_axis_rq_seq_num_0),
    .s_axis_rq_seq_num_valid_0(s_axis_rq_seq_num_valid_0),
    .s_axis_rq_seq_num_1(s_axis_rq_seq_num_1),
    .s_axis_rq_seq_num_valid_1(s_axis_rq_seq_num_valid_1),

    /*
     * Flow control
     */
    .cfg_fc_ph(cfg_fc_ph),
    .cfg_fc_pd(cfg_fc_pd),
    .cfg_fc_nph(cfg_fc_nph),
    .cfg_fc_npd(cfg_fc_npd),
    .cfg_fc_cplh(cfg_fc_cplh),
    .cfg_fc_cpld(cfg_fc_cpld),
    .cfg_fc_sel(cfg_fc_sel),

    /*
     * Configuration inputs
     */
    .cfg_max_read_req(cfg_max_read_req),
    .cfg_max_payload(cfg_max_payload),
    .cfg_rcb_status(cfg_rcb_status),

    /*
     * Configuration interface
     */
    .cfg_mgmt_addr(cfg_mgmt_addr),
    .cfg_mgmt_function_number(cfg_mgmt_function_number),
    .cfg_mgmt_write(cfg_mgmt_write),
    .cfg_mgmt_write_data(cfg_mgmt_write_data),
    .cfg_mgmt_byte_enable(cfg_mgmt_byte_enable),
    .cfg_mgmt_read(cfg_mgmt_read),
    .cfg_mgmt_read_data(cfg_mgmt_read_data),
    .cfg_mgmt_read_write_done(cfg_mgmt_read_write_done),

    /*
     * Interrupt interface
     */
    .cfg_interrupt_msix_enable(cfg_interrupt_msix_enable),
    .cfg_interrupt_msix_mask(cfg_interrupt_msix_mask),
    .cfg_interrupt_msix_vf_enable(cfg_interrupt_msix_vf_enable),
    .cfg_interrupt_msix_vf_mask(cfg_interrupt_msix_vf_mask),
    .cfg_interrupt_msix_address(cfg_interrupt_msix_address),
    .cfg_interrupt_msix_data(cfg_interrupt_msix_data),
    .cfg_interrupt_msix_int(cfg_interrupt_msix_int),
    .cfg_interrupt_msix_vec_pending(cfg_interrupt_msix_vec_pending),
    .cfg_interrupt_msix_vec_pending_status(cfg_interrupt_msix_vec_pending_status),
    .cfg_interrupt_msix_sent(cfg_interrupt_msix_sent),
    .cfg_interrupt_msix_fail(cfg_interrupt_msix_fail),
    .cfg_interrupt_msi_function_number(cfg_interrupt_msi_function_number),

    /*
     * PCIe error outputs
     */
    .status_error_cor(status_error_cor),
    .status_error_uncor(status_error_uncor),

    /*
     * AXI-Lite master interface (passthrough for NIC control and status)
     */
    .m_axil_csr_awaddr(),
    .m_axil_csr_awprot(),
    .m_axil_csr_awvalid(),
    .m_axil_csr_awready(1),
    .m_axil_csr_wdata(),
    .m_axil_csr_wstrb(),
    .m_axil_csr_wvalid(),
    .m_axil_csr_wready(1),
    .m_axil_csr_bresp(0),
    .m_axil_csr_bvalid(0),
    .m_axil_csr_bready(),
    .m_axil_csr_araddr(),
    .m_axil_csr_arprot(),
    .m_axil_csr_arvalid(),
    .m_axil_csr_arready(1),
    .m_axil_csr_rdata(0),
    .m_axil_csr_rresp(0),
    .m_axil_csr_rvalid(0),
    .m_axil_csr_rready(),

    /*
     * Control register interface
     */
    .ctrl_reg_wr_addr(ctrl_reg_wr_addr),
    .ctrl_reg_wr_data(ctrl_reg_wr_data),
    .ctrl_reg_wr_strb(ctrl_reg_wr_strb),
    .ctrl_reg_wr_en(ctrl_reg_wr_en),
    .ctrl_reg_wr_wait(ctrl_reg_wr_wait),
    .ctrl_reg_wr_ack(ctrl_reg_wr_ack),
    .ctrl_reg_rd_addr(ctrl_reg_rd_addr),
    .ctrl_reg_rd_en(ctrl_reg_rd_en),
    .ctrl_reg_rd_data(ctrl_reg_rd_data),
    .ctrl_reg_rd_wait(ctrl_reg_rd_wait),
    .ctrl_reg_rd_ack(ctrl_reg_rd_ack),

    /*
     * PTP clock
     */
    .ptp_clk(ptp_clk),
    .ptp_rst(ptp_rst),
    .ptp_sample_clk(ptp_sample_clk),
    .ptp_pps(ptp_pps),
    .ptp_pps_str(ptp_pps_str),
    .ptp_ts_96(ptp_ts_96),
    .ptp_ts_step(ptp_ts_step),
    .ptp_sync_pps(ptp_sync_pps),
    .ptp_sync_ts_96(ptp_sync_ts_96),
    .ptp_sync_ts_step(ptp_sync_ts_step),
    .ptp_perout_locked(ptp_perout_locked),
    .ptp_perout_error(ptp_perout_error),
    .ptp_perout_pulse(ptp_perout_pulse),

    /*
     * Ethernet
     */
    .eth_tx_clk(eth_tx_clk),
    .eth_tx_rst(eth_tx_rst),

    .eth_tx_ptp_clk(eth_tx_ptp_clk),
    .eth_tx_ptp_rst(eth_tx_ptp_rst),
    .eth_tx_ptp_ts_96(eth_tx_ptp_ts_96),
    .eth_tx_ptp_ts_step(eth_tx_ptp_ts_step),

    .m_axis_eth_tx_tdata(axis_eth_tx_tdata),
    .m_axis_eth_tx_tkeep(axis_eth_tx_tkeep),
    .m_axis_eth_tx_tvalid(axis_eth_tx_tvalid),
    .m_axis_eth_tx_tready(axis_eth_tx_tready),
    .m_axis_eth_tx_tlast(axis_eth_tx_tlast),
    .m_axis_eth_tx_tuser(axis_eth_tx_tuser),

    .s_axis_eth_tx_cpl_ts(axis_eth_tx_ptp_ts),
    .s_axis_eth_tx_cpl_tag(axis_eth_tx_ptp_ts_tag),
    .s_axis_eth_tx_cpl_valid(axis_eth_tx_ptp_ts_valid),
    .s_axis_eth_tx_cpl_ready(axis_eth_tx_ptp_ts_ready),

    .eth_tx_status(eth_tx_status),

    .eth_rx_clk(eth_rx_clk),
    .eth_rx_rst(eth_rx_rst),

    .eth_rx_ptp_clk(eth_rx_ptp_clk),
    .eth_rx_ptp_rst(eth_rx_ptp_rst),
    .eth_rx_ptp_ts_96(eth_rx_ptp_ts_96),
    .eth_rx_ptp_ts_step(eth_rx_ptp_ts_step),

    .s_axis_eth_rx_tdata(axis_eth_rx_tdata),
    .s_axis_eth_rx_tkeep(axis_eth_rx_tkeep),
    .s_axis_eth_rx_tvalid(axis_eth_rx_tvalid),
    .s_axis_eth_rx_tready(axis_eth_rx_tready),
    .s_axis_eth_rx_tlast(axis_eth_rx_tlast),
    .s_axis_eth_rx_tuser(axis_eth_rx_tuser),

    .eth_rx_status(eth_rx_status),

    /*
     * DDR
     */
    .ddr_clk(ddr_clk),
    .ddr_rst(ddr_rst),

    .m_axi_ddr_awid(m_axi_ddr_awid),
    .m_axi_ddr_awaddr(m_axi_ddr_awaddr),
    .m_axi_ddr_awlen(m_axi_ddr_awlen),
    .m_axi_ddr_awsize(m_axi_ddr_awsize),
    .m_axi_ddr_awburst(m_axi_ddr_awburst),
    .m_axi_ddr_awlock(m_axi_ddr_awlock),
    .m_axi_ddr_awcache(m_axi_ddr_awcache),
    .m_axi_ddr_awprot(m_axi_ddr_awprot),
    .m_axi_ddr_awqos(m_axi_ddr_awqos),
    .m_axi_ddr_awuser(),
    .m_axi_ddr_awvalid(m_axi_ddr_awvalid),
    .m_axi_ddr_awready(m_axi_ddr_awready),
    .m_axi_ddr_wdata(m_axi_ddr_wdata),
    .m_axi_ddr_wstrb(m_axi_ddr_wstrb),
    .m_axi_ddr_wlast(m_axi_ddr_wlast),
    .m_axi_ddr_wuser(),
    .m_axi_ddr_wvalid(m_axi_ddr_wvalid),
    .m_axi_ddr_wready(m_axi_ddr_wready),
    .m_axi_ddr_bid(m_axi_ddr_bid),
    .m_axi_ddr_bresp(m_axi_ddr_bresp),
    .m_axi_ddr_buser(0),
    .m_axi_ddr_bvalid(m_axi_ddr_bvalid),
    .m_axi_ddr_bready(m_axi_ddr_bready),
    .m_axi_ddr_arid(m_axi_ddr_arid),
    .m_axi_ddr_araddr(m_axi_ddr_araddr),
    .m_axi_ddr_arlen(m_axi_ddr_arlen),
    .m_axi_ddr_arsize(m_axi_ddr_arsize),
    .m_axi_ddr_arburst(m_axi_ddr_arburst),
    .m_axi_ddr_arlock(m_axi_ddr_arlock),
    .m_axi_ddr_arcache(m_axi_ddr_arcache),
    .m_axi_ddr_arprot(m_axi_ddr_arprot),
    .m_axi_ddr_arqos(m_axi_ddr_arqos),
    .m_axi_ddr_aruser(),
    .m_axi_ddr_arvalid(m_axi_ddr_arvalid),
    .m_axi_ddr_arready(m_axi_ddr_arready),
    .m_axi_ddr_rid(m_axi_ddr_rid),
    .m_axi_ddr_rdata(m_axi_ddr_rdata),
    .m_axi_ddr_rresp(m_axi_ddr_rresp),
    .m_axi_ddr_rlast(m_axi_ddr_rlast),
    .m_axi_ddr_ruser(0),
    .m_axi_ddr_rvalid(m_axi_ddr_rvalid),
    .m_axi_ddr_rready(m_axi_ddr_rready),

    .ddr_status(ddr_status),

    /*
     * HBM
     */
    .hbm_clk(0),
    .hbm_rst(0),

    .m_axi_hbm_awid(),
    .m_axi_hbm_awaddr(),
    .m_axi_hbm_awlen(),
    .m_axi_hbm_awsize(),
    .m_axi_hbm_awburst(),
    .m_axi_hbm_awlock(),
    .m_axi_hbm_awcache(),
    .m_axi_hbm_awprot(),
    .m_axi_hbm_awqos(),
    .m_axi_hbm_awuser(),
    .m_axi_hbm_awvalid(),
    .m_axi_hbm_awready(0),
    .m_axi_hbm_wdata(),
    .m_axi_hbm_wstrb(),
    .m_axi_hbm_wlast(),
    .m_axi_hbm_wuser(),
    .m_axi_hbm_wvalid(),
    .m_axi_hbm_wready(0),
    .m_axi_hbm_bid(0),
    .m_axi_hbm_bresp(0),
    .m_axi_hbm_buser(0),
    .m_axi_hbm_bvalid(0),
    .m_axi_hbm_bready(),
    .m_axi_hbm_arid(),
    .m_axi_hbm_araddr(),
    .m_axi_hbm_arlen(),
    .m_axi_hbm_arsize(),
    .m_axi_hbm_arburst(),
    .m_axi_hbm_arlock(),
    .m_axi_hbm_arcache(),
    .m_axi_hbm_arprot(),
    .m_axi_hbm_arqos(),
    .m_axi_hbm_aruser(),
    .m_axi_hbm_arvalid(),
    .m_axi_hbm_arready(0),
    .m_axi_hbm_rid(0),
    .m_axi_hbm_rdata(0),
    .m_axi_hbm_rresp(0),
    .m_axi_hbm_rlast(0),
    .m_axi_hbm_ruser(0),
    .m_axi_hbm_rvalid(0),
    .m_axi_hbm_rready(),

    .hbm_status(0),

    /*
     * Statistics input
     */
    .s_axis_stat_tdata(0),
    .s_axis_stat_tid(0),
    .s_axis_stat_tvalid(1'b0),
    .s_axis_stat_tready(),

    /*
     * GPIO
     */
    .app_gpio_in(0),
    .app_gpio_out(),

    /*
     * JTAG
     */
    .app_jtag_tdi(1'b0),
    .app_jtag_tdo(),
    .app_jtag_tms(1'b0),
    .app_jtag_tck(1'b0)
);

endmodule

`resetall
